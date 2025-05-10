import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import 'core/network/api_client.dart';
import 'package:http/http.dart' as http;

import 'core/network/network_info.dart';
import 'feature/article/data/datasource/article_local_data_source.dart';
import 'feature/article/data/datasource/article_remote_data_source.dart';
import 'feature/article/data/models/article_model.dart';
import 'feature/article/data/repositories/article_repository_impl.dart';
import 'feature/article/domain/article_repository.dart';
import 'feature/article/domain/usecases/get_articles.dart';
import 'feature/article/domain/usecases/toggle_favorite.dart';
import 'feature/article/presentation/bloc/article_bloc.dart';
final sl = GetIt.instance;
Future<void> init() async {
  // Initialize Hive
  await Hive.initFlutter();
  Hive.registerAdapter(ArticleModelAdapter());

  // External
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => Connectivity());

  // Core
  sl.registerLazySingleton<ApiClient>(() => ApiClient(client: sl()));
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // Data sources
  sl.registerLazySingleton<ArticleRemoteDataSource>(
        () => ArticleRemoteDataSourceImpl(apiClient: sl()),
  );

  sl.registerLazySingleton<ArticleLocalDataSource>(
        () => ArticleLocalDataSourceImpl(),
  );

  // Repository
  sl.registerLazySingleton<ArticleRepository>(
        () => ArticleRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetArticles(sl()));
  sl.registerLazySingleton(() => ToggleFavorite(sl()));

  // BLoC
  sl.registerFactory(
        () => ArticleBloc(
      getArticles: sl(),
      toggleFavorite: sl(),
    ),
  );
}