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

import '../../data/datasources/home_local_datasource.dart' as _i5;
import '../../data/datasources/home_remote_datasource.dart' as _i6;
import '../../data/repositories/home_repository.dart' as _i12;
import '../../data/repositories/user_repository.dart' as _i10;
import '../../domain/repositories/i_home_repository.dart' as _i11;
import '../../domain/repositories/user_repository_contract.dart' as _i9;
import '../../domain/usecases/get_characters_usecase.dart' as _i16;
import '../../domain/usecases/get_episodes_usecase.dart' as _i17;
import '../../domain/usecases/get_locations_usecase.dart' as _i18;
import '../../domain/usecases/is_user_logged_in_usecase.dart' as _i13;
import '../../domain/usecases/read_user_auth_usecase.dart' as _i14;
import '../../domain/usecases/store_user_auth_usecase.dart' as _i15;
import '../../presentation/blocs/home/home_bloc.dart' as _i19;
import '../../presentation/blocs/signin/sign_in_bloc.dart' as _i20;
import '../network/network_info.dart' as _i8;
import 'register_module.dart' as _i21; // ignore_for_file: unnecessary_lambdas

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
  gh.lazySingleton<_i9.UserRepositoryContract>(() => _i10.UserRepository());
  gh.lazySingleton<_i11.IHomeRepository>(() => _i12.HomeRepository(
      get<_i8.NetworkInfo>(),
      get<_i6.IHomeRemoteDataSource>(),
      get<_i5.IHomeLocalDataSource>()));
  gh.lazySingleton<_i13.IsUserLoggedInUseCase>(
      () => _i13.IsUserLoggedInUseCase(get<_i9.UserRepositoryContract>()));
  gh.lazySingleton<_i14.ReadUserAuthUseCase>(
      () => _i14.ReadUserAuthUseCase(get<_i9.UserRepositoryContract>()));
  gh.lazySingleton<_i15.StoreUserAuthUseCase>(
      () => _i15.StoreUserAuthUseCase(get<_i9.UserRepositoryContract>()));
  gh.lazySingleton<_i16.GetCharactersUseCase>(
      () => _i16.GetCharactersUseCase(get<_i11.IHomeRepository>()));
  gh.lazySingleton<_i17.GetEpisodesUseCase>(
      () => _i17.GetEpisodesUseCase(get<_i11.IHomeRepository>()));
  gh.lazySingleton<_i18.GetLocationsUseCase>(
      () => _i18.GetLocationsUseCase(get<_i11.IHomeRepository>()));
  gh.factory<_i19.HomeBloc>(() => _i19.HomeBloc(
      get<_i16.GetCharactersUseCase>(),
      get<_i17.GetEpisodesUseCase>(),
      get<_i18.GetLocationsUseCase>()));
  gh.factory<_i20.SignInBloc>(() => _i20.SignInBloc(
      get<_i13.IsUserLoggedInUseCase>(),
      get<_i15.StoreUserAuthUseCase>(),
      get<_i14.ReadUserAuthUseCase>()));
  return get;
}

class _$RegisterModule extends _i21.RegisterModule {}
