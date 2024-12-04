part of 'login_cubit.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginError extends LoginState {
  final String error;
  LoginError(this.error);
}

class LoginSuccess extends LoginState {}

class LoginUnauthorized extends LoginState {}

class LoginTOTPInvalid extends LoginState {}
