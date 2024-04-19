import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension CancelTokenRef on Ref {
  CancelToken cancelToken() {
    final CancelToken cancelToken = CancelToken();
    onDispose(cancelToken.cancel);
    return cancelToken;
  }
}
