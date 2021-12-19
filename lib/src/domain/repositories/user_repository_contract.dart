import 'package:dartz/dartz.dart';

import '../../core/network/error/failures.dart';
import '../entities/user_auth_model.dart';

abstract class UserRepositoryContract {
  Future<Either<Failure, bool>> isUserLoggedIn();

  Future<Either<Failure, UserAuthModel>> getUserData();

  Future<Either<Failure, bool>> storeUserData(UserAuthModel? data);
}
