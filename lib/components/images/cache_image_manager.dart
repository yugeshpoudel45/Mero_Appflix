import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CustomCacheManager {
  static const key = 'customCacheKey';
  static CacheManager instance = CacheManager(
    Config(
      key,
      stalePeriod: const Duration(
        minutes: 5,
      ),
      maxNrOfCacheObjects: 40,
      repo: JsonCacheInfoRepository(databaseName: key),
    ),
  );
}
