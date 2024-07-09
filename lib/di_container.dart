import 'package:dio/dio.dart';

import 'package:get_it/get_it.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tourease/constant.dart';
import 'package:tourease/data/remote/dio/dio_client.dart';
import 'package:tourease/data/remote/dio/logging_interceptor.dart';
import 'package:tourease/pages/Login/login_provider.dart';
import 'package:tourease/repo/app_repo.dart';

final GetIt sl = GetIt.instance;
Future<void> init() async {
  sl.registerLazySingleton(
      () => DioClient(AppConstant.baseUrl, sl(), loggingInterceptor: sl()));

  sl.registerLazySingleton(
      () => AppRepo(dioClient: sl(), sharedPreferences: sl()));

  sl.registerFactory(() => LoginProvider(appRepo: sl()));

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => LoggingInterceptor());
}
