import 'package:beautycentre/features/auth/domain/repositories/auth_repository.dart';

import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

class SignOutUsescase {
  final AuthRepository repository;

  SignOutUsescase(this.repository);

  Future<Either<Failure, Unit>> call() {
    return repository.signOut();
  }
}
