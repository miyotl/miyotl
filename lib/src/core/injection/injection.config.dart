// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:graphql_flutter/graphql_flutter.dart' as _i4;
import 'package:hive/hive.dart' as _i3;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i7;
import 'package:shared_preferences/shared_preferences.dart' as _i9;

import '../../data/datasources/home_local_datasource.dart' as _i5;
import '../../data/datasources/home_remote_datasource.dart' as _i6;
import '../../data/repositories/home_repository.dart' as _i13;
import '../../data/repositories/user_repository.dart' as _i11;
import '../../domain/repositories/i_home_repository.dart' as _i12;
import '../../domain/repositories/user_repository_contract.dart' as _i10;
import '../../domain/usecases/get_characters_usecase.dart' as _i18;
import '../../domain/usecases/get_episodes_usecase.dart' as _i19;
import '../../domain/usecases/get_locations_usecase.dart' as _i20;
import '../../domain/usecases/is_user_logged_in_usecase.dart' as _i14;
import '../../domain/usecases/read_user_auth_usecase.dart' as _i15;
import '../../domain/usecases/store_user_auth_usecase.dart' as _i17;
import '../../presentation/blocs/home/home_bloc.dart' as _i21;
import '../../presentation/blocs/settings/settings_bloc.dart' as _i16;
import '../../presentation/blocs/signin/sign_in_bloc.dart' as _i22;
import '../network/network_info.dart' as _i8;
import 'register_module.dart' as _i23; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final registerModule = _$RegisterModule();
  await gh.lazySingletonAsync<_i3.Box<dynamic>>(() => registerModule.openBox,
      preResolve: true);
  gh.lazySingleton<_i4.GraphQLClient>(() => registerModule.gqlClient);
  gh.lazySingleton<_i5.IHomeLocalDataSource>(
      () => _i5.HomeLocalDataSource(get<_i3.Box<dynamic>>()));
  gh.lazySingleton<_i6.IHomeRemoteDataSource>(
      () => _i6.HomeRemoteDataSource(get<_i4.GraphQLClient>()));
  gh.lazySingleton<_i7.InternetConnectionChecker>(
      () => registerModule.connectionChecker);
  gh.lazySingleton<_i8.NetworkInfo>(
      () => _i8.NetworkInfo(get<_i7.InternetConnectionChecker>()));
  gh.lazySingletonAsync<_i9.SharedPreferences>(
      () => registerModule.localPreferences);
  gh.lazySingletonAsync<_i10.UserRepositoryContract>(() async =>
      _i11.UserRepository(await get.getAsync<_i9.SharedPreferences>()));
  gh.lazySingleton<_i12.IHomeRepository>(() => _i13.HomeRepository(
      get<_i8.NetworkInfo>(),
      get<_i6.IHomeRemoteDataSource>(),
      get<_i5.IHomeLocalDataSource>()));
  gh.lazySingletonAsync<_i14.IsUserLoggedInUseCase>(() async =>
      _i14.IsUserLoggedInUseCase(
          await get.getAsync<_i10.UserRepositoryContract>()));
  gh.lazySingletonAsync<_i15.ReadUserAuthUseCase>(() async =>
      _i15.ReadUserAuthUseCase(
          await get.getAsync<_i10.UserRepositoryContract>()));
  gh.factoryAsync<_i16.SettingsBloc>(() async => _i16.SettingsBloc(
      await get.getAsync<_i14.IsUserLoggedInUseCase>(),
      await get.getAsync<_i15.ReadUserAuthUseCase>(),
      get<dynamic>()));
  gh.lazySingletonAsync<_i17.StoreUserAuthUseCase>(() async =>
      _i17.StoreUserAuthUseCase(
          await get.getAsync<_i10.UserRepositoryContract>()));
  gh.lazySingleton<_i18.GetCharactersUseCase>(
      () => _i18.GetCharactersUseCase(get<_i12.IHomeRepository>()));
  gh.lazySingleton<_i19.GetEpisodesUseCase>(
      () => _i19.GetEpisodesUseCase(get<_i12.IHomeRepository>()));
  gh.lazySingleton<_i20.GetLocationsUseCase>(
      () => _i20.GetLocationsUseCase(get<_i12.IHomeRepository>()));
  gh.factory<_i21.HomeBloc>(() => _i21.HomeBloc(
      get<_i18.GetCharactersUseCase>(),
      get<_i19.GetEpisodesUseCase>(),
      get<_i20.GetLocationsUseCase>()));
  gh.factoryAsync<_i22.SignInBloc>(() async =>
      _i22.SignInBloc(await get.getAsync<_i17.StoreUserAuthUseCase>()));
  return get;
}

class _$RegisterModule extends _i23.RegisterModule {}
