import 'package:bank_list/core/api/data/api_consts.dart';
import 'package:bank_list/core/api/data/api_data_source.dart';
import 'package:dio/dio.dart';

class AppBuilder {

  AppBuilder._();

  static IApiDataSource buildApiDataSource() {
    final dio = Dio();
    dio.options.baseUrl = ApiConsts.baseUrl;
    dio.options.headers = {
      Headers.contentTypeHeader : Headers.jsonContentType,
    };
    return ApiDataSource(dio);
  }

}