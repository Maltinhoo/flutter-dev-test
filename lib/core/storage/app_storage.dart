abstract class AppStorage {
  Future<void> setTOTP(String totp);
  Future<String?> getTOTP();
}
