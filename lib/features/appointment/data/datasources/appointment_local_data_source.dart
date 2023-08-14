// import 'dart:async';
// import 'dart:convert';

// import 'package:beautycentre/features/appointment/data/models/appointment_model.dart';
// import 'package:beautycentre/features/appointment/domain/entities/appointment.dart';
// import 'package:dartz/dartz.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../../../../core/error/exceptions.dart';

// abstract class AppointmentLocalDataSource {
//   Future<Unit> addAppointment();
// }

// const CACHED_POSTS = "CACHED_POSTS";

// class AppointmentLocalDataSourceImpl implements AppointmentLocalDataSource {
//   final SharedPreferences sharedPreferences;

//   AppointmentLocalDataSourceImpl({required this.sharedPreferences});
//   @override
//   Future<Unit> addAppointment(AppointmentModel appointmentModels) async {
//    try{
//  final jsonString = sharedPreferences.getString(CACHED_POSTS);
//     if (jsonString != null) {
//       List decodeJsonData = json.decode(jsonString);
//       List<Appointment> jsonToPostModels = decodeJsonData
//           .map<AppointmentModel>(
//               (jsonPostModel) => AppointmentModel.fromSnapshot(jsonPostModel))
//           .toList();
//       return Future.value(jsonToPostModels as FutureOr<Unit>?);
//     } else {
//       throw EmptyCacheException();
//     }

//    }
//   }

// }
