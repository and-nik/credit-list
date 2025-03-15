import 'dart:convert';

import 'package:bank_list/core/api/model/api_credit_model.dart';
import 'package:bank_list/util/core/result.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

import '../model/api_exception.dart';
import 'api_consts.dart';

abstract class IApiDataSource {
  Future<Result<List<ApiCreditModel>>> loadCredits();
}

class ApiDataSource implements IApiDataSource {

  final Dio _dio;

  ApiDataSource(Dio dio): _dio = dio;

  @override
  Future<Result<List<ApiCreditModel>>> loadCredits() async {
    try {
      /// like network request, but i
      /// dont create server for this project
      /// final resp = await _dio.get(ApiConsts.endpointCredits,);

      await Future.delayed(const Duration(seconds: 1));
      final jsonString = await rootBundle.loadString(ApiConsts.endpointCreditsJson);
      final json = jsonDecode(jsonString);
      final credits = (json["result"] as List)
          .map((e) => ApiCreditModel.fromJson(e),)
          .toList();
      return Success(credits);
    } on Exception catch(e) {
      return Failure(_handleError(e));
    }
  }

  Exception _handleError(Exception e) {
    if (e is DioException) {
      switch (e.type) {
        case DioExceptionType.connectionError:
          return ApiException(type: ApiExceptionType.noConnection);
        case DioExceptionType.badResponse:
          final resp = e.response;
          if (resp == null) return ApiException(type: ApiExceptionType.noResponse, message: e.message);
          switch (resp.statusCode) {
            case 400:
              final data = resp.data;
              if (data == null) return ApiException(type: ApiExceptionType.invalidResponse);
              try {
                final res = resp.data as Map<String, dynamic>;
                final type = res["type"] as String;
                switch (type) {
                  case "SOME_ERROR":
                    return ApiException(type: ApiExceptionType.invalidRequest);
                  default:
                    return ApiException(type: ApiExceptionType.invalidResponse);
                }
              } catch (e) {
                return Exception(e);
              }
            case 401:
              return ApiException(type: ApiExceptionType.invalidEmailOrPassword);
            case 404:
              final data = resp.data;
              if (data == null) return ApiException(type: ApiExceptionType.invalidResponse);
              try {
                final res = resp.data as Map<String, dynamic>;
                final type = res["type"] as String;
                switch (type) {
                  case "USER_NOT_FOUND":
                    return ApiException(type: ApiExceptionType.userNotFound);
                  default:
                    return ApiException(type: ApiExceptionType.invalidResponse);
                }
              } catch (e) {
                return Exception(e);
              }
            case 500:
              return ApiException(type: ApiExceptionType.invalidResponse);
            default:
              return ApiException(type: ApiExceptionType.unexpected, message: e.message);
          }
        default:
          return e;
      }
    } else {
      return ApiException(type: ApiExceptionType.unexpected, message: e.toString());
    }
  }

}