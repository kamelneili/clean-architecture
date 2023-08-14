import 'package:beautycentre/features/auth/domain/entities/user.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

import '../../../../core/error/failures.dart';

abstract class AuthRepository {
  // Stream<auth.User?> get user;
  Future<Either<Failure, Unit>> signUp(
    String password,
    User user,
  );
  // Future<void> logInWithGoogle();
  Future<Either<Failure, Unit>> logInWithEmailAndPassword(
    String email,
    String password,
  );
  //signout
  Future<Either<Failure, Unit>> signOut();
  // getuser
  Future<Either<Failure, User>> getUser(
    String userId,
  );
}
