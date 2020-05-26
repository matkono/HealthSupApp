abstract class DoctorRepository {
  Future<bool> getLoginDataFromRepository(String crm, String email, String password);
  Future<void> downloadFileToCache();
}