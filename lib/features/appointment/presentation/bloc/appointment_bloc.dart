import 'dart:async';

import 'package:beautycentre/features/appointment/domain/usecases/add_appointment.dart';
import 'package:beautycentre/features/appointment/presentation/bloc/appointment_event.dart';
import 'package:beautycentre/features/appointment/presentation/bloc/appointment_state.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  StreamSubscription? _appointmentSubscription;
  final AddAppointmentUsecase addappointmentUsecase;
  AppointmentBloc({required this.addappointmentUsecase})
      : super(AppointmentLoading()) {
    on<UpdateAppointments>(_onUpdateAppointments);

    on<AddAppointment>(_onAddAppointment);
  }
  //

  // Future<void> _onLoadAppointments

  //

  void _onUpdateAppointments(
    UpdateAppointments event,
    Emitter<AppointmentState> emit,
  ) {
    print('kkkamel');
    print(event.appointments);

    emit(AppointmentLoaded(appointments: event.appointments));
    print('kamellll');
  }

  //

  Future<void> _onAddAppointment(
    AddAppointment event,
    Emitter<AppointmentState> emit,
  ) async {
    final state = this.state;
    //Appointment appointment = new Appointment();
    try {
      await addappointmentUsecase(event.appointment);
      // emit(AppointmentLoading());
    } catch (_) {}
  }
}
