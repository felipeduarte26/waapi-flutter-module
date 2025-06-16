import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/company.dart';

void main() {
  group('Company Entity', () {
    test('should correctly compare two Company instances with the same properties', () {
      const company1 = Company(
        id: '1',
        cnpj: '12345678901234',
        name: 'Test Company',
        timeZone: 'UTC',
        arpId: 'arp123',
        cnoNumber: 'cno123',
        caepf: 'caepf123',
      );

      const company2 = Company(
        id: '1',
        cnpj: '12345678901234',
        name: 'Test Company',
        timeZone: 'UTC',
        arpId: 'arp123',
        cnoNumber: 'cno123',
        caepf: 'caepf123',
      );

      expect(company1, equals(company2));
    });

    test('should correctly handle null id', () {
      const company = Company(
        id: null,
        cnpj: '12345678901234',
        name: 'Test Company',
        timeZone: 'UTC',
      );

      expect(company.id, isNull);
    });

    test('should correctly handle required fields', () {
      const company = Company(
        cnpj: '12345678901234',
        name: 'Test Company',
        timeZone: 'UTC',
      );

      expect(company.cnpj, '12345678901234');
      expect(company.name, 'Test Company');
      expect(company.timeZone, 'UTC');
    });

    test('should correctly handle optional fields', () {
      const company = Company(
        id: '1',
        cnpj: '12345678901234',
        name: 'Test Company',
        timeZone: 'UTC',
        arpId: 'arp123',
        cnoNumber: 'cno123',
        caepf: 'caepf123',
      );

      expect(company.arpId, 'arp123');
      expect(company.cnoNumber, 'cno123');
      expect(company.caepf, 'caepf123');
    });

    test('should correctly handle equality with different properties', () {
      const company1 = Company(
        id: '1',
        cnpj: '12345678901234',
        name: 'Test Company',
        timeZone: 'UTC',
      );

      const company2 = Company(
        id: '2',
        cnpj: '98765432109876',
        name: 'Another Company',
        timeZone: 'PST',
      );

      expect(company1, isNot(equals(company2)));
    });

    test('should correctly handle missing optional fields', () {
      const company = Company(
        cnpj: '12345678901234',
        name: 'Test Company',
        timeZone: 'UTC',
      );

      expect(company.arpId, isNull);
      expect(company.cnoNumber, isNull);
      expect(company.caepf, isNull);
    });
  });
}
