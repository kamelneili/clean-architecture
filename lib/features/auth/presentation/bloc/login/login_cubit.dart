import 'package:beautycentre/features/auth/domain/usecases/log_in_with_email_and_password.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LogInWithEmailAndPasswordUsecase loginusescase;

  LoginCubit({required this.loginusescase}) : super(LoginState.initial());

  void emailChanged(String value) {
    emit(state.copyWith(email: value, status: LoginStatus.initial));
  }

  void passwordChanged(String value) {
    emit(state.copyWith(password: value, status: LoginStatus.initial));
  }

  Future<void> logInWithCredentials() async {
    if (state.status == LoginStatus.submitting) return;
    emit(state.copyWith(status: LoginStatus.submitting));
    try {
      await loginusescase(
        state.email,
        state.password,
      );
      print("loggedin");
      emit(state.copyWith(status: LoginStatus.success));
    } catch (_) {}
  }

  // Future<void> logInWithGoogle() async {
  //   emit(state.copyWith(status: LoginStatus.submitting));
  //   try {
  //     // await _authRepository.logInWithGoogle();
  //     emit(state.copyWith(status: LoginStatus.success));
  //   } catch (_) {}
  // }
}
