import 'dart:convert';

import 'package:beautycentre/features/post/domain/entities/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import 'package:firebase_auth/firebase_auth.dart' as auth;

import '../../domain/entities/user.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<Unit> signUp(String password, UserModel user);
  Future<Unit> logInWithEmailAndPassword(String email, String password);
  Future<Unit> signOut();

  Stream<UserModel> getUser(String userId);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseFirestore firebaseFirestore;
  final auth.FirebaseAuth firebaseAuth;
  //final GoogleSignIn _googleSignIn;
//  final UserRepositoryImpl userRepositoryImpl;
  AuthRemoteDataSourceImpl(
      {required this.firebaseAuth,
//required this.userRepositoryImpl,
      FirebaseFirestore? firebaseFirestore})
      : firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Future<Unit> signUp(
    String password,
    UserModel user,
  ) async {
    try {
      firebaseAuth
          .createUserWithEmailAndPassword(
        email: user.email,
        password: password,
      )
          .then((value) async {
        //
        final currentuser = auth.FirebaseAuth.instance.currentUser!;

        bool userExist = (await firebaseFirestore
                .collection('users')
                .doc(currentuser.uid)
                .get())
            .exists;
        if (userExist) {
          return Future.value(unit);
        } else {
          await firebaseFirestore
              .collection('users')
              .doc(currentuser.uid)
              .set(user.toDocument());
        }

        //   //
      });

      return Future.value(unit);
    } on auth.FirebaseAuthException catch (authError) {
      throw ServerException();
    }
  }
  //login

  @override
  Future<Unit> logInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Future.value(unit);
    } on auth.FirebaseAuthException catch (authError) {
      throw ServerException();
    }
  }

  @override
  Stream<auth.User?> get user => firebaseAuth.userChanges();
//logOut
  @override
  Future<Unit> signOut() async {
    try {
      await firebaseAuth.signOut();
      return Future.value(unit);
    } on auth.FirebaseAuthException catch (authError) {
      throw ServerException();
    }
  }
  //
  //getUser

  @override
  Stream<UserModel> getUser(String userId) {
    return firebaseFirestore
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((snap) {
      return UserModel.fromSnapshot(snap);
    });
  }
}
