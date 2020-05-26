abstract class Repository {
  Future<bool> getLoginDataFromDataSource(String email, String password);
  Future<void> downloadFileToCache();
}