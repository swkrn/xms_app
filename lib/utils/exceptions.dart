class APIException implements Exception {
  const APIException({
    required this.message,
    required this.statusCode,
  });

  final String message;
  final int statusCode;

  String get errorMessage => '$message ($statusCode)';
}