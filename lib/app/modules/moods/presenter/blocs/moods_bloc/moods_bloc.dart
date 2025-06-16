import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/helper/enum_helper.dart';
import '../../../domain/usecases/get_moods_pulse_link_usecase.dart';
import '../../../enums/pulse_status_enum.dart';
import 'moods_event.dart';
import 'moods_state.dart';

class MoodsBloc extends Bloc<MoodsEvent, MoodsState> {
  final GetMoodsPulseLinkUsecase _getMoodsPulseLinkUsecase;

  MoodsBloc({
    required GetMoodsPulseLinkUsecase getMoodsPulseLinkUsecase,
  })  : _getMoodsPulseLinkUsecase = getMoodsPulseLinkUsecase,
        super(InitialMoodsState()) {
    on<GetMoodsEvent>(_getMoodsEvent);
  }

  Future<void> _getMoodsEvent(
    GetMoodsEvent event,
    Emitter<MoodsState> emit,
  ) async {
    emit(
      LoadingMoodsState(),
    );

    final moodsStatus = await _getMoodsPulseLinkUsecase.call(
      userId: event.userId,
    );

    moodsStatus.fold(
      (left) {
        return emit(ErrorMoodsState());
      },
      (right) {
        final pulseStatus = EnumHelper<PulseStatusEnum>().stringToEnum(
          stringToParse: right,
          values: PulseStatusEnum.values,
        );

        if (pulseStatus == PulseStatusEnum.pulseAnswered) {
          return emit(LoadedMoodsState(url: ''));
        }

        if (pulseStatus == PulseStatusEnum.pulseNotActive) {
          return emit(ErrorMoodsState());
        }

        return emit(
          LoadedMoodsState(url: right),
        );
      },
    );
  }
}
