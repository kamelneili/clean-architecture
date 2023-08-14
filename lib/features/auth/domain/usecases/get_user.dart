import 'package:beautycentre/features/auth/domain/entities/user.dart';
import 'package:beautycentre/features/auth/domain/repositories/auth_repository.dart';

import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

class GetUserUsecase {
  final AuthRepository repository;

  GetUserUsecase(this.repository);

  Future<Either<Failure, User>> call(
    String userId,
  ) {
    return repository.getUser(userId);
  }
}
