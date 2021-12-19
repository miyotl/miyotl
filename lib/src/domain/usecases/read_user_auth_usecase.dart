import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../core/network/error/failures.dart';
import '../../core/usecase/usecase.dart';
import '../entities/user_auth_model.dart';
import '../repositories/user_repository_contract.dart';

@lazySingleton
class ReadUserAuthUseCase extends UseCase<UserAuthModel, void> {
  ReadUserAuthUseCase(this.repository);

  final UserRepositoryContract repository;

  @override
  Future<Either<Failure, UserAuthModel>> call(void params) {
    return repository.getUserData();
  }
}
