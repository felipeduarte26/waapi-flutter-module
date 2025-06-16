import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/pagination_entity.dart';

void main() {
  group('PaginationEntity', () {
    test('props test', () async {
      PaginationEntity paginationEntity = const PaginationEntity(
        pageNumber: 1,
        pageSize: 2,
        totalPage: 3,
        objects: ['obj1'],
      );

      expect(paginationEntity.props[0], 1);
      expect(paginationEntity.props[1], 2);
      expect(paginationEntity.props[2], 3);
      expect(paginationEntity.props[3], ['obj1']);
    });
  });
}
