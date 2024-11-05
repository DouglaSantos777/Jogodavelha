// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $GameRecordsTable extends GameRecords
    with TableInfo<$GameRecordsTable, GameRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GameRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _playerXMeta =
      const VerificationMeta('playerX');
  @override
  late final GeneratedColumn<String> playerX = GeneratedColumn<String>(
      'player_x', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _playerYMeta =
      const VerificationMeta('playerY');
  @override
  late final GeneratedColumn<String> playerY = GeneratedColumn<String>(
      'player_y', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _winnerMeta = const VerificationMeta('winner');
  @override
  late final GeneratedColumn<String> winner = GeneratedColumn<String>(
      'winner', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, playerX, playerY, winner];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'game_records';
  @override
  VerificationContext validateIntegrity(Insertable<GameRecord> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('player_x')) {
      context.handle(_playerXMeta,
          playerX.isAcceptableOrUnknown(data['player_x']!, _playerXMeta));
    } else if (isInserting) {
      context.missing(_playerXMeta);
    }
    if (data.containsKey('player_y')) {
      context.handle(_playerYMeta,
          playerY.isAcceptableOrUnknown(data['player_y']!, _playerYMeta));
    } else if (isInserting) {
      context.missing(_playerYMeta);
    }
    if (data.containsKey('winner')) {
      context.handle(_winnerMeta,
          winner.isAcceptableOrUnknown(data['winner']!, _winnerMeta));
    } else if (isInserting) {
      context.missing(_winnerMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GameRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GameRecord(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      playerX: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}player_x'])!,
      playerY: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}player_y'])!,
      winner: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}winner'])!,
    );
  }

  @override
  $GameRecordsTable createAlias(String alias) {
    return $GameRecordsTable(attachedDatabase, alias);
  }
}

class GameRecord extends DataClass implements Insertable<GameRecord> {
  final int id;
  final String playerX;
  final String playerY;
  final String winner;
  const GameRecord(
      {required this.id,
      required this.playerX,
      required this.playerY,
      required this.winner});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['player_x'] = Variable<String>(playerX);
    map['player_y'] = Variable<String>(playerY);
    map['winner'] = Variable<String>(winner);
    return map;
  }

  GameRecordsCompanion toCompanion(bool nullToAbsent) {
    return GameRecordsCompanion(
      id: Value(id),
      playerX: Value(playerX),
      playerY: Value(playerY),
      winner: Value(winner),
    );
  }

  factory GameRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GameRecord(
      id: serializer.fromJson<int>(json['id']),
      playerX: serializer.fromJson<String>(json['playerX']),
      playerY: serializer.fromJson<String>(json['playerY']),
      winner: serializer.fromJson<String>(json['winner']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'playerX': serializer.toJson<String>(playerX),
      'playerY': serializer.toJson<String>(playerY),
      'winner': serializer.toJson<String>(winner),
    };
  }

  GameRecord copyWith(
          {int? id, String? playerX, String? playerY, String? winner}) =>
      GameRecord(
        id: id ?? this.id,
        playerX: playerX ?? this.playerX,
        playerY: playerY ?? this.playerY,
        winner: winner ?? this.winner,
      );
  GameRecord copyWithCompanion(GameRecordsCompanion data) {
    return GameRecord(
      id: data.id.present ? data.id.value : this.id,
      playerX: data.playerX.present ? data.playerX.value : this.playerX,
      playerY: data.playerY.present ? data.playerY.value : this.playerY,
      winner: data.winner.present ? data.winner.value : this.winner,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GameRecord(')
          ..write('id: $id, ')
          ..write('playerX: $playerX, ')
          ..write('playerY: $playerY, ')
          ..write('winner: $winner')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, playerX, playerY, winner);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GameRecord &&
          other.id == this.id &&
          other.playerX == this.playerX &&
          other.playerY == this.playerY &&
          other.winner == this.winner);
}

class GameRecordsCompanion extends UpdateCompanion<GameRecord> {
  final Value<int> id;
  final Value<String> playerX;
  final Value<String> playerY;
  final Value<String> winner;
  const GameRecordsCompanion({
    this.id = const Value.absent(),
    this.playerX = const Value.absent(),
    this.playerY = const Value.absent(),
    this.winner = const Value.absent(),
  });
  GameRecordsCompanion.insert({
    this.id = const Value.absent(),
    required String playerX,
    required String playerY,
    required String winner,
  })  : playerX = Value(playerX),
        playerY = Value(playerY),
        winner = Value(winner);
  static Insertable<GameRecord> custom({
    Expression<int>? id,
    Expression<String>? playerX,
    Expression<String>? playerY,
    Expression<String>? winner,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (playerX != null) 'player_x': playerX,
      if (playerY != null) 'player_y': playerY,
      if (winner != null) 'winner': winner,
    });
  }

  GameRecordsCompanion copyWith(
      {Value<int>? id,
      Value<String>? playerX,
      Value<String>? playerY,
      Value<String>? winner}) {
    return GameRecordsCompanion(
      id: id ?? this.id,
      playerX: playerX ?? this.playerX,
      playerY: playerY ?? this.playerY,
      winner: winner ?? this.winner,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (playerX.present) {
      map['player_x'] = Variable<String>(playerX.value);
    }
    if (playerY.present) {
      map['player_y'] = Variable<String>(playerY.value);
    }
    if (winner.present) {
      map['winner'] = Variable<String>(winner.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GameRecordsCompanion(')
          ..write('id: $id, ')
          ..write('playerX: $playerX, ')
          ..write('playerY: $playerY, ')
          ..write('winner: $winner')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $GameRecordsTable gameRecords = $GameRecordsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [gameRecords];
}

typedef $$GameRecordsTableCreateCompanionBuilder = GameRecordsCompanion
    Function({
  Value<int> id,
  required String playerX,
  required String playerY,
  required String winner,
});
typedef $$GameRecordsTableUpdateCompanionBuilder = GameRecordsCompanion
    Function({
  Value<int> id,
  Value<String> playerX,
  Value<String> playerY,
  Value<String> winner,
});

class $$GameRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $GameRecordsTable> {
  $$GameRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get playerX => $composableBuilder(
      column: $table.playerX, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get playerY => $composableBuilder(
      column: $table.playerY, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get winner => $composableBuilder(
      column: $table.winner, builder: (column) => ColumnFilters(column));
}

class $$GameRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $GameRecordsTable> {
  $$GameRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get playerX => $composableBuilder(
      column: $table.playerX, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get playerY => $composableBuilder(
      column: $table.playerY, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get winner => $composableBuilder(
      column: $table.winner, builder: (column) => ColumnOrderings(column));
}

class $$GameRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $GameRecordsTable> {
  $$GameRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get playerX =>
      $composableBuilder(column: $table.playerX, builder: (column) => column);

  GeneratedColumn<String> get playerY =>
      $composableBuilder(column: $table.playerY, builder: (column) => column);

  GeneratedColumn<String> get winner =>
      $composableBuilder(column: $table.winner, builder: (column) => column);
}

class $$GameRecordsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $GameRecordsTable,
    GameRecord,
    $$GameRecordsTableFilterComposer,
    $$GameRecordsTableOrderingComposer,
    $$GameRecordsTableAnnotationComposer,
    $$GameRecordsTableCreateCompanionBuilder,
    $$GameRecordsTableUpdateCompanionBuilder,
    (GameRecord, BaseReferences<_$AppDatabase, $GameRecordsTable, GameRecord>),
    GameRecord,
    PrefetchHooks Function()> {
  $$GameRecordsTableTableManager(_$AppDatabase db, $GameRecordsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GameRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GameRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GameRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> playerX = const Value.absent(),
            Value<String> playerY = const Value.absent(),
            Value<String> winner = const Value.absent(),
          }) =>
              GameRecordsCompanion(
            id: id,
            playerX: playerX,
            playerY: playerY,
            winner: winner,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String playerX,
            required String playerY,
            required String winner,
          }) =>
              GameRecordsCompanion.insert(
            id: id,
            playerX: playerX,
            playerY: playerY,
            winner: winner,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$GameRecordsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $GameRecordsTable,
    GameRecord,
    $$GameRecordsTableFilterComposer,
    $$GameRecordsTableOrderingComposer,
    $$GameRecordsTableAnnotationComposer,
    $$GameRecordsTableCreateCompanionBuilder,
    $$GameRecordsTableUpdateCompanionBuilder,
    (GameRecord, BaseReferences<_$AppDatabase, $GameRecordsTable, GameRecord>),
    GameRecord,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$GameRecordsTableTableManager get gameRecords =>
      $$GameRecordsTableTableManager(_db, _db.gameRecords);
}
