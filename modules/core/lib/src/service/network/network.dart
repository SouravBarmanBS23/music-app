import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../cache/network_cache/cache_service.dart';
import 'api.dart';
import 'src/rest_client.dart';

export 'package:dio/dio.dart';

export 'api.dart';

final networkProvider = Provider<RestClient>(
  (ref) {
    return RestClient(
      baseUrl: API.base,
      token: () async {
        return await ref.read(cacheServiceProvider).bearerToken;
      },
    );
  },
);
