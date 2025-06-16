import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart' as clock;
import 'package:mobile_authentication/mobile_authentication_service.dart' as auth;

import '../../../../../../../ponto_mobile_collector.dart';
import '../../../../../core/domain/entities/journey_entity.dart';
import '../../../../../core/domain/enums/clocking_event_use_type.dart';
import '../../../../../core/domain/input_model/clocking_event_register_type.dart';
import '../../../../../core/domain/input_model/location_dto.dart';
import '../../../../../core/domain/repositories/database/clocking_event_use_repository.dart';
import '../../../../../core/external/mappers/clocking_event_use_mapper.dart';
import '../../../../../core/external/mappers/configuration_mapper.dart';
import '../../../domain/usecases/get_total_time_since_last_journey_usecase.dart';

part 'drivers_journey_event.dart';
part 'drivers_journey_state.dart';

class DriversJourneyBloc extends Bloc<DriversJourneyEvent, DriversJourneyState> {
  final RegisterClockingEventBloc _registerClockingEventBloc;
  final ISessionService _sessionService;
  final IJourneyRepository _journeyRepository;
  final IClockingEventRepository _clockingEventRepository;
  final IUtils _utils;
  final IRegisterJourneyUsecase _registerJourneyUsecase;
  final IRegisterOvernightUsecase _registerOvernightUsecase;
  final IFinishJourneyUsecase _finishJourneyUsecase;
  final ClockingEventUseRepository _clockingEventUseRepository;
  final clock.IInternalClockService _internalClockService;
  final IConfigurationRepository _configurationRepository;
  final IPlatformService _platformService;
  final GetTotalTimeSinceLastJourneyUseCase _getTotalTimeSinceLastJourneyUseCase;
  late final List<auth.ClockingEventUseDTO> _clockingEventUses = [];

  StateLocationEntity? stateLocationEntity;

  StreamSubscription<RegisterClockingState>? _registerClockingEventBlocSubscription;
  JourneyEntity? currentJourney;
  DriversJourneyEvent? driverEventInExecution;
  int clockingEventsInJourney = 0;
  int totalBreaks = 0;
  auth.LoginConfigurationDTO? configurationDTO;
  bool showMandatoryBreakButton = false;
  bool showWaitingButton = false;
  bool showDrivingButton = false;
  List<DriversJourneyEvent> pendingClockingEvents = [];
  bool isToAddEmitNewActionStartedAndPreviousDoesNot = false;
  bool isToAddEmitPreviousActionFinishedAndNewStarted = false;
  DriversJourneyEvent? newAction;
  Duration? totalTimeSinceLastJourneyUseCase;
  DriversJourneyEvent? eventToAddAfterFinishClockingEvents;
  DateTime? whenWorkStarted;
  bool isOddClockingEvents = false;
  Duration totalWorked = Duration.zero;
  Duration differenceBetweenWhenWorkStartedAndWhenJourneyStarted = Duration.zero;
  Duration totalMealBreakDuration = Duration.zero;
  Duration totalMandatoryBreakDuration = Duration.zero;

  DriversJourneyBloc(
    this._registerClockingEventBloc,
    this._sessionService,
    this._journeyRepository,
    this._clockingEventRepository,
    this._utils,
    this._registerJourneyUsecase,
    this._registerOvernightUsecase,
    this._finishJourneyUsecase,
    this._clockingEventUseRepository,
    this._internalClockService,
    this._configurationRepository,
    this._platformService,
    this._getTotalTimeSinceLastJourneyUseCase,
  ) : super(
          InitialDriversJourneyState(),
        ) {
    _platformService.getLocation().then((value) => stateLocationEntity = value);
    registerListerToClockingEvent();
    on<LoadJourneyEvent>(loadContent);
    on<StartJourneyEvent>(handleEvents);
    on<ConfirmStartJourneyBeforeAction>(handleStartJourneyFromAction);
    on<StartActionWithoutJourney>(handleStartJourneyFromAction);
    on<EmitJourneyStartedBeforeAction>(handleJourneyStartedFromAction);
    on<EmitActionStartedWithoutJourney>(handleJourneyStartedFromAction);
    on<EndJourneyEvent>(handleEvents);
    on<ConfirmCloseActionBeforeEndJourney>(handleEndJourneyWithActionRunning);
    on<FinishJourneyAndPreviousActionDoesNot>(
      handleEndJourneyWithActionRunning,
    );
    on<EmitJourneyFinishedAndPreviousActionDoesNot>(
      handleJourneyEndedWithActionRunning,
    );
    on<EmitPreviousActionClosedAndJourneyEnded>(
      handleJourneyEndedWithActionRunning,
    );
    on<StartDrivingEvent>(handleEvents);
    on<StopDrivingEvent>(handleEvents);
    on<StartMandatoryBreakEvent>(handleEvents);
    on<EndMandatoryBreakEvent>(handleEvents);
    on<StartLunchEvent>(handleEvents);
    on<EndLunchEvent>(handleEvents);
    on<StartWaitingBreakEvent>(handleEvents);
    on<EndWaitingBreakEvent>(handleEvents);
    on<ConfirmClosePreviousAction>(handleEvents);
    on<EmitNewActionStartedAndPreviousDoesNot>(handleAfterChangeAction);
    on<EmitPreviousActionFinishedAndNewStarted>(handleAfterChangeAction);
    on<DoNothing>(handleDoNothing);
    on<ClockingEventFinish>(handleClockingEventFinish);
  }

  Map<String, DriversJourneyEvent>? currentEvent;

  void onSaveCurrentEvent(Map<String, DriversJourneyEvent>? event) => currentEvent = event;

  void loadContent(event, emit) async {
    emit(LoadingDriversJourneyState());

    totalTimeSinceLastJourneyUseCase = await _getTotalTimeSinceLastJourneyUseCase.call();

    var employeeId = _sessionService.getEmployeeId();

    configurationDTO =
        ConfigurationMapper.fromEntityToDtoAuth(await _configurationRepository.findByEmployeeId(employeeId: employeeId));

    var findAllByEmployeeId = await _clockingEventUseRepository.findAllByEmployeeId(employeeId: employeeId);

    _clockingEventUses.addAll(ClockingEventUseMapper.fromEntityToDtoAuthList(
      findAllByEmployeeId,
    )!,);

    showDrivingButton = _clockingEventUses.any(
      (element) => element.clockingEventUseType.value == auth.ClockingEventUseType.driving.value,
    );

    showMandatoryBreakButton = _clockingEventUses.any(
      (element) => element.clockingEventUseType.value == auth.ClockingEventUseType.mandatoryBreak.value,
    );

    showWaitingButton = _clockingEventUses.any(
      (element) => element.clockingEventUseType.value == auth.ClockingEventUseType.waiting.value,
    );

    currentJourney = await _journeyRepository.findCurrentJourneyByEmployeeId(
      employeeId: employeeId,
    );

    if (currentJourney == null) {
      emit(
        NotStartedDriversJourneyState(),
      );
      return;
    }

    await calculateTotalWorked();

    emit(
      await calculateActualJourney(
        currentJourney,
      ),
    );
  }

  void handleDoNothing(event, emit) async {
    var toEmit = await calculateActualJourney(currentJourney);
    emit(toEmit);
  }

  void handleEvents(event, emit) async {
    if (event is ConfirmClosePreviousAction) {
      emit(RegisteringClockingEvent());

      pendingClockingEvents.addAll(event.toExecute);

      final element = pendingClockingEvents.removeAt(0);

      driverEventInExecution = element;

      if (pendingClockingEvents.isEmpty) {
        eventToAddAfterFinishClockingEvents = EmitNewActionStartedAndPreviousDoesNot(
          newAction: element,
        );
      } else {
        eventToAddAfterFinishClockingEvents = EmitPreviousActionFinishedAndNewStarted(
          newAction: pendingClockingEvents.last,
        );
      }

      registerClockingEventDriversJourney(
        clockingEventUse: getClockingEventUse(element.use),
        mealBreak: element is StartLunchEvent || element is EndLunchEvent,
        eventToSave: element,
      );

      return;
    }

    if (driverEventInExecution != null) {
      if (currentJourney != null && event is StartJourneyEvent && !event.force) {
        emit(
          StartNewDriverJourney(
            toExecute: StartJourneyEvent(force: true),
          ),
        );
        return;
      }

      if (driverEventInExecution!.startAction && event.startAction) {
        emit(
          CallingModalToClosePrevious(
            toClose: driverEventInExecution!,
            actual: event,
          ),
        );
        return;
      }

      if (event is EndJourneyEvent) {
        if (!event.closeJourney) {
          if (driverEventInExecution!.startAction) {
            emit(
              CallingModalToCloseActionBeforeEndJourney(
                action: driverEventInExecution!,
              ),
            );

            return;
          }

          var overnight = configurationDTO?.overnight ?? false;
          if (overnight) {
            emit(
              CallingOvernight(),
            );

            return;
          }
        }

        final element = pendingClockingEvents.isNotEmpty ? pendingClockingEvents.removeAt(0) : event;

        driverEventInExecution = event;

        registerClockingEventDriversJourney(
          clockingEventUse: getClockingEventUse(element.use),
          mealBreak: element is StartLunchEvent || element is EndLunchEvent,
          eventToSave: element,
        );

        return;
      }
    }

    if (currentJourney != null && event is StartJourneyEvent) {
      await endJourney(
        _internalClockService.getClockDateTime(),
        currentJourney!.id,
      );
      currentJourney = await initJourney();
    }

    if (currentJourney == null && event is! StartJourneyEvent) {
      emit(
        CallingModalToStartJourneyFromAction(
          action: event,
        ),
      );
      return;
    }

    currentJourney ??= await initJourney();

    emit(RegisteringClockingEvent());

    driverEventInExecution = event;

    registerClockingEventDriversJourney(
      clockingEventUse: getClockingEventUse(event.use),
      mealBreak: event is StartLunchEvent || event is EndLunchEvent,
    );
  }

  void handleStartJourneyFromAction(event, emit) async {
    emit(RegisteringClockingEvent());

    pendingClockingEvents.addAll([
      if (event is ConfirmStartJourneyBeforeAction) //
        StartJourneyEvent(),
      event.action,
    ]);

    currentJourney ??= await initJourney();

    final element = pendingClockingEvents.removeAt(0);

    if (pendingClockingEvents.isEmpty) {
      eventToAddAfterFinishClockingEvents = EmitActionStartedWithoutJourney(
        action: element,
      );
    } else {
      eventToAddAfterFinishClockingEvents = EmitJourneyStartedBeforeAction(
        action: pendingClockingEvents.last,
      );
    }

    registerClockingEventDriversJourney(
      clockingEventUse: getClockingEventUse(element.use),
      mealBreak: element is StartLunchEvent || element is EndLunchEvent,
      eventToSave: element,
    );

    return;
  }

  void handleJourneyStartedFromAction(event, emit) {
    final element = event.action;

    switch (event) {
      case EmitJourneyStartedBeforeAction():
        emit(
          JourneyStartedBeforeAction(
            action: element,
          ),
        );

        break;

      case EmitActionStartedWithoutJourney():
        emit(
          ActionStartedWithoutJourney(
            action: element,
          ),
        );

        break;
    }
  }

  void handleAfterChangeAction(event, emit) {
    final element = event.newAction;

    switch (event) {
      case EmitNewActionStartedAndPreviousDoesNot():
        emit(
          NewActionStartedAndPreviousDoesNot(
            previousAction: currentEvent!['previous']!,
            newAction: element,
          ),
        );

        break;

      case EmitPreviousActionFinishedAndNewStarted():
        emit(
          PreviousActionFinishedAndNewStarted(
            previousAction: currentEvent!['previous']!,
            newAction: element,
          ),
        );

        break;
    }
  }

  void handleEndJourneyWithActionRunning(event, emit) {
    emit(RegisteringClockingEvent());

    final action = event.action;

    pendingClockingEvents.addAll([
      if (event is ConfirmCloseActionBeforeEndJourney) //
        action,
      EndJourneyEvent(),
    ]);

    if (pendingClockingEvents.length == 1) {
      eventToAddAfterFinishClockingEvents = EmitJourneyFinishedAndPreviousActionDoesNot(
        action: action,
      );
    } else {
      eventToAddAfterFinishClockingEvents = EmitPreviousActionClosedAndJourneyEnded(
        action: action,
      );
    }

    var overnight = configurationDTO?.overnight ?? false;
    if (overnight) {
      emit(
        CallingOvernight(),
      );

      return;
    }

    final element = pendingClockingEvents.removeAt(0);

    registerClockingEventDriversJourney(
      clockingEventUse: getClockingEventUse(element.use),
      mealBreak: element is StartLunchEvent || element is EndLunchEvent,
      eventToSave: element,
    );

    return;
  }

  void handleJourneyEndedWithActionRunning(event, emit) {
    final element = event.action;

    driverEventInExecution = EndJourneyEvent();

    switch (event) {
      case EmitPreviousActionClosedAndJourneyEnded():
        emit(
          PreviousActionClosedAndJourneyEnded(
            action: element,
          ),
        );

        break;

      case EmitJourneyFinishedAndPreviousActionDoesNot():
        emit(
          JourneyFinishedAndPreviousActionDoesNot(
            action: element,
          ),
        );

        break;
    }
  }

  void handleClockingEventFinish(event, emit) async {
    await calculateTotalWorked();

    if (driverEventInExecution is EndJourneyEvent) {
      emit(
        NotStartedDriversJourneyState(),
      );
      return;
    }

    if (driverEventInExecution is StartJourneyEvent) {
      emit(
        StartedDriversJourneyState(
          journeyStartedDateTime: currentJourney!.startDate,
          dateTimeOfLastStatusStarted: event.dateTimeEvent!,
          driversJourneyEvent: driverEventInExecution,
        ),
      );
      return;
    }

    if (driverEventInExecution != null && (driverEventInExecution is StartLunchEvent || driverEventInExecution is StartMandatoryBreakEvent)) {
      totalBreaks += 1;
    }

    var toEmit = StartedDriversJourneyState(
      journeyStartedDateTime: currentJourney!.startDate,
      dateTimeOfLastStatusStarted: event.dateTimeEvent!,
      driversJourneyEvent: driverEventInExecution,
    ).copyWith(
      isLoading: false,
      driversJourneyEvent: driverEventInExecution,
    );

    emit(toEmit);
  }

  Future<JourneyEntity> initJourney() async {
    var clockDateTime = _internalClockService.getClockDateTime();

    return await _registerJourneyUsecase.call(dateTimeEvent: clockDateTime);
  }

  Future<JourneyEntity> endJourney(
    DateTime dateTimeEvent,
    String journeyId, {
    String? overnightId,
  }) async {
    return await _finishJourneyUsecase.call(
      journeyId: journeyId,
      dateTimeEvent: dateTimeEvent,
      overnightId: overnightId,
    );
  }

  Future<void> rollbackJourney() async {
    if (currentJourney != null) {
      await _journeyRepository.delete(id: currentJourney!.id);
      totalTimeSinceLastJourneyUseCase = null;
      currentJourney = null;
    }
  }

  void registerClockingEventDriversJourney({
    auth.ClockingEventUseDTO? clockingEventUse,
    required bool mealBreak,
    DriversJourneyEvent? eventToSave,
  }) {
    _registerClockingEventBloc.add(
      NewRegisterEvent(
        clockingEventRegisterType: ClockingEventRegisterTypeDriver(
          journeyId: currentJourney!.id,
          clockingEventUse: //_utils.toClockingEventUseEnum(
            ClockingEventUseType.build(clockingEventUse!.clockingEventUseType.value),
         // ),
          isMealBreak: mealBreak,
          journeyEventName: eventToSave != null ? eventToSave.runtimeType.toString() : driverEventInExecution!.runtimeType.toString(),
        ),
        stateLocationEntity: stateLocationEntity,
      ),
    );
  }

  void registerListerToClockingEvent() {
    _registerClockingEventBlocSubscription = _registerClockingEventBloc.stream.listen(
      (state) async {
        if (state is RegisterClockingInProgressState) {
          return;
        }

        if (state is RegistrationCanceledState) {
          pendingClockingEvents.clear();
          eventToAddAfterFinishClockingEvents = null;

          if (clockingEventsInJourney == 0) {
            await rollbackJourney();
          }

          await calculateTotalWorked();

          add(DoNothing());
          return;
        }

        if (state is SuccessRegisterState) {
          clockingEventsInJourney += 1;

          if (pendingClockingEvents.isNotEmpty) {
            final element = pendingClockingEvents.removeAt(0);

            driverEventInExecution = element;

            registerClockingEventDriversJourney(
              clockingEventUse: getClockingEventUse(element.use),
              mealBreak: element is StartLunchEvent || element is EndLunchEvent,
              eventToSave: element,
            );
          } else {
            if (eventToAddAfterFinishClockingEvents != null) {
              add(eventToAddAfterFinishClockingEvents!);

              eventToAddAfterFinishClockingEvents = null;
            }

            if (driverEventInExecution is EndJourneyEvent && currentJourney != null) {
              if (driverEventInExecution is EndJourneyEvent && (driverEventInExecution as EndJourneyEvent).overnight) {
                var overnightEntity = await _registerOvernightUsecase.call(
                  employeeId: _sessionService.getEmployeeId(),
                  dateTimeEvent: state.clockingEvent.getDateTimeEvent(),
                  manual: false,
                  locationDTO: LocationDto.fromCollectorDtoToClock(state.clockingEvent.location),
                  locationStatus: clock.LocationStatusEnum.build(state.clockingEvent.locationStatus!.id),
                );
                await endJourney(
                  state.clockingEvent.getDateTimeEvent(),
                  currentJourney!.id,
                  overnightId: overnightEntity.id,
                );
              } else {
                await endJourney(
                  state.clockingEvent.getDateTimeEvent(),
                  currentJourney!.id,
                );
              }

              currentJourney = null;
              totalTimeSinceLastJourneyUseCase = null;
              totalBreaks = 0;
            }

            add(
              ClockingEventFinish(
                state.clockingEvent.getDateTimeEvent(),
              ),
            );
          }
        }
      },
    );
  }

  auth.ClockingEventUseDTO? getClockingEventUse(
    auth.ClockingEventUseType clockingEventUseType,
  ) {
    if (_clockingEventUses.isEmpty) {
      return null;
    }
    return _clockingEventUses.firstWhere((element) {
      return element.clockingEventUseType.value == clockingEventUseType.value;
    });
  }

  auth.ClockingEventUseDTO? getClockingEventUseByCode(
    String code,
  ) {
    if (_clockingEventUses.isEmpty) {
      return null;
    }
    return _clockingEventUses.firstWhere(
      (element) => element.code == code,
    );
  }

  Duration getTotalWorkedAtMoment(DateTime currentTimeFromInternalClock) {
    if (currentJourney == null || whenWorkStarted == null) {
      return Duration.zero;
    }

    if (isOddClockingEvents) {
      return Duration.zero;
    }

    if (driverEventInExecution case StartLunchEvent() || StartMandatoryBreakEvent()) {
      return totalWorked;
    }

    return currentTimeFromInternalClock
        .add(differenceBetweenWhenWorkStartedAndWhenJourneyStarted)
        .subtract(totalMealBreakDuration)
        .subtract(totalMandatoryBreakDuration)
        .difference(whenWorkStarted!);
  }

  bool isMandatoryBreak(ClockingEvent clockingEvent) {
    final clockingEventUsesFiltered = _clockingEventUses.where(
      (element) => element.code == clockingEvent.use && element.clockingEventUseType == auth.ClockingEventUseType.mandatoryBreak,
    );

    return clockingEventUsesFiltered.isNotEmpty;
  }

  Future<void> defineWhenWorkStarted() async {
    if (currentJourney == null) {
      whenWorkStarted = null;

      return;
    }

    if (whenWorkStarted != null) {
      return;
    }

    final journeyClockingEvents = await getJourneyClockingEvents(
      currentJourney!,
    );

    if (journeyClockingEvents.isEmpty) {
      return;
    }

    final firstClockingEvent = journeyClockingEvents.first;

    if (firstClockingEvent.isMealBreak || isMandatoryBreak(firstClockingEvent)) {
      if (journeyClockingEvents.length > 1) {
        whenWorkStarted = journeyClockingEvents.elementAt(1).getDateTimeEvent();
      }

      return;
    }

    whenWorkStarted = firstClockingEvent.getDateTimeEvent();
  }

  Future<void> defineIsOddClockingEvents() async {
    if (currentJourney == null || driverEventInExecution == null) {
      isOddClockingEvents = false;

      return;
    }

    if (isOddClockingEvents) {
      return;
    }

    final journeyClockingEvents = await getJourneyClockingEvents(
      currentJourney!,
    );

    if (journeyClockingEvents.length < 2) {
      isOddClockingEvents = false;

      return;
    }

    final mealBreaksLength = journeyClockingEvents.where((element) => element.isMealBreak).length;
    final mandatoryBreaksLength = journeyClockingEvents.where(isMandatoryBreak).length;

    if (driverEventInExecution is StartLunchEvent) {
      isOddClockingEvents = !_utils.isEven(mandatoryBreaksLength);

      return;
    }

    if (driverEventInExecution is StartMandatoryBreakEvent) {
      isOddClockingEvents = !_utils.isEven(mealBreaksLength);

      return;
    }

    isOddClockingEvents = !_utils.isEven(mealBreaksLength) || !_utils.isEven(mandatoryBreaksLength);
  }

  Future<void> defineDifferenceBetweenWhenWorkStartedAndWhenJourneyStarted() async {
    if (currentJourney == null || whenWorkStarted == null) {
      differenceBetweenWhenWorkStartedAndWhenJourneyStarted = Duration.zero;

      return;
    }

    final journeyClockingEvents = await getJourneyClockingEvents(
      currentJourney!,
    );

    if (journeyClockingEvents.isEmpty) {
      differenceBetweenWhenWorkStartedAndWhenJourneyStarted = Duration.zero;

      return;
    }

    final firstClockingEvent = journeyClockingEvents.first;

    differenceBetweenWhenWorkStartedAndWhenJourneyStarted = whenWorkStarted!.difference(firstClockingEvent.getDateTimeEvent());
  }

  Future<void> defineTotalMealBreakDuration() async {
    totalMealBreakDuration = Duration.zero;

    if (currentJourney == null) {
      return;
    }

    final journeyClockingEvents = await getJourneyClockingEvents(
      currentJourney!,
    );

    final mealBreaks = journeyClockingEvents.where(
      (element) => element.isMealBreak,
    );

    if (mealBreaks.isEmpty) {
      return;
    }

    mealBreaks.toList().asMap().forEach(
      (index, value) {
        if (index % 2 != 0) {
          final currentDateTimeEvent = mealBreaks.elementAt(index).getDateTimeEvent();
          final previousDateTimeEvent = mealBreaks.elementAt(index - 1).getDateTimeEvent();

          totalMealBreakDuration += currentDateTimeEvent.difference(
            previousDateTimeEvent,
          );
        }
      },
    );
  }

  Future<void> defineTotalMandatoryBreakDuration() async {
    totalMandatoryBreakDuration = Duration.zero;

    if (currentJourney == null) {
      return;
    }

    final journeyClockingEvents = await getJourneyClockingEvents(
      currentJourney!,
    );

    final mandatoryBreaks = journeyClockingEvents.where(isMandatoryBreak);

    if (mandatoryBreaks.isEmpty) {
      return;
    }

    mandatoryBreaks.toList().asMap().forEach(
      (index, value) {
        if (index % 2 != 0) {
          final currentDateTimeEvent = mandatoryBreaks.elementAt(index).getDateTimeEvent();
          final previousDateTimeEvent = mandatoryBreaks.elementAt(index - 1).getDateTimeEvent();

          totalMandatoryBreakDuration += currentDateTimeEvent.difference(
            previousDateTimeEvent,
          );
        }
      },
    );
  }

  Future<void> defineTotalWorked() async {
    if (currentJourney == null ||
        whenWorkStarted == null ||
        driverEventInExecution is! StartLunchEvent && driverEventInExecution is! StartMandatoryBreakEvent) {
      totalWorked = Duration.zero;

      return;
    }

    final journeyClockingEvents = await getJourneyClockingEvents(
      currentJourney!,
    );

    journeyClockingEvents.retainWhere(
      (element) => element.isMealBreak || isMandatoryBreak(element),
    );

    if (journeyClockingEvents.isEmpty) {
      totalWorked = Duration.zero;

      return;
    }

    if (journeyClockingEvents.length % 2 == 0) {
      journeyClockingEvents.removeLast();
    }

    final lastDateTimeToCalculate = journeyClockingEvents.last.getDateTimeEvent();

    totalWorked = lastDateTimeToCalculate
        .add(differenceBetweenWhenWorkStartedAndWhenJourneyStarted)
        .subtract(totalMealBreakDuration)
        .subtract(totalMandatoryBreakDuration)
        .difference(whenWorkStarted!);
  }

  Future<void> calculateTotalWorked() async {
    await defineIsOddClockingEvents();

    if (isOddClockingEvents) {
      return;
    }

    await defineWhenWorkStarted();
    await defineDifferenceBetweenWhenWorkStartedAndWhenJourneyStarted();
    await defineTotalMealBreakDuration();
    await defineTotalMandatoryBreakDuration();
    await defineTotalWorked();
  }

  Future<DriversJourneyState> calculateActualJourney(
    JourneyEntity? currentJourney,
  ) async {
    if (currentJourney == null) {
      driverEventInExecution = null;
      return NotStartedDriversJourneyState();
    }

    final findAllByJourneyId = await getJourneyClockingEvents(currentJourney);

    if (findAllByJourneyId.isEmpty) {
      await rollbackJourney();
      driverEventInExecution = null;
      return NotStartedDriversJourneyState();
    }

    final lastClockingEvent = findAllByJourneyId.last;

    try {
      driverEventInExecution =
          ClassFactory.createInstance(lastClockingEvent.journeyEventName!);
      log('Setting driverEventInExecution as $driverEventInExecution');
    } catch (e) {
      log('Error: $e, setting JourneyInExecution as driverEventInExecution');
      driverEventInExecution = JourneyInExecution();
    }

    await calculateTotalWorked();

    totalBreaks = findAllByJourneyId
        .where(
          (e) => (e.journeyEventName == 'StartMandatoryBreakEvent' || e.journeyEventName == 'StartLunchEvent'),
        )
        .toList()
        .length;

    return StartedDriversJourneyState(
      journeyStartedDateTime: currentJourney.startDate,
      dateTimeOfLastStatusStarted: lastClockingEvent.getDateTimeEvent(),
      driversJourneyEvent: driverEventInExecution,
    );
  }

  Future<List<ClockingEvent>> getJourneyClockingEvents(
    JourneyEntity currentJourney,
  ) async {
    final allClockingEvents = await _clockingEventRepository.findAllClockingEventByJourneyId(journeyId: currentJourney.id);

    return allClockingEvents;
  }

  @override
  Future<void> close() {
    _registerClockingEventBlocSubscription?.cancel();

    return super.close();
  }
}

class ClassFactory {
  static final Map<String, Function> _constructors = {
    'StartJourneyEvent': () => StartJourneyEvent(),
    'StartDrivingEvent': () => StartDrivingEvent(),
    'StopDrivingEvent': () => StopDrivingEvent(),
    'StartMandatoryBreakEvent': () => StartMandatoryBreakEvent(),
    'EndMandatoryBreakEvent': () => EndMandatoryBreakEvent(),
    'StartLunchEvent': () => StartLunchEvent(),
    'EndLunchEvent': () => EndLunchEvent(),
    'StartWaitingBreakEvent': () => StartWaitingBreakEvent(),
    'EndWaitingBreakEvent': () => EndWaitingBreakEvent(),
  };

  static dynamic createInstance(String className) {
    if (_constructors.containsKey(className)) {
      return _constructors[className]!();
    } else {
      throw Exception('Class not found');
    }
  }
}
