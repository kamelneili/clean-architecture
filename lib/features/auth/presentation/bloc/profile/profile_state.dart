part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final User user;

  const ProfileLoaded({required this.user});

  @override
  List<Object> get props => [user];
}

class ErrorUserState extends ProfileState {
  final String message;

  ErrorUserState({required this.message});

  @override
  List<Object> get props => [message];
}

class ProfileUnauthenticated extends ProfileState {}
