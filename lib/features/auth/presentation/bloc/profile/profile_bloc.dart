import 'dart:async';

import 'package:beautycentre/features/auth/domain/entities/user.dart';
import 'package:beautycentre/features/auth/domain/usecases/get_user.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/strings/failures.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  StreamSubscription? _authSubscription;
  GetUserUsecase getUserUsecase;
  ProfileBloc({required this.getUserUsecase}) : super(ProfileLoading()) {
    on<LoadProfile>(_onLoadProfile);
    // on<UpdateProfile>(_onUpdateProfile);
  }

  Future<void> _onLoadProfile(
    LoadProfile event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      final failureOrUser = await getUserUsecase(event.userId);
      emit(_mapFailureOrPostsToState(failureOrUser));
    } catch (_) {
      Exception(Error);
    }
  }

  ProfileState _mapFailureOrPostsToState(Either<Failure, User> either) {
    return either.fold(
      (failure) => ErrorUserState(message: _mapFailureToMessage(failure)),
      (user) => ProfileLoaded(
        user: user,
      ),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case EmptyCacheFailure:
        return EMPTY_CACHE_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Unexpected Error , Please try again later .";
    }
  }
  // void _onUpdateProfile(
  //   UpdateProfile event,
  //   Emitter<ProfileState> emit,
  // ) {
  //   _userRepository.updateUser(event.user);
  //   emit(ProfileLoaded(user: event.user));
  // }
}
