import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'collector_database.dart';

CollectorDatabase localDatabase =
    CollectorDatabase(database: _openConnection());

LazyDatabase _openConnection() {
  return LazyDatabase(
    () async {
      Directory dbFolder = await getApplicationDocumentsDirectory();
      File file = File(
        p.join(dbFolder.path, 'ponto_mobile_sqlite.db'),
      );
      return NativeDatabase.createInBackground(file);
    },
  );
}
