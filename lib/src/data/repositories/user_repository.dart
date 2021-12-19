import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

import '../../core/network/error/failures.dart';
import '../../domain/entities/user_auth_model.dart';
import '../../domain/repositories/user_repository_contract.dart';
import '../../presentation/utils/constants/key_constants.dart';

@LazySingleton(as: UserRepositoryContract)
class UserRepository extends UserRepositoryContract {
  @override
  Future<Either<Failure, UserAuthModel>> getUserData() async {
    try {
      final storage = FlutterSecureStorage();
      // Read value
      var result = await storage.read(key: KeyConstants.userData);
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
      final storage = FlutterSecureStorage();
      // Read value
      var result = await storage.read(key: KeyConstants.userData);
      return Right(result == null);
    } on PlatformException {
      return Left(ReadUserDataFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> storeUserData(UserAuthModel? data) async {
    if (data == null) return Left(NullUserDataFailure());
    try {
      // Create storage
      final storage = FlutterSecureStorage();
      // Write value
      await storage.write(
          key: KeyConstants.userData, value: data.toJson().toString());
      // assuming everything was fine
      return Right(true);
    } on PlatformException {
      return Left(InsertUserDataFailure());
    }
  }
}
