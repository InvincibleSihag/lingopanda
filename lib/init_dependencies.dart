import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lingopanda/core/common/models/user.dart';
import 'package:lingopanda/core/constants/constants.dart';
import 'package:lingopanda/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:lingopanda/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:lingopanda/features/auth/data/repository/auth_repository_impl.dart';
import 'package:lingopanda/features/auth/domain/repository/auth_repository.dart';
import 'package:lingopanda/features/auth/presentation/providers/login_provider.dart';
import 'package:lingopanda/features/auth/presentation/providers/signup_provider.dart';
import 'package:lingopanda/features/news/data/datasources/news_remote_datasource.dart';
import 'package:lingopanda/features/news/data/repository/news_repository_impl.dart';
import 'package:lingopanda/features/news/domain/repository/news_repository.dart';
import 'package:lingopanda/features/news/presentation/providers/news_provider.dart';
import 'package:lingopanda/services/remote_config.dart';

final serviceLocator = GetIt.instance;

initDependencies() async {

  // Registering Hive dependencies
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  await Hive.openBox<UserModel>(HiveConstants.userBox);

  // Registering Remote Config dependencies
  serviceLocator.registerLazySingleton<Dio>(() => Dio());
  serviceLocator.registerLazySingleton<FirebaseRemoteConfig>(() => FirebaseRemoteConfig.instance);
  serviceLocator.registerLazySingleton<RemoteConfigService>(() => RemoteConfigService(serviceLocator<FirebaseRemoteConfig>()));
  await serviceLocator<RemoteConfigService>().initialize();

  // Registering News dependencies
  serviceLocator.registerLazySingleton<NewsRemoteDataSource>(
    () => NewsRemoteDataSourceImpl(
      dio: serviceLocator<Dio>(),
      apiKey: '0c36870a7214436392311d777bb1f8d1',
      country: serviceLocator<RemoteConfigService>().getRemoteConfigValue('country'),
    ),
  );
  serviceLocator.registerLazySingleton<NewsRepository>(
    () => NewsRepositoryImpl(
        newsRemoteDataSource: serviceLocator<NewsRemoteDataSource>()),
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
