import 'package:beautycentre/features/appointment/domain/entities/appointment.dart';
import 'package:beautycentre/features/appointment/domain/repositories/appointment_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

class AddAppointmentUsecase {
  final AppointmentRepository repository;

  AddAppointmentUsecase(this.repository);

  Future<Either<Failure, Unit>> call(Appointment Appointment) {
    return repository.addAppointment(Appointment);
  }
}
