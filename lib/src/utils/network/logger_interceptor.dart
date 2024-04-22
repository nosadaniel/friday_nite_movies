import 'dart:developer';

import 'package:dio/dio.dart';

class LoggerInterceptor implements Interceptor {
  final stopwatches = <String, Stopwatch>{};
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final String url = err.requestOptions.uri.toString();
    _logMessageAndClearStopwatch(null, url, '❌ Received Error');
    log("${err.stackTrace}");
    if (err.response?.data != null) {
      log('❌ Response Error: ${err.response?.data}');
    }
    return handler.next(err);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final String url = '${options.baseUrl}${options.path}';
    stopwatches[url] = Stopwatch()..start();
    log('🌍 Making request: $url');
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final String url =
        '${response.requestOptions.baseUrl}${response.requestOptions.path}';
    _logMessageAndClearStopwatch(
        response.statusCode, url, '⬅️ Received response');
    if (response.requestOptions.queryParameters.isNotEmpty) {
      log('Query params: ${response.requestOptions.queryParameters}');
    }
    log('_____________________________');
    return handler.next(response);
  }

  void _logMessageAndClearStopwatch(
      int? statusCode, String url, String message) {
    final stopwatch = stopwatches[url];
    if (stopwatch != null) {
      stopwatch.stop();
      _logResponse(statusCode, stopwatch.elapsedMilliseconds, url);
      stopwatches.remove(url);
    } else {
      log("$url | $message");
    }
  }

  void _logResponse(int? statusCode, int milliseconds, String url) {
    final emoji = switch (statusCode) {
      != null && >= 200 && < 300 => "✅",
      != null && >= 300 && < 400 => "🟠",
      _ => "❌"
    };
    if (statusCode != null) {
      log('$emoji $statusCode $emoji | ${milliseconds}ms | $url');
    } else {
      log("$emoji | ${milliseconds}ms | $url");
    }
  }
}
