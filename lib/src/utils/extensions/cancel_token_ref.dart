import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///The extension return CancelToken instance and dispose it
///when provider is destroyed.
extension CancelTokenX on Ref {
  CancelToken cancelToken() {
    final CancelToken cancelToken = CancelToken();
    //cancel http when provider is destroyed
    onDispose(cancelToken.cancel);
    return cancelToken;
  }
}
