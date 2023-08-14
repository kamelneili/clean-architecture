import 'package:beautycentre/core/error/failures.dart';
import 'package:beautycentre/core/strings/failures.dart';
import 'package:beautycentre/features/auth/domain/entities/user.dart';
import 'package:beautycentre/features/auth/domain/usecases/sign_up_auth.dart';
import 'package:beautycentre/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  //final AuthRepository _authRepository;
  final SignUpAuthsUsecase signUpAuthsUsecase;

  SignupCubit({
    required this.signUpAuthsUsecase,
  }) : super(SignupState.initial());

  void userChanged(User user) {
    emit(state.copyWith(
      user: user,
      status: SignupStatus.initial,
    ));
  }

  void passwordChanged(String value) {
    emit(state.copyWith(password: value, status: SignupStatus.initial));
  }

  Future<void> signUpWithCredentials() async {
    // if (!state.isFormValid || state.status == SignupStatus.submitting) return;
    emit(state.copyWith(status: SignupStatus.submitting));
    try {
      print("useeeeer");
      print(state.user);
      var failureOrDoneMessage = await signUpAuthsUsecase(
        state.password,
        state.user!,
      );
      print("failureOrDoneMessage:=====");
      print(failureOrDoneMessage);
      emit(SignupState.initial());
      //   _eitherDoneMessageOrErrorState(
      //       failureOrDoneMessage, ADD_SUCCESS_MESSAGE),
      // );
    } catch (_) {}
  }

  AuthState _eitherDoneMessageOrErrorState(
      Either<Failure, Unit> either, String message) {
    return either.fold(
      (failure) => ErrorAddDeleteUpdatePostState(
        message: _mapFailureToMessage(failure),
      ),
      (_) => MessageAddDeleteUpdatePostState(message: message),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Unexpected Error , Please try again later .";
    }
  }
}
