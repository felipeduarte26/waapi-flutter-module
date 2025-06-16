class HttpResponse {
  final String body;
  final int statusCode;

  const HttpResponse({
    required this.body,
    required this.statusCode,
  });
}
