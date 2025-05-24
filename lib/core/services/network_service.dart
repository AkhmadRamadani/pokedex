import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:rama_poke_app/core/constants/api_constant.dart';
import 'package:rama_poke_app/core/helpers/network_error_helper.dart';

class NetworkService {
  NetworkService._();

  static NetworkService? _instance;

  Dio _dioCall() {
    Dio dio = Dio();
    dio.options.baseUrl = ApiConstant.baseUrl;
    dio.options.connectTimeout = const Duration(seconds: 20);
    dio.options.receiveTimeout = const Duration(seconds: 20);
    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.headers['Accept'] = 'application/json';

    return dio;
  }

  static Dio call() {
    _instance ??= NetworkService._();
    return _instance!._dioCall();
  }

  static Future<Either<String, Response>> request(
    Future<Response> Function(Dio dio) requestFunction,
  ) async {
    try {
      final dio = call();
      final response = await requestFunction(dio);
      return Right(response);
    } on DioException catch (dioError) {
      final errorMessage = NetworkErrorHelper.fromDioError(dioError);
      return Left(errorMessage);
    } catch (e) {
      const fallbackMessage =
          'Terjadi kesalahan tidak terduga. Silakan coba lagi.';
      return Left(fallbackMessage);
    }
  }
}
