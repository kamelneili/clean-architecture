import 'package:beautycentre/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/user.dart';
import '../datasources/auth_local_data_source.dart';
import '../datasources/auth_remote_data_source.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  // final AuthLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl(
      {required this.remoteDataSource,
      // required this.localDataSource,
      required this.networkInfo});
  @override
  Future<Either<Failure, Unit>> signUp(String password, User user) async {
    if (await networkInfo.isConnected) {
      try {
        final currentuser = auth.FirebaseAuth.instance.currentUser!;
        print("image");
        print(user.imageUrl);
        UserModel userModel = UserModel(
            id: currentuser.uid,
            fullName: user.fullName,
            address: user.address,
            email: user.email,
            city: user.city,
            country: user.country,
            zipCode: user.zipCode,
            imageUrl: user.imageUrl,
            genre: user.genre,
            specialite: user.specialite);
        print('userModel');
        print(userModel.id);
        //print(userModel.email);
        print(password);

        final remoteAuth = await remoteDataSource.signUp(password, userModel);
        //

        // localDataSource.cacheAuth(remoteAuth);
        return Right(remoteAuth);
      } on ServerException {
        print('errrror');
        return Left(ServerFailure());
      }
    } else {
      try {
        final userModel = UserModel(
            fullName: user.fullName,
            address: user.address,
            email: user.email,
            city: user.city,
            country: user.country,
            zipCode: user.zipCode,
            imageUrl: user.imageUrl,
            genre: user.genre,
            specialite: user.specialite);
        final remoteAuth = await remoteDataSource.signUp(password, userModel);

        // final localPosts = await localDataSource.getCachedPosts();
        return Right(remoteAuth);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }
  //=============Login=========================

  Future<Either<Failure, Unit>> logInWithEmailAndPassword(
      String password, String email) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteAuth =
            await remoteDataSource.logInWithEmailAndPassword(password, email);
        //

        // localDataSource.cacheAuth(remoteAuth);
        return Right(remoteAuth);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final remoteAuth =
            await remoteDataSource.logInWithEmailAndPassword(password, email);

        //  final localPosts = await localDataSource.getCachedPosts();
        return Right(remoteAuth);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

//=============LogOut=========================

  Future<Either<Failure, Unit>> signOut() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteAuth = await remoteDataSource.signOut();
        //

        // localDataSource.cacheAuth(remoteAuth);
        return Right(remoteAuth);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final remoteAuth = await remoteDataSource.signOut();

        // final localPosts = await localDataSource.getCachedPosts();
        return Right(remoteAuth);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  //===============================GetUser===================
  @override
  Future<Either<Failure, User>> getUser(String userId) async {
    if (await networkInfo.isConnected) {
      try {
        print('====getuser====');
        print(userId);
        print(remoteDataSource.getUser(userId).first);

        final remoteUser = await remoteDataSource.getUser(userId).first;
        print('here');
        print(remoteUser.email);
        // print(remoteUser.specialite);
        // print(remoteUser.city);
        // print(remoteUser.address);
        // print(remoteUser.zipCode);
        // print(remoteUser.imageUrl);
        // print(remoteUser.genre);

        print('====remoteposts=======');
        print(remoteUser);
        //   localDataSource.cacheUser(remoteUser);
        return Right(remoteUser as User);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final remoteUser = await remoteDataSource.getUser(userId).first;

        //   final localUser = await localDataSource.getCachedUser();
        return Right(remoteUser);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
    ;

//=============GetUser=========================
  }
}
