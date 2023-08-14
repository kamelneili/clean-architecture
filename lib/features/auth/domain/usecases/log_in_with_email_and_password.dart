import 'package:beautycentre/features/auth/domain/repositories/auth_repository.dart';

import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

class LogInWithEmailAndPasswordUsecase {
  final AuthRepository repository;

  LogInWithEmailAndPasswordUsecase(this.repository);

  Future<Either<Failure, Unit>> call(
    String email,
    String password,
  ) {
    return repository.logInWithEmailAndPassword(email, password);
  }
}
