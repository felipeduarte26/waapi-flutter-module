import '../../../../../../ponto_mobile_collector.dart';
import '../../../domain/entities/company.dart';
import '../../../external/drift/collector_database.dart';

class CompanyRepository implements ICompanyRepository {
  CollectorDatabase database;

  CompanyRepository({required this.database});

  @override
  Future<bool> exist({
    String? id,
  }) async {
    if (id == null) {
      return false;
    }
    final query = database.select(database.companyTable);
    query.where((tbl) => tbl.id.equals(id));
    CompanyTableData? tableData = await query.getSingleOrNull();
    return tableData != null;
  }

  @override
  Future<int> insert({
    required Company company,
  }) async {
    CompanyTableData tableData = convertToTable(
      company: company,
    );
    return database.into(database.companyTable).insert(tableData);
  }

  @override
  Future<bool> update({
    required Company company,
  }) async {
    CompanyTableData tableData = convertToTable(
      company: company,
    );
    return database.update(database.companyTable).replace(tableData);
  }

  @override
  Future<Company?> findById({
    required String id,
  }) async {
    CompanyTableData? tableData = await (database.select(database.companyTable)
          ..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();

    if (tableData == null) {
      return null;
    }

    return convertToCompany(company: tableData);
  }

  @override
  Future<Company?> findByIdentifier({
    required String identifier,
  }) async {
    List<CompanyTableData> tableData =
        await (database.select(database.companyTable)
              ..where((tbl) => tbl.identifier.equals(identifier)))
            .get();

    if (tableData.isEmpty) {
      return null;
    }

    return convertToCompany(company: tableData.first);
  }

  @override
  Future<List<Company>> getAll() async {
    List<CompanyTableData> tableDatas =
        await database.select(database.companyTable).get();
    List<Company> companys = [];

    for (CompanyTableData tableData in tableDatas) {
      await convertToCompany(company: tableData).then((value) {
        if (value != null) {
          companys.add(value);
        }
      });
    }

    return Future.value(companys);
  }

  @override
  Future<bool> save({
    required Company company,
  }) async {
    return (await exist(id: company.id))
        ? await update(company: company)
        : (await insert(company: company)) > 0;
  }

  @override
  Future<void> deleteAll() async {
    await database.delete(database.companyTable).go();
  }

  @override
  CompanyTableData convertToTable({
    required Company company,
  }) {
    CompanyTableData tableData = CompanyTableData(
      identifier: company.cnpj,
      id: company.id ?? '', // TODO: Validar como tratar o id 
      name: company.name,
      timeZone: company.timeZone,
      arpId: company.arpId,
      caepf: company.caepf,
      cnoNumber: company.cnoNumber,
    );

    return tableData;
  }

  
  @override
  Future<Company?> convertToCompany({required CompanyTableData company}) {
    Company tableData = Company(
      cnpj: company.identifier,
      id: company.id,
      name: company.name,
      timeZone: company.timeZone,
      arpId: company.arpId,
      caepf: company.caepf,
      cnoNumber: company.cnoNumber,
    );

    return Future.value(tableData);
  }
}
