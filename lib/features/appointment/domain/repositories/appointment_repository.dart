import 'package:beautycentre/features/appointment/domain/entities/appointment.dart';
import 'package:beautycentre/features/appointment/domain/usecases/add_appointment.dart';

import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

abstract class AppointmentRepository {
  Future<Either<Failure, Unit>> addAppointment(Appointment appointment);
  // Future<Either<Failure, Unit>> deletePost(int id);
  // Future<Either<Failure, Unit>> updatePost(Post post);
  // Future<Either<Failure, Unit>> addPost(Post post);
}
