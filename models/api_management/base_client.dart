import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:mime/mime.dart';

import 'package:http_parser/http_parser.dart';

abstract class BaseClient1 {
  static const _timeout = 30000;
  static const _retries = 1;

  final Logger log;
  late final http.Client _client;

  BaseClient1({required this.log}) {
    _client = http.Client();
  }

  @protected
  Future<http.Response> get(
    String url, {
    Map<String, String>? headers,
    int? currentTry,
    Map<String, dynamic>? queryParameters,
  }) async {
    int retry = currentTry ?? 0;

    String queryParams = '';
    if (queryParameters != null) {
      queryParams += '?';
      queryParameters.forEach((key, value) {
        queryParams += '$key=$value&';
      });
      queryParams = queryParams.substring(0, queryParams.length - 1);
    }

    try {
      final uri = Uri.parse('$url$queryParams');
      print(uri);
      return await _client
          .get(uri, headers: headers)
          .timeout(const Duration(milliseconds: _timeout));
    } on TimeoutException catch (_) {
      log.w("Timeout after $_timeout milliseconds:");
      log.w("-- URI: $url");

      if (retry < _retries) {
        retry++;
        return get(url, headers: headers, currentTry: retry);
      } else {
        rethrow;
      }
    } catch (e) {
      rethrow;
    }
  }

  @protected
  Future<http.Response> post(
    String url, {
    Map<String, String>? headers,
    int? currentTry,
    Map<String, dynamic>? queryParameters,
    Object? body,
  }) async {
    int retry = currentTry ?? 0;

    String queryParams = '';
    if (queryParameters != null) {
      queryParams += '?';
      queryParameters.forEach((key, value) {
        queryParams += '$key=$value&';
      });
      queryParams = queryParams.substring(0, queryParams.length - 1);
    }

    try {
      final uri = Uri.parse('$url$queryParams');
      print(uri);
      // final uri = Uri.https('$url$queryParams');
      return await _client
          .post(
            uri,
            headers: headers,
            body: body,
          )
          .timeout(const Duration(milliseconds: _timeout));
    } on TimeoutException catch (_) {
      log.w("Timeout after $_timeout milliseconds:");
      log.w("-- URI: $url");

      if (retry < _retries) {
        retry++;
        return post(url, headers: headers, currentTry: retry, body: body);
      } else {
        rethrow;
      }
    } catch (e) {
      rethrow;
    }
  }

  @protected
  Future<dynamic> postMultipart(
    String url,
    String filepath, {
    Map<String, String>? headers,
    int? currentTry,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? formParameters,
    Object? body,
    String? imageName = "picture",
  }) async {
    int retry = currentTry ?? 0;

    String queryParams = '';
    if (queryParameters != null) {
      queryParams += '?';
      queryParameters.forEach((key, value) {
        queryParams += '$key=$value&';
      });
      queryParams = queryParams.substring(0, queryParams.length - 1);
    }

    try {
      final uri = Uri.parse('$url$queryParams');
      print(uri);

      var multipartRequest = http.MultipartRequest('POST', uri);
      multipartRequest.files
          .add(await http.MultipartFile.fromPath('${imageName}', filepath));
      if (formParameters != null) {
        formParameters.forEach((k, v) => multipartRequest.fields[k] = v ?? "");
        // multipartRequest.fields.addAll(formParameters!);
      }
      multipartRequest.headers.addAll(headers!);
      final response = await multipartRequest.send();
      print('Send API');

      final respStr = await response.stream.bytesToString();
      print('STR Res');
      print(respStr);
      return respStr;
      // return await http
      //     .post(
      //       uri,
      //       headers: headers,
      //       body: body,
      //     )
      //     .timeout(const Duration(milliseconds: _timeout));
    } on TimeoutException catch (_) {
      log.w("Timeout after $_timeout milliseconds:");
      log.w("-- URI: $url");

      // if (retry < _retries) {
      //   retry++;
      //   return post(url, headers: headers, currentTry: retry, body: body);
      // } else {
      //   rethrow;
      // }
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @protected
  Future<dynamic> postFormParameters(
    String url, {
    Map<String, String>? headers,
    int? currentTry,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? formParameters,
    Object? body,
  }) async {
    int retry = currentTry ?? 0;

    String queryParams = '';
    if (queryParameters != null) {
      queryParams += '?';
      queryParameters.forEach((key, value) {
        queryParams += '$key=$value&';
      });
      queryParams = queryParams.substring(0, queryParams.length - 1);
    }

    try {
      final uri = Uri.parse('$url$queryParams');
      print(uri);

      var multipartRequest = http.MultipartRequest('POST', uri);

      if (formParameters != null) {
        formParameters.forEach((k, v) => multipartRequest.fields[k] = v);
        // multipartRequest.fields.addAll(formParameters!);
      }
      multipartRequest.headers.addAll(headers!);
      final response = await multipartRequest.send();
      print('Send API');

      final respStr = await response.stream.bytesToString();
      print('STR Res');
      print(respStr);
      return respStr;
      // return await http
      //     .post(
      //       uri,
      //       headers: headers,
      //       body: body,
      //     )
      //     .timeout(const Duration(milliseconds: _timeout));
    } on TimeoutException catch (_) {
      log.w("Timeout after $_timeout milliseconds:");
      log.w("-- URI: $url");

      // if (retry < _retries) {
      //   retry++;
      //   return post(url, headers: headers, currentTry: retry, body: body);
      // } else {
      //   rethrow;
      // }
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
