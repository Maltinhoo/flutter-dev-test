abstract class ILoginRepository {
  Future<void> signIn({required String email, required String password});
}
