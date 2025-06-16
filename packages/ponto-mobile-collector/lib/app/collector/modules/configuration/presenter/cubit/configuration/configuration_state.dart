abstract class ConfigurationBaseState {}

class LoadingContentState implements ConfigurationBaseState {}

class ReadContentState implements ConfigurationBaseState {}

class LogActiveState implements ConfigurationBaseState {}

class LogInactiveState implements ConfigurationBaseState {}

class LoadSyncLogsApiState implements ConfigurationBaseState {}

class ReadSyncLogsApiState implements ConfigurationBaseState {}

class SuccessSyncLogsApiState implements ConfigurationBaseState {}

class PartialSuccessSyncLogs implements ConfigurationBaseState {}

class FaliedSyncLogsApiState implements ConfigurationBaseState {}

class UnexpectedErrorSyncLogsApiState implements ConfigurationBaseState {}

class NoConnectionSyncLogsApiState implements ConfigurationBaseState {}

class NoLogsToSyncState implements ConfigurationBaseState {}

class HasNoConectionHelpCenterState implements ConfigurationBaseState {}
