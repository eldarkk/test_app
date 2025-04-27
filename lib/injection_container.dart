import 'package:get_it/get_it.dart';
import 'package:test_app/core/network/dio_client.dart';
import 'package:test_app/data/datasource/messages_remote_data_source.dart';
import 'package:test_app/domain/repository/messages_repository.dart';

final sl = GetIt.instance;

void initDi() {
  // Core
  sl.registerLazySingleton<DioClient>(() => DioClient());

  // Data sources
  sl.registerLazySingleton<MessagesDataSource>(
    () => MessagesRemoteDataSource(sl<DioClient>().dio),
  );

  // Repository
  sl.registerLazySingleton<MessagesRepository>(
    () => MessagesRepositoryImpl(sl<MessagesDataSource>()),
  );
}
