class DataSourceResponseDto {
  final bool success;
  final String message;
  final int? statusCode;

  DataSourceResponseDto({
    required this.success,
    required this.message,
    this.statusCode,
  });
}
