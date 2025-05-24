import 'package:dio/dio.dart';
import 'package:rama_poke_app/core/constants/api_constant.dart';

class NetworkService {
  NetworkService._();

  static NetworkService? _instance;

  Dio _dioCall({String? customToken}) {
    Dio dio = Dio();
    dio.options.baseUrl = ApiConstant.baseUrl;
    dio.options.connectTimeout = const Duration(seconds: 20);
    dio.options.receiveTimeout = const Duration(seconds: 20);
    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.headers['Accept'] = 'application/json';

    return dio;
  }

  static Dio call({String? customToken}) {
    _instance ??= NetworkService._();
    return _instance!._dioCall(customToken: customToken);
  }
}
