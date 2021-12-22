import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/network/error/failures.dart';
import '../../domain/entities/user_auth_model.dart';
import '../../domain/repositories/user_repository_contract.dart';
import '../../presentation/utils/constants/app_constants.dart';

@LazySingleton(as: UserRepositoryContract)
class UserRepository extends UserRepositoryContract {
  UserRepository(this.localPreferences);

  final SharedPreferences localPreferences;

  @override
  Future<Either<Failure, UserAuthModel>> getUserData() async {
    try {
      // Read value
      var result =
          await localPreferences.getString(AppConstants.userProfileKey);
      if (result == null) {
        return Left(NoUserDataFailure());
      } else {
        Map<String, dynamic> user = jsonDecode(result);
        return Right(UserAuthModel.fromJson(user));
      }
    } on PlatformException {
      return Left(ReadUserDataFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> isUserLoggedIn() async {
    try {
      // Read value
      var result =
          await localPreferences.getString(AppConstants.userProfileKey);
      return Right(result != null);
    } on PlatformException {
      return Left(ReadUserDataFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> storeUserData(UserAuthModel data) async {
    try {
      // Write value
      await localPreferences.setString(
          AppConstants.userProfileKey, data.toString());
      // assuming everything was fine
      return Right(true);
    } on PlatformException {
      return Left(InsertUserDataFailure());
    }
  }
}
