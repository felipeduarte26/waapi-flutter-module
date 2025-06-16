import '../../../../../../ponto_mobile_collector.dart';
import '../../../domain/entities/fence.dart';
import '../../../domain/entities/perimeter.dart';
import '../../../domain/input_model/fence_dto.dart';
import '../../../domain/input_model/perimeter_dto.dart';
import '../../../external/drift/collector_database.dart';



class FenceRepository implements IFenceRepository {
  CollectorDatabase database;
  final IPerimeterRepository perimeterRepository;
  final IFencePerimeterRepository fencePerimeterRepository;
  final IEmployeeFenceRepository employeeFenceRepository;

  FenceRepository({
    required this.database,
    required this.employeeFenceRepository,
    required this.fencePerimeterRepository,
    required this.perimeterRepository,
  });

  @override
  Future<bool> exist({
    required String id,
  }) async {
    final query = database.select(database.fenceTable);
    query.where((tbl) => tbl.id.equals(id));
    FenceTableData? tableData = await query.getSingleOrNull();
    return tableData != null;
  }

  @override
  Future<int> insert({
    required Fence fence,
  }) async {
    FenceTableData tableData = convertToTable(fence: fence);
    return database.into(database.fenceTable).insert(tableData);
  }

  @override
  Future<bool> update({
    required Fence fence,
  }) async {
    FenceTableData tableData = convertToTable(fence: fence);
    return database.update(database.fenceTable).replace(tableData);
  }

  @override
  Future<bool> save({
    required Fence fence,
  }) async {
    // Save Fence
    if (await exist(id: fence.id!)) {
      await update(fence: fence);
    } else {
      await insert(fence: fence);
    }

    // Save Perimeters
    if (fence.perimeters!.isNotEmpty) {
      for (Perimeter perimeter in fence.perimeters!) {
        await perimeterRepository.save(perimeter: perimeter);

        await fencePerimeterRepository.save(
          fenceId: fence.id ?? '',
          perimeterId: perimeter.id ?? '',
        );
      }
    }

    return true;
  }

  @override
  Future<bool> saveAll({
    required List<Fence> fences,
  }) async {
    if (fences.isNotEmpty) {
      for (Fence fence in fences) {
        await save(fence: fence);
      }
    }

    return true;
  }

  @override
  Future<List<Fence>> getAll() async {
    List<FenceTableData> fencesTable =
        await database.select(database.fenceTable).get();
    List<Fence> fences =
        await findPerimetersByFences(fencesTable: fencesTable);
    return fences;
  }

  @override
  Future<List<Fence>> findAllByEmployeeId({
    required String employeeId,
  }) async {
    List<String> fencesId = await employeeFenceRepository.findAllByEmployeeId(
      employeeId: employeeId,
    );

    final query = database.select(database.fenceTable);
    query.where((tbl) => tbl.id.isIn(fencesId));
    List<FenceTableData> tableDatas = await query.get();
    List<Fence> fences = [];
    for (FenceTableData fenceData in tableDatas) {
      Fence fence = Fence(
        id: fenceData.id,
        name: fenceData.name,
        perimeters: await perimeterRepository.findAllByFenceId(
          fenceId: fenceData.id,
        ),
      );

      fences.add(fence);
    }
    return fences;
  }

  Future<List<Fence>> findPerimetersByFences({
    required List<FenceTableData> fencesTable,
  }) async {
    List<Fence> fences = [];
    for (FenceTableData fenceData in fencesTable) {
      Fence fence = converToFence(
        tableData: fenceData,
        perimetersDto:
            await perimeterRepository.findAllByFenceId(fenceId: fenceData.id),
      );

      fences.add(fence);
    }

    return fences;
  }

  @override
  FenceTableData convertToTable({
    required Fence fence,
  }) {
    FenceTableData tableData = FenceTableData(
      id: fence.id ?? '',
      name: fence.name,
    );

    return tableData;
  }

  FenceDto converToDto({
    required FenceTableData tableData,
    required List<PerimeterDto> perimetersDto,
  }) {
    FenceDto fence = FenceDto(
      id: tableData.id,
      name: tableData.name,
      perimeters: perimetersDto,
    );

    return fence;
  }

  Fence converToFence({required FenceTableData tableData, required List<Perimeter> perimetersDto}) {
    Fence fence = Fence(
      id: tableData.id,
      name: tableData.name,
      perimeters: perimetersDto,
    );

    return fence;
  }

}
