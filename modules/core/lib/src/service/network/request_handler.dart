import 'dart:developer';

import 'package:core/core.dart';

import 'src/failures.dart';

extension FutureResponseExtension on Future<Response> {
  Future<(ErrorModel?, T?)> guard<T>(Function(dynamic) parse) async {
    try {
      final response = await this;

      return (null, parse(response.data) as T);
    } on Failure catch (e, stacktrace) {
      log(
        runtimeType.toString(),
        error: {},
        stackTrace: stacktrace,
      );

      ErrorModel errorModel = ErrorModel.fromJson(e.error);

      return (errorModel, null);
    } catch (e, stackTrace) {
      log(e.toString());
      log(stackTrace.toString());

      Log.error(e.toString());
      Log.error(stackTrace.toString());

      return (ErrorModel(), null);
    }
  }
}
