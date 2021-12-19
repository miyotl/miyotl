import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../core/network/error/failures.dart';
import '../../core/usecase/usecase.dart';
import '../repositories/user_repository_contract.dart';

@lazySingleton
class IsUserLoggedInUseCase extends UseCase<void, bool> {
  IsUserLoggedInUseCase(this.repository);

  final UserRepositoryContract repository;

  @override
  Future<Either<Failure, void>> call(bool params) {
    return repository.isUserLoggedIn();
  }
}
