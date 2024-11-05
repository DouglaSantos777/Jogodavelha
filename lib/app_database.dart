// app_database.dart
import 'package:drift/drift.dart';
import 'package:drift/native.dart';

part 'app_database.g.dart';

@DataClassName('GameRecord')
class GameRecords extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get playerX => text()();
  TextColumn get playerY => text()();
  TextColumn get winner => text()();
}

@DriftDatabase(tables: [GameRecords])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(NativeDatabase.memory()); 

  @override
  int get schemaVersion => 1; 

  Future<List<GameRecord>> getAllGameRecords() => select(gameRecords).get();
  Future<void> insertGameRecord(GameRecord record) => into(gameRecords).insert(record);
}
