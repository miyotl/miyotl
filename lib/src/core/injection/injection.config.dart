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
import '../../data/repositories/home_repository.dart' as _i11;
import '../../domain/repositories/i_home_repository.dart' as _i10;
import '../../domain/usecases/get_characters_usecase.dart' as _i12;
import '../../domain/usecases/get_episodes_usecase.dart' as _i13;
import '../../domain/usecases/get_locations_usecase.dart' as _i14;
import '../../presentation/blocs/home/home_bloc.dart' as _i15;
import '../../presentation/blocs/signin/sign_in_bloc.dart' as _i9;
import '../network/network_info.dart' as _i8;
import 'register_module.dart' as _i16; // ignore_for_file: unnecessary_lambdas

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
  gh.factory<_i9.SignInBloc>(() => _i9.SignInBloc());
  gh.lazySingleton<_i10.IHomeRepository>(() => _i11.HomeRepository(
      get<_i8.NetworkInfo>(),
      get<_i6.IHomeRemoteDataSource>(),
      get<_i5.IHomeLocalDataSource>()));
  gh.lazySingleton<_i12.GetCharactersUseCase>(
      () => _i12.GetCharactersUseCase(get<_i10.IHomeRepository>()));
  gh.lazySingleton<_i13.GetEpisodesUseCase>(
      () => _i13.GetEpisodesUseCase(get<_i10.IHomeRepository>()));
  gh.lazySingleton<_i14.GetLocationsUseCase>(
      () => _i14.GetLocationsUseCase(get<_i10.IHomeRepository>()));
  gh.factory<_i15.HomeBloc>(() => _i15.HomeBloc(
      get<_i12.GetCharactersUseCase>(),
      get<_i13.GetEpisodesUseCase>(),
      get<_i14.GetLocationsUseCase>()));
  return get;
}

class _$RegisterModule extends _i16.RegisterModule {}
