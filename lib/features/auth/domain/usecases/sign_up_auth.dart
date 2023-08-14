import 'package:beautycentre/features/auth/domain/entities/user.dart';
import 'package:beautycentre/features/auth/domain/repositories/auth_repository.dart';

import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

class SignUpAuthsUsecase {
  final AuthRepository repository;

  SignUpAuthsUsecase(this.repository);

  Future<Either<Failure, Unit>> call(
    String password,
    User user,
  ) {
    return repository.signUp(password, user);
  }
}
