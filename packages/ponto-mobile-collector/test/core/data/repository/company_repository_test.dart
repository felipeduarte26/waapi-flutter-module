import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/company.dart';
import 'package:ponto_mobile_collector/app/collector/core/external/drift/collector_database.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';
import 'package:test/test.dart';

void main() {
  late CollectorDatabase database;

  LazyDatabase openConnection() {
    return LazyDatabase(
      () async {
        return NativeDatabase.memory(logStatements: false);
      },
    );
  }

  setUp(
    () {
      database = CollectorDatabase(
        database: openConnection(),
      );
    },
  );

  tearDown(
    () async {
      await database.close();
    },
  );

  test(
    'CompanyRepository test.',
    () async {
      ICompanyRepository repository = CompanyRepository(database: database);

      Company company = const Company(
        cnpj: '21997329000149',
        name: 'Company Teste 1',
        timeZone: '+03:00',
        id: 'a3458e7a-581a-4e7b-8d0c-401ba25e18c5',
        arpId: 'arpId',
        caepf: 'caepf',
        cnoNumber: 'cnoNumber',
      );

      bool isEmpty = (await repository.getAll()).isEmpty;
      bool successSave = await repository.save(company: company);
      bool successUpdate = await repository.save(company: company);
      int totalCompanies = (await repository.getAll()).length;

      Company companyFindByCnpj = (await repository.findByIdentifier(
        identifier: company.cnpj,
      ))!;

      Company companyFindById = (await repository.findById(
        id: company.id!,
      ))!;

      await repository.deleteAll();
      final isEmptyAfterDelete = (await repository.getAll()).isEmpty;

      expect(isEmpty, true);
      expect(successSave, true);
      expect(successUpdate, true);
      expect(totalCompanies, 1);
      expect(company.id, companyFindByCnpj.id);
      expect(company.cnpj, companyFindByCnpj.cnpj);
      expect(company.name, companyFindByCnpj.name);
      expect(company.timeZone, companyFindByCnpj.timeZone);
      expect(company.arpId, companyFindByCnpj.arpId);
      expect(company.cnoNumber, companyFindByCnpj.cnoNumber);
      expect(company.caepf, companyFindByCnpj.caepf);

      expect(company.id, companyFindById.id);
      expect(company.cnpj, companyFindById.cnpj);
      expect(company.name, companyFindById.name);
      expect(company.timeZone, companyFindById.timeZone);
      expect(company.arpId, companyFindById.arpId);
      expect(company.cnoNumber, companyFindById.cnoNumber);
      expect(company.caepf, companyFindById.caepf);

      expect(isEmptyAfterDelete, true);
    },
  );
}
