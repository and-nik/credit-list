class ApiException implements Exception {
  final ApiExceptionType type;
  final String? message;

  ApiException({
    required this.type,
    this.message,
  });

  @override
  String toString() {
    return message ?? "No message";
  }

}

enum ApiExceptionType {
  noConnection,
  noResponse,
  /// 400
  noData,
  invalidRequest,
  invalidResponse, /// Also for 500
  /// 401
  invalidEmailOrPassword,
  /// 404
  userNotFound,
  /// other
  unexpected,
}