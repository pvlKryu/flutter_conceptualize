import 'package:dio/dio.dart';

Future<T> checkNetErrors<T>(Future<T> Function() dioCall) async {
  try {
    return await dioCall();
  } catch (dioError) {
    switch (dioError) {
      case DioExceptionType.cancel:
        throw Exception('Request to API server was cancelled.');
      case DioExceptionType.connectionError:
        throw Exception('Connection timeout with API server.');
      case DioExceptionType.unknown:
        throw Exception('Connection to API server failed due to internet connection.');
      case DioExceptionType.receiveTimeout:
        throw Exception('Receive timeout in connection with API server.');
      case DioExceptionType.sendTimeout:
        throw Exception('Send timeout in connection with API server.');
      case DioExceptionType.badResponse:
        throw Exception('Received bad response from API server.');
      default:
        throw Exception('Something went wrong during communication with API server.');
    }
  }
}
