import 'package:drift/drift.dart';

import 'fence_table.dart';
import 'perimeter_table.dart';

class FencePerimeterTable extends Table {
  TextColumn get perimeterId => text().references(PerimeterTable, #id)();
  TextColumn get fenceId => text().references(FenceTable, #id)();

  @override
  Set<Column> get primaryKey => {perimeterId, fenceId};
}
