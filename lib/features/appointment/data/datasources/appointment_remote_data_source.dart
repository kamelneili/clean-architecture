import 'dart:convert';

import 'package:beautycentre/features/appointment/data/models/appointment_model.dart';
import 'package:beautycentre/features/post/domain/entities/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import 'package:firebase_auth/firebase_auth.dart' as auth;

abstract class AppointmentRemoteDataSource {
  Future<Unit> addAppointment(AppointmentModel appointmentModel);
}

class AppointmentRemoteDataSourceImpl implements AppointmentRemoteDataSource {
  final FirebaseFirestore firebaseFirestore;
  final auth.FirebaseAuth firebaseAuth;
  //final GoogleSignIn _googleSignIn;
//  final UserRepositoryImpl userRepositoryImpl;
  AppointmentRemoteDataSourceImpl(
      {required this.firebaseAuth,
//required this.userRepositoryImpl,
      FirebaseFirestore? firebaseFirestore})
      : firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Future<Unit> addAppointment(AppointmentModel appointmentModel) async {
    try {
      print('addappointments');

      firebaseFirestore
          .collection('appointment')
          .add(appointmentModel.toDocument());

      return Future.value(unit);
    } catch (error) {
      throw Exception('Add appointment failed: $error');
    }
  }
}
