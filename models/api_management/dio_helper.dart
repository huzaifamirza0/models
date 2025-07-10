import 'package:dio/dio.dart';

import '../../container_injector.dart';
import '../api/interceptors.dart';
import '../utils/app_constants.dart';

const String _contentType = "Content-Type";
const String _applicationJson = "application/json";
const String _apiKey = "660bed71b7msh0719db584eed899p1dd961jsn1da18e37ea78";
// const String _apiKey = "f21b4e327emsh7a30ad174abed5ep10e725jsn17d7586cf86b";
const String _apiHost = "tiktok-download-without-watermark.p.rapidapi.com";

class DioHelper {
  final Dio dio;

  DioHelper({required this.dio}) {
    Map<String, dynamic> headers = {
      _contentType: _applicationJson,
      "X-RapidAPI-Key": _apiKey,
      "X-RapidAPI-Host": _apiHost,
    };
    dio.options = BaseOptions(
      receiveDataWhenStatusError: true,
    );
    // dio.interceptors.add(sl<LogInterceptor>());
    // dio.interceptors.add(sl<AppInterceptors>());
  }

  Future<Response> get({
    required String path,
    Map<String, dynamic>? queryParams,
  }) async {
    return await dio.get(path, queryParameters: queryParams);
  }

  Future<Response> download({
    required String downloadLink,
    required String savePath,
    Map<String, dynamic>? queryParams,
  }) async {
    print('Downloading Video tiktok');
    return await dio.download(downloadLink, savePath);
  }
}
