import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tut_app_with_clean_architecture/app/app_prefs.dart';
import 'package:tut_app_with_clean_architecture/data/data_source/local_data_source.dart';
import 'package:tut_app_with_clean_architecture/data/network/app_api.dart';
import 'package:tut_app_with_clean_architecture/data/network/dio_factory.dart';
import 'package:tut_app_with_clean_architecture/data/network/network_info.dart';
import 'package:tut_app_with_clean_architecture/data/data_source/remote_data_source.dart';
import 'package:tut_app_with_clean_architecture/data/repository_imp/repository_imp.dart';
import 'package:tut_app_with_clean_architecture/domain/repository/repository.dart';
import 'package:tut_app_with_clean_architecture/domain/useCase/forgot_password_useCase.dart';
import 'package:tut_app_with_clean_architecture/domain/useCase/home_useCase.dart';
import 'package:tut_app_with_clean_architecture/domain/useCase/login_useCase.dart';
import 'package:tut_app_with_clean_architecture/domain/useCase/register_useCase.dart';
import 'package:tut_app_with_clean_architecture/domain/useCase/store_details_useCase.dart';
import 'package:tut_app_with_clean_architecture/presentation/forgot_password/view_model/forgot_password_view_model.dart';
import 'package:tut_app_with_clean_architecture/presentation/login/view_model/login_view_model.dart';
import 'package:tut_app_with_clean_architecture/presentation/main/pages/home/view_model/home_view_model.dart';
import 'package:tut_app_with_clean_architecture/presentation/register/view_model/register_view_model.dart';
import 'package:tut_app_with_clean_architecture/presentation/store_detail/view_model/store_detail_view_model.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  // app module, its a module where we put all generic dependencies

  // shared prefs instance
  final sharedPrefs = await SharedPreferences.getInstance();
  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  // app prefs instance
  instance
      .registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));

  // network info
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImp(InternetConnectionChecker()));

  // dio factory
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));

  Dio dio = await instance<DioFactory>().getDio();
  //app service client
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  // remote data source
  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImp(instance<AppServiceClient>()));

  // local data source
  instance.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl());

  // repository

  instance.registerLazySingleton<Repository>(
      () => RepositoryImp(instance(), instance(), instance()));
}

initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  }
}

initForgotPasswordModule() {
  if (!GetIt.I.isRegistered<ForgotPasswordUseCase>()) {
    instance.registerFactory<ForgotPasswordUseCase>(
        () => ForgotPasswordUseCase(instance()));
    instance.registerFactory<ForgotPasswordViewModel>(
        () => ForgotPasswordViewModel(instance()));
  }
}

initRegisterModule() {
  if (!GetIt.I.isRegistered<RegisterUseCase>()) {
    instance
        .registerFactory<RegisterUseCase>(() => RegisterUseCase(instance()));
    instance.registerFactory<RegisterViewModel>(
        () => RegisterViewModel(instance()));
    instance.registerFactory<ImagePicker>(() => ImagePicker());
  }
}

initHomeModule() {
  if (!GetIt.I.isRegistered<HomeUseCase>()) {
    instance.registerFactory<HomeUseCase>(() => HomeUseCase(instance()));
    instance.registerFactory<HomeViewModel>(() => HomeViewModel(instance()));
  }
}

initStoreDetailsModule() {
  if (!GetIt.I.isRegistered<StoreDetailsUseCase>()) {
    instance.registerFactory<StoreDetailsUseCase>(
            () => StoreDetailsUseCase(instance()));
    instance.registerFactory<StoreDetailsViewModel>(
            () => StoreDetailsViewModel(instance()));
  }
}
