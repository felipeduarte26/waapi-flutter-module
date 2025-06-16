import '../../../../../../ponto_mobile_collector.dart';
import '../../../domain/entities/perimeter.dart';
import '../../../domain/enums/geometric_form_type.dart';
import '../../../domain/input_model/location_dto.dart';
import '../../../external/drift/collector_database.dart';

class PerimeterRepository implements IPerimeterRepository {
  CollectorDatabase database;
  final IFencePerimeterRepository fencePerimeterRepository;

  PerimeterRepository({
    required this.fencePerimeterRepository,
    required this.database,
  });

  @override
  Future<bool> exist({
    required String id,
  }) async {
    final query = database.select(database.perimeterTable);
    query.where((tbl) => tbl.id.equals(id));
    PerimeterTableData? tableData = await query.getSingleOrNull();
    return tableData != null;
  }

  @override
  Future<int> insert({
    required Perimeter perimeter,
  }) async {
    PerimeterTableData tableData = convertToTable(
      perimeter: perimeter,
    );

    return database.into(database.perimeterTable).insert(tableData);
  }

  @override
  Future<bool> update({
    required Perimeter perimeter,
  }) async {
    PerimeterTableData tableData = convertToTable(
      perimeter: perimeter,
    );

    return database.update(database.perimeterTable).replace(tableData);
  }

  @override
  Future<bool> save({
    required Perimeter perimeter,
  }) async {
    return (await exist(id: perimeter.id!))
        ? await update(perimeter: perimeter)
        : (await insert(perimeter: perimeter)) > 0;
  }

  @override
  Future<bool> saveAll({required List<Perimeter> perimeters}) async {
    if (perimeters.isNotEmpty) {
      for (Perimeter dto in perimeters) {
        await save(perimeter: dto);
      }
    }

    return true;
  }

  @override
  Future<List<Perimeter>> getAll() async {
    List<PerimeterTableData> tableData =
        await database.select(database.perimeterTable).get();
    List<Perimeter> perimeters = convertToPerimeterList(tableData: tableData);
    return Future.value(perimeters);
  }

  @override
  Future<List<Perimeter>> findAllByFenceId({
    required String fenceId,
  }) async {
    List<String> perimetersId = await fencePerimeterRepository.findAllByFenceId(
      fenceId: fenceId,
    );

    final query = database.select(database.perimeterTable);
    query.where((tbl) => tbl.id.isIn(perimetersId));
    List<PerimeterTableData> tableDatas = await query.get();

    return convertToPerimeterList(tableData: tableDatas);
  }

  @override
  PerimeterTableData convertToTable({
    required Perimeter perimeter,
  }) {
    PerimeterTableData tableData = PerimeterTableData(
      id: perimeter.id ?? '',
      latitude: perimeter.startPoint!.latitude, // TO DO: validar o nullable
      longitude: perimeter.startPoint!.longitude, // TO DO: validar o nullable
      radius: perimeter.radius,
      type: perimeter.type!.value,// TO DO: validar o nullable
      dateAndTime: perimeter.startPoint!.dateAndTime,
    );

    return tableData;
  }

  @override
  Perimeter converToDto({
    required PerimeterTableData perimeter,
  }) {
    Perimeter tableData = Perimeter(
      id: perimeter.id,
      radius: perimeter.radius,
      type: GeometricFormType.build(perimeter.type),
      startPoint: LocationDto(
        latitude: perimeter.latitude,
        longitude: perimeter.longitude,
        dateAndTime: perimeter.dateAndTime,
      ),
    );

    return tableData;
  }
  
  @override
  List<Perimeter> convertToPerimeterList({required List<PerimeterTableData>? tableData}) {
       if (tableData == null || tableData.isEmpty) {
      return [];
    }

    List<Perimeter> perimeters = [];
    for (PerimeterTableData data in tableData) {
      perimeters.add(convertPerimeter(perimeter: data));
    }

    return perimeters;
  }
  @override
 Perimeter convertPerimeter({required PerimeterTableData perimeter}) {
    Perimeter tableData = Perimeter(
      id: perimeter.id,
      radius: perimeter.radius,
      type: GeometricFormType.build(perimeter.type),
      startPoint: LocationDto(
        latitude: perimeter.latitude,
        longitude: perimeter.longitude,
        dateAndTime: perimeter.dateAndTime,
      ),
    );

    return tableData;
 }
 
  @override
  Perimeter converToPerimeter({required PerimeterTableData perimeter}) {
    Perimeter tableData = Perimeter(
      id: perimeter.id,
      radius: perimeter.radius,
      type: GeometricFormType.build(perimeter.type),
      startPoint: LocationDto(
        latitude: perimeter.latitude,
        longitude: perimeter.longitude,
        dateAndTime: perimeter.dateAndTime,
      ),
    );

    return tableData;
  }
}
