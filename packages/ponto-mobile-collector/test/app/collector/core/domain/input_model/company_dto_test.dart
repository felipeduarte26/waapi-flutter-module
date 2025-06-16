import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/company_type.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/data_origin_type.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/company_dto.dart';

void main() {
  group('CompanyDto', () {
    test('should serialize and deserialize correctly', () {
      final companyDto = CompanyDto(
        id: '123',
        cnpj: '12345678901234',
        caepf: '12345678901',
        cnoNumber: '123456',
        name: 'Test Company',
        timeZone: 'UTC',
        dataOrigin: DataOriginType.manual,
        arpId: 'arp123',
        identifier: 'identifier123',
        type: CompanyType.cnpj,
      );

      final json = companyDto.toJson();
      final deserialized = CompanyDto.fromJson(json);

      expect(deserialized.id, companyDto.id);
      expect(deserialized.cnpj, companyDto.cnpj);
      expect(deserialized.caepf, companyDto.caepf);
      expect(deserialized.cnoNumber, companyDto.cnoNumber);
      expect(deserialized.name, companyDto.name);
      expect(deserialized.timeZone, companyDto.timeZone);
      expect(deserialized.dataOrigin, companyDto.dataOrigin);
      expect(deserialized.arpId, companyDto.arpId);
      expect(deserialized.identifier, companyDto.identifier);
      expect(deserialized.type, companyDto.type);
    });

    test('should handle null values correctly', () {
      final companyDto = CompanyDto(
        name: 'Test Company',
        timeZone: 'UTC',
      );

      final json = companyDto.toJson();
      final deserialized = CompanyDto.fromJson(json);

      expect(deserialized.id, null);
      expect(deserialized.cnpj, null);
      expect(deserialized.caepf, null);
      expect(deserialized.cnoNumber, null);
      expect(deserialized.name, companyDto.name);
      expect(deserialized.timeZone, companyDto.timeZone);
      expect(deserialized.dataOrigin, null);
      expect(deserialized.arpId, null);
      expect(deserialized.identifier, null);
      expect(deserialized.type, null);
    });
  });
}
