import 'package:dio/dio.dart';

class NetworkErrorHelper {
  static String fromDioError(DioException dioError) {
    String errorMessage = '';
    switch (dioError.type) {
      case DioExceptionType.cancel:
        errorMessage =
            'Sorry, the request to the server was canceled. Please try again.';
        break;
      case DioExceptionType.connectionTimeout:
        errorMessage = 'Sorry, the connection timed out. Please try again.';
        break;
      case DioExceptionType.receiveTimeout:
        errorMessage =
            'Sorry, the time to receive data has expired. Please try again.';
        break;
      case DioExceptionType.sendTimeout:
        errorMessage =
            'Sorry, the request could not be sent due to timeout. Please try again.';
        break;
      case DioExceptionType.badResponse:
        errorMessage = _handleStatusCode(dioError.response?.statusCode);
        break;
      case DioExceptionType.unknown:
        if ((dioError.message ?? '').contains('SocketException')) {
          errorMessage = 'No internet connection. Please try again.';
          break;
        }
        errorMessage = 'Sorry, an unexpected error occurred. Please try again.';
        break;
      default:
        errorMessage = 'A system error occurred. Please try again.';
        break;
    }
    return errorMessage;
  }

  static String _handleStatusCode(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'Sorry, the request is invalid or cannot be processed. Please try again.';
      case 401:
        return 'Sorry, authentication failed. Please try again.';
      case 403:
        return 'Sorry, the authenticated user is not allowed to access the specified API endpoint. Please try again.';
      case 404:
        return 'Sorry, the resource you are looking for was not found (Error 404). Please try again.';
      case 405:
        return 'Sorry, the method used is not allowed. Please check the "Allow" header to see the permitted HTTP methods. Please try again.';
      case 415:
        return 'Sorry, the requested media type is not supported. The requested content type or version number is invalid. Please try again.';
      case 422:
        return 'Sorry, data validation failed. Please try again.';
      case 429:
        return 'Sorry, too many requests. Please try again.';
      case 500:
        return 'Sorry, an internal server error occurred. Please try again.';
      default:
        return 'Sorry, an unexpected error occurred. Please try again.';
    }
  }
}
