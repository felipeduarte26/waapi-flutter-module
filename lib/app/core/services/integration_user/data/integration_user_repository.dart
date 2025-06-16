abstract class IntegrationUserRepository {
  Future<void> saveIntegrationUser(String? integrationUser);
  String? getIntegrationUser();
  Future<void> deleteIntegrationUser();
}
