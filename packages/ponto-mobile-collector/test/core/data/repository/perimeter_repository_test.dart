
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/perimeter.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/geometric_form_type.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/location_dto.dart';
import 'package:ponto_mobile_collector/app/collector/core/external/drift/collector_database.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';
import 'package:test/test.dart';

class MockFencePerimeterRepository extends Mock
  implements IFencePerimeterRepository {}

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

  group('PerimeterRepository Tests', () {
  late MockFencePerimeterRepository mockFencePerimeterRepository;
  late IPerimeterRepository repository;

  setUp(() {
    mockFencePerimeterRepository = MockFencePerimeterRepository();
    repository = PerimeterRepository(
    database: database,
    fencePerimeterRepository: mockFencePerimeterRepository,
    );
  });

  test('exist() should return true if perimeter exists', () async {
    final perimeter = PerimeterTableData(
    id: 'test-id',
    latitude: 123.0,
    longitude: 321.0,
    radius: 2.0,
    type: 'circle',
    dateAndTime: DateTime.now(),
    );

    await database.into(database.perimeterTable).insert(perimeter);

    final exists = await repository.exist(id: 'test-id');

    expect(exists, true);
  });

  test('exist() should return false if perimeter does not exist', () async {
    final exists = await repository.exist(id: 'non-existent-id');

    expect(exists, false);
  });

  test('insert() should add a new perimeter', () async {
    final location = LocationDto(
    latitude: 123.0,
    longitude: 321.0,
    dateAndTime: DateTime.now(),
    );

    final perimeter = Perimeter(
    id: 'test-id',
    radius: 2.0,
    type: GeometricFormType.circle,
    startPoint: location,
    );

    final result = await repository.insert(perimeter: perimeter);

    expect(result, isNonZero);
  });

  test('update() should modify an existing perimeter', () async {
    final location = LocationDto(
    latitude: 123.0,
    longitude: 321.0,
    dateAndTime: DateTime.now(),
    );

    final perimeter = Perimeter(
    id: 'test-id',
    radius: 2.0,
    type: GeometricFormType.circle,
    startPoint: location,
    );

    await repository.insert(perimeter: perimeter);

    final updatedPerimeter = Perimeter(
    id: 'test-id',
    radius: 3.0,
    type: GeometricFormType.circle,
    startPoint: location,
    );

    final result = await repository.update(perimeter: updatedPerimeter);

    expect(result, true);

    final fetchedPerimeter = await repository.getAll();
    expect(fetchedPerimeter.first.radius, 3.0);
  });

  test('save() should insert or update a perimeter', () async {
    final location = LocationDto(
    latitude: 123.0,
    longitude: 321.0,
    dateAndTime: DateTime.now(),
    );

    final perimeter = Perimeter(
    id: 'test-id',
    radius: 2.0,
    type: GeometricFormType.circle,
    startPoint: location,
    );

    final saveResult1 = await repository.save(perimeter: perimeter);
    expect(saveResult1, true);

    final updatedPerimeter = Perimeter(
    id: 'test-id',
    radius: 3.0,
    type: GeometricFormType.circle,
    startPoint: location,
    );

    final saveResult2 = await repository.save(perimeter: updatedPerimeter);
    expect(saveResult2, true);

    final fetchedPerimeter = await repository.getAll();
    expect(fetchedPerimeter.first.radius, 3.0);
  });

  test('getAll() should return all perimeters', () async {
    final location = LocationDto(
    latitude: 123.0,
    longitude: 321.0,
    dateAndTime: DateTime.now(),
    );

    final perimeter1 = Perimeter(
    id: 'test-id-1',
    radius: 2.0,
    type: GeometricFormType.circle,
    startPoint: location,
    );

    final perimeter2 = Perimeter(
    id: 'test-id-2',
    radius: 3.0,
    type: GeometricFormType.circle,
    startPoint: location,
    );

    await repository.save(perimeter: perimeter1);
    await repository.save(perimeter: perimeter2);

    final perimeters = await repository.getAll();

    expect(perimeters.length, 2);
    expect(perimeters.first.id, 'test-id-1');
    expect(perimeters.last.id, 'test-id-2');
  });

  test('findAllByFenceId() should return perimeters linked to a fence', () async {
    final location = LocationDto(
    latitude: 123.0,
    longitude: 321.0,
    dateAndTime: DateTime.now(),
    );

    final perimeter1 = Perimeter(
    id: 'test-id-1',
    radius: 2.0,
    type: GeometricFormType.circle,
    startPoint: location,
    );

    final perimeter2 = Perimeter(
    id: 'test-id-2',
    radius: 3.0,
    type: GeometricFormType.circle,
    startPoint: location,
    );

    await repository.save(perimeter: perimeter1);
    await repository.save(perimeter: perimeter2);

    when(() => mockFencePerimeterRepository.findAllByFenceId(fenceId: 'fence-id'))
      .thenAnswer((_) async => ['test-id-2']);

    final perimeters = await repository.findAllByFenceId(fenceId: 'fence-id');

    expect(perimeters.length, 1);
    expect(perimeters.first.id, 'test-id-2');
  });
  });
}
