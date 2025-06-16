import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/user_notification_setting_entity.dart';
import '../../../domain/input_models/toggle_notification_setting_input_model.dart';
import '../../../domain/usecases/get_user_notification_settings_usecase.dart';
import '../../../domain/usecases/toggle_user_notification_setting_usecase.dart';
import 'notification_settings_event.dart';
import 'notification_settings_state.dart';

class NotificationSettingsBloc extends Bloc<NotificationSettingsEvent, NotificationSettingsState> {
  final GetUserNotificationSettingsUsecase _getUserNotificationSettingsUsecase;
  final ToggleUserNotificationSettingUsecase _toggleUserNotificationSettingUsecase;

  NotificationSettingsBloc({
    required GetUserNotificationSettingsUsecase getUserNotificationSettingsUsecase,
    required ToggleUserNotificationSettingUsecase toggleUserNotificationSettingUsecase,
  })  : _getUserNotificationSettingsUsecase = getUserNotificationSettingsUsecase,
        _toggleUserNotificationSettingUsecase = toggleUserNotificationSettingUsecase,
        super(InitialNotificationSettingsState()) {
    on<GetNotificationSettingsEvent>(_getNotificationSettingsEvent);
    on<ToggleNotificationSettingsEvent>(_toggleNotificationSettingsEvent);
  }

  Future<void> _getNotificationSettingsEvent(
    GetNotificationSettingsEvent _,
    Emitter<NotificationSettingsState> emit,
  ) async {
    emit(LoadingNotificationSettingsState());

    final userNotificationsSettings = await _getUserNotificationSettingsUsecase.call();

    userNotificationsSettings.fold(
      (left) {
        emit(ErrorNotificationSettingsState());
      },
      (right) {
        emit(
          LoadedNotificationSettingsState(
            userNotificationSettings: right,
          ),
        );
      },
    );
  }

  Future<void> _toggleNotificationSettingsEvent(
    ToggleNotificationSettingsEvent event,
    Emitter<NotificationSettingsState> emit,
  ) async {
    emit(
      state.togglingNotificationSettingsState(
        userNotificationSettings: state.userNotificationSettings,
        userNotificationSetting: event.userNotificationSettingEntity,
      ),
    );

    final isToggled = await _toggleUserNotificationSettingUsecase.call(
      toggleNotificationSettingInputModel: ToggleNotificationSettingInputModel(
        notificationEnabled: !event.userNotificationSettingEntity.notificationEnabled,
        notificationType: event.userNotificationSettingEntity.notificationType,
      ),
    );

    isToggled.fold(
      (left) {
        emit(
          ErrorOnTogglingNotificationSettingsState(
            userNotificationSettings: state.userNotificationSettings,
            userNotificationSettingEntity: event.userNotificationSettingEntity,
          ),
        );
        emit(
          LoadedNotificationSettingsState(
            userNotificationSettings: state.userNotificationSettings,
          ),
        );
      },
      (right) {
        final newUserNotificationSettings = state.userNotificationSettings.map(
          (userNotificationSettingEntity) {
            if (userNotificationSettingEntity.id == event.userNotificationSettingEntity.id) {
              return UserNotificationSettingEntity(
                id: event.userNotificationSettingEntity.id,
                notificationType: event.userNotificationSettingEntity.notificationType,
                notificationEnabled: !event.userNotificationSettingEntity.notificationEnabled,
              );
            }
            return userNotificationSettingEntity;
          },
        ).toList();

        emit(
          ToggledNotificationSettingsState(
            userNotificationSettings: state.userNotificationSettings,
            userNotificationSettingEntity: event.userNotificationSettingEntity,
          ),
        );

        emit(
          LoadedNotificationSettingsState(
            userNotificationSettings: newUserNotificationSettings,
          ),
        );
      },
    );
  }
}
