abstract class IRecoverySecretRepository {
  Future<void> recoverySecret({
    required String email,
    required String password,
    required String code,
  });
}
