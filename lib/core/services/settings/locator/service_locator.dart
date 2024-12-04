import 'package:flutter_dev_test/app_imports.dart';

class ServiceLocator {
  ServiceLocator._();

  static GetIt get locator => GetIt.instance;

  static const appName = 'Dev Flutter Test';

  static Future<void> initServiceLocator() async {
    await _registerServices();
    _registerExternal();
    _registerInfra();
    _registerPresenter();
  }

  static Future<void> _registerServices() async {
    GetIt.I.registerSingleton<Dio>(DioFactory.create());
    GetIt.I.registerSingleton<IHttpService>(HttpDioService(locator()));
    GetIt.I.registerSingleton<SharedPreferences>(
        await SharedPreferences.getInstance());
    GetIt.I.registerLazySingleton<AppStorage>(
        () => SharedPreferencesStorage(locator()));
  }

  static void _registerExternal() async {
    GetIt.I.registerLazySingleton<ILoginDatasource>(
        () => LoginHttpDatasourceImp(locator()));
    GetIt.I.registerLazySingleton<IRecoverySecretDatasource>(
        () => RecoverySecretHttpDatasourceImp(locator(), locator()));
  }

  static void _registerInfra() async {
    GetIt.I.registerLazySingleton<ILoginRepository>(
        () => LoginRepositoryImp(locator(), locator()));
    GetIt.I.registerLazySingleton<IRecoverySecretRepository>(
        () => RecoverySecretRepositoryImp(locator()));
  }

  static void _registerPresenter() async {
    GetIt.I.registerFactory<LoginCubit>(() => LoginCubit(locator()));
    GetIt.I.registerFactory<RecoverySecretCubit>(
        () => RecoverySecretCubit(locator()));
  }
}
