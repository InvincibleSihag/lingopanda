import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:lingopanda/core/common/models/user.dart';
import 'package:lingopanda/core/constants/constants.dart';
import 'package:lingopanda/core/network/connection_checker.dart';
import 'package:lingopanda/core/utilities/utils.dart';
import 'package:lingopanda/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:lingopanda/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:lingopanda/features/auth/data/repository/auth_repository_impl.dart';
import 'package:lingopanda/features/auth/domain/repository/auth_repository.dart';
import 'package:lingopanda/features/auth/presentation/providers/login_provider.dart';
import 'package:lingopanda/features/auth/presentation/providers/signup_provider.dart';
import 'package:lingopanda/features/news/data/datasources/news_local_datasource.dart';
import 'package:lingopanda/features/news/data/datasources/news_remote_datasource.dart';
import 'package:lingopanda/features/news/data/models/news_server_model.dart';
import 'package:lingopanda/features/news/data/repository/news_repository_impl.dart';
import 'package:lingopanda/features/news/domain/repository/news_repository.dart';
import 'package:lingopanda/features/news/presentation/providers/news_provider.dart';
import 'package:lingopanda/services/remote_config.dart';

final serviceLocator = GetIt.instance;

initDependencies() async {

  // Registering Hive dependencies
  // Apply compaction strategy to Hive boxes
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(NewsServerModelAdapter());
  await Hive.openBox<NewsServerModel>(HiveConstants.newsBox, compactionStrategy: compactionStrategy);
  await Hive.openBox<UserModel>(HiveConstants.userBox, compactionStrategy: compactionStrategy);

  // Registering Remote Config dependencies
  serviceLocator.registerLazySingleton<Dio>(() => Dio());
  serviceLocator.registerLazySingleton<FirebaseRemoteConfig>(() => FirebaseRemoteConfig.instance);
  serviceLocator.registerLazySingleton<RemoteConfigService>(() => RemoteConfigService(serviceLocator()));
  serviceLocator.registerLazySingleton<InternetConnection>(() => InternetConnection());
  serviceLocator.registerLazySingleton<ConnectionChecker>(() => ConnectionCheckerImpl(serviceLocator()));
  await serviceLocator<RemoteConfigService>().initialize();

  // Registering News dependencies
  serviceLocator.registerLazySingleton<NewsRemoteDataSource>(
    () => NewsRemoteDataSourceImpl(
      dio: serviceLocator(),
      apiKey: '2052c012de7c4398bd5de436420fee5b',
      country: serviceLocator<RemoteConfigService>().getRemoteConfigValue(countryKey),
    ),
  );

  serviceLocator.registerLazySingleton<NewsLocalDataSource>(() => NewsLocalDataSourceImpl());
  serviceLocator.registerLazySingleton<NewsRepository>(
    () => NewsRepositoryImpl(
        newsRemoteDataSource: serviceLocator(), newsLocalDataSource: serviceLocator()),
  );
  serviceLocator.registerLazySingleton<NewsProvider>(
    () => NewsProvider(serviceLocator<NewsRepository>()),
  );

  // Registering Auth dependencies
  serviceLocator.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  serviceLocator.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl());
  serviceLocator.registerLazySingleton<AuthLocalDataSource>(() => AuthLocalDataSourceImpl());
  serviceLocator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(serviceLocator<AuthRemoteDataSource>(), serviceLocator<AuthLocalDataSource>()),
  );
  serviceLocator.registerLazySingleton<LoginProvider>(
    () => LoginProvider(serviceLocator<AuthRepository>()),
  );
  serviceLocator.registerLazySingleton<SignupProvider>(
    () => SignupProvider(serviceLocator<AuthRepository>()),
  );
}
