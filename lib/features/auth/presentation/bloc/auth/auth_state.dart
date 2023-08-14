part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class ErrorAddDeleteUpdatePostState extends AuthState {
  final String message;

  ErrorAddDeleteUpdatePostState({required this.message});

  @override
  List<Object> get props => [message];
}

class MessageAddDeleteUpdatePostState extends AuthState {
  final String message;

  MessageAddDeleteUpdatePostState({required this.message});

  @override
  List<Object> get props => [message];
}
