part of 'recovery_secret_cubit.dart';

abstract class RecoverySecretState {}

class RecoverySecretInitial extends RecoverySecretState {}

class RecoverySecretLoading extends RecoverySecretState {}

class RecoverySecretSuccess extends RecoverySecretState {}

class RecoverySecretError extends RecoverySecretState {
  final String error;
  RecoverySecretError(this.error);
}
