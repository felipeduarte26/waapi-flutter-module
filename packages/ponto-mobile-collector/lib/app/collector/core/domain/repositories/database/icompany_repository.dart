import '../../../external/drift/collector_database.dart';
import '../../entities/company.dart';

abstract class ICompanyRepository {
  Future<bool> exist({
    String? id,
  });

  Future<int> insert({
    required Company company,
  });

  Future<bool> update({
    required Company company,
  });

  Future<Company?> findById({required String id});

  Future<Company?> findByIdentifier({required String identifier});

  Future<List<Company>> getAll();

  Future<bool> save({
    required Company company,
  });

  CompanyTableData convertToTable({
    required Company company,
  });

  Future<void> deleteAll();

  Future<Company?> convertToCompany({required CompanyTableData company});
}
