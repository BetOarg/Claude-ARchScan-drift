// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_database.dart';

// ignore_for_file: type=lint
class $ProjectsTable extends Projects with TableInfo<$ProjectsTable, Project> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProjectsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
      'uuid', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, uuid, name, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'projects';
  @override
  VerificationContext validateIntegrity(Insertable<Project> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('uuid')) {
      context.handle(
          _uuidMeta, uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta));
    } else if (isInserting) {
      context.missing(_uuidMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Project map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Project(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      uuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uuid'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $ProjectsTable createAlias(String alias) {
    return $ProjectsTable(attachedDatabase, alias);
  }
}

class Project extends DataClass implements Insertable<Project> {
  final int id;
  final String uuid;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Project(
      {required this.id,
      required this.uuid,
      required this.name,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['uuid'] = Variable<String>(uuid);
    map['name'] = Variable<String>(name);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ProjectsCompanion toCompanion(bool nullToAbsent) {
    return ProjectsCompanion(
      id: Value(id),
      uuid: Value(uuid),
      name: Value(name),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Project.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Project(
      id: serializer.fromJson<int>(json['id']),
      uuid: serializer.fromJson<String>(json['uuid']),
      name: serializer.fromJson<String>(json['name']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'uuid': serializer.toJson<String>(uuid),
      'name': serializer.toJson<String>(name),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Project copyWith(
          {int? id,
          String? uuid,
          String? name,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      Project(
        id: id ?? this.id,
        uuid: uuid ?? this.uuid,
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Project copyWithCompanion(ProjectsCompanion data) {
    return Project(
      id: data.id.present ? data.id.value : this.id,
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
      name: data.name.present ? data.name.value : this.name,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Project(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, uuid, name, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Project &&
          other.id == this.id &&
          other.uuid == this.uuid &&
          other.name == this.name &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ProjectsCompanion extends UpdateCompanion<Project> {
  final Value<int> id;
  final Value<String> uuid;
  final Value<String> name;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const ProjectsCompanion({
    this.id = const Value.absent(),
    this.uuid = const Value.absent(),
    this.name = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ProjectsCompanion.insert({
    this.id = const Value.absent(),
    required String uuid,
    required String name,
    required DateTime createdAt,
    required DateTime updatedAt,
  })  : uuid = Value(uuid),
        name = Value(name),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<Project> custom({
    Expression<int>? id,
    Expression<String>? uuid,
    Expression<String>? name,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uuid != null) 'uuid': uuid,
      if (name != null) 'name': name,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  ProjectsCompanion copyWith(
      {Value<int>? id,
      Value<String>? uuid,
      Value<String>? name,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return ProjectsCompanion(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProjectsCompanion(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $RoomsTable extends Rooms with TableInfo<$RoomsTable, Room> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RoomsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _projectIdMeta =
      const VerificationMeta('projectId');
  @override
  late final GeneratedColumn<int> projectId = GeneratedColumn<int>(
      'project_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES projects (id)'));
  static const VerificationMeta _roomIdMeta = const VerificationMeta('roomId');
  @override
  late final GeneratedColumn<String> roomId = GeneratedColumn<String>(
      'room_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isClosedMeta =
      const VerificationMeta('isClosed');
  @override
  late final GeneratedColumn<bool> isClosed = GeneratedColumn<bool>(
      'is_closed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_closed" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns =>
      [id, projectId, roomId, name, type, isClosed];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'rooms';
  @override
  VerificationContext validateIntegrity(Insertable<Room> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('project_id')) {
      context.handle(_projectIdMeta,
          projectId.isAcceptableOrUnknown(data['project_id']!, _projectIdMeta));
    } else if (isInserting) {
      context.missing(_projectIdMeta);
    }
    if (data.containsKey('room_id')) {
      context.handle(_roomIdMeta,
          roomId.isAcceptableOrUnknown(data['room_id']!, _roomIdMeta));
    } else if (isInserting) {
      context.missing(_roomIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('is_closed')) {
      context.handle(_isClosedMeta,
          isClosed.isAcceptableOrUnknown(data['is_closed']!, _isClosedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Room map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Room(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      projectId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}project_id'])!,
      roomId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}room_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      isClosed: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_closed'])!,
    );
  }

  @override
  $RoomsTable createAlias(String alias) {
    return $RoomsTable(attachedDatabase, alias);
  }
}

class Room extends DataClass implements Insertable<Room> {
  final int id;
  final int projectId;
  final String roomId;
  final String name;
  final String type;
  final bool isClosed;
  const Room(
      {required this.id,
      required this.projectId,
      required this.roomId,
      required this.name,
      required this.type,
      required this.isClosed});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['project_id'] = Variable<int>(projectId);
    map['room_id'] = Variable<String>(roomId);
    map['name'] = Variable<String>(name);
    map['type'] = Variable<String>(type);
    map['is_closed'] = Variable<bool>(isClosed);
    return map;
  }

  RoomsCompanion toCompanion(bool nullToAbsent) {
    return RoomsCompanion(
      id: Value(id),
      projectId: Value(projectId),
      roomId: Value(roomId),
      name: Value(name),
      type: Value(type),
      isClosed: Value(isClosed),
    );
  }

  factory Room.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Room(
      id: serializer.fromJson<int>(json['id']),
      projectId: serializer.fromJson<int>(json['projectId']),
      roomId: serializer.fromJson<String>(json['roomId']),
      name: serializer.fromJson<String>(json['name']),
      type: serializer.fromJson<String>(json['type']),
      isClosed: serializer.fromJson<bool>(json['isClosed']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'projectId': serializer.toJson<int>(projectId),
      'roomId': serializer.toJson<String>(roomId),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<String>(type),
      'isClosed': serializer.toJson<bool>(isClosed),
    };
  }

  Room copyWith(
          {int? id,
          int? projectId,
          String? roomId,
          String? name,
          String? type,
          bool? isClosed}) =>
      Room(
        id: id ?? this.id,
        projectId: projectId ?? this.projectId,
        roomId: roomId ?? this.roomId,
        name: name ?? this.name,
        type: type ?? this.type,
        isClosed: isClosed ?? this.isClosed,
      );
  Room copyWithCompanion(RoomsCompanion data) {
    return Room(
      id: data.id.present ? data.id.value : this.id,
      projectId: data.projectId.present ? data.projectId.value : this.projectId,
      roomId: data.roomId.present ? data.roomId.value : this.roomId,
      name: data.name.present ? data.name.value : this.name,
      type: data.type.present ? data.type.value : this.type,
      isClosed: data.isClosed.present ? data.isClosed.value : this.isClosed,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Room(')
          ..write('id: $id, ')
          ..write('projectId: $projectId, ')
          ..write('roomId: $roomId, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('isClosed: $isClosed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, projectId, roomId, name, type, isClosed);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Room &&
          other.id == this.id &&
          other.projectId == this.projectId &&
          other.roomId == this.roomId &&
          other.name == this.name &&
          other.type == this.type &&
          other.isClosed == this.isClosed);
}

class RoomsCompanion extends UpdateCompanion<Room> {
  final Value<int> id;
  final Value<int> projectId;
  final Value<String> roomId;
  final Value<String> name;
  final Value<String> type;
  final Value<bool> isClosed;
  const RoomsCompanion({
    this.id = const Value.absent(),
    this.projectId = const Value.absent(),
    this.roomId = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.isClosed = const Value.absent(),
  });
  RoomsCompanion.insert({
    this.id = const Value.absent(),
    required int projectId,
    required String roomId,
    required String name,
    required String type,
    this.isClosed = const Value.absent(),
  })  : projectId = Value(projectId),
        roomId = Value(roomId),
        name = Value(name),
        type = Value(type);
  static Insertable<Room> custom({
    Expression<int>? id,
    Expression<int>? projectId,
    Expression<String>? roomId,
    Expression<String>? name,
    Expression<String>? type,
    Expression<bool>? isClosed,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (projectId != null) 'project_id': projectId,
      if (roomId != null) 'room_id': roomId,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (isClosed != null) 'is_closed': isClosed,
    });
  }

  RoomsCompanion copyWith(
      {Value<int>? id,
      Value<int>? projectId,
      Value<String>? roomId,
      Value<String>? name,
      Value<String>? type,
      Value<bool>? isClosed}) {
    return RoomsCompanion(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      roomId: roomId ?? this.roomId,
      name: name ?? this.name,
      type: type ?? this.type,
      isClosed: isClosed ?? this.isClosed,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (projectId.present) {
      map['project_id'] = Variable<int>(projectId.value);
    }
    if (roomId.present) {
      map['room_id'] = Variable<String>(roomId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (isClosed.present) {
      map['is_closed'] = Variable<bool>(isClosed.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RoomsCompanion(')
          ..write('id: $id, ')
          ..write('projectId: $projectId, ')
          ..write('roomId: $roomId, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('isClosed: $isClosed')
          ..write(')'))
        .toString();
  }
}

class $RoomPointsTable extends RoomPoints
    with TableInfo<$RoomPointsTable, RoomPoint> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RoomPointsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _roomIdMeta = const VerificationMeta('roomId');
  @override
  late final GeneratedColumn<int> roomId = GeneratedColumn<int>(
      'room_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES rooms (id)'));
  static const VerificationMeta _xMeta = const VerificationMeta('x');
  @override
  late final GeneratedColumn<double> x = GeneratedColumn<double>(
      'x', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _yMeta = const VerificationMeta('y');
  @override
  late final GeneratedColumn<double> y = GeneratedColumn<double>(
      'y', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _zMeta = const VerificationMeta('z');
  @override
  late final GeneratedColumn<double> z = GeneratedColumn<double>(
      'z', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, roomId, x, y, z];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'room_points';
  @override
  VerificationContext validateIntegrity(Insertable<RoomPoint> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('room_id')) {
      context.handle(_roomIdMeta,
          roomId.isAcceptableOrUnknown(data['room_id']!, _roomIdMeta));
    } else if (isInserting) {
      context.missing(_roomIdMeta);
    }
    if (data.containsKey('x')) {
      context.handle(_xMeta, x.isAcceptableOrUnknown(data['x']!, _xMeta));
    } else if (isInserting) {
      context.missing(_xMeta);
    }
    if (data.containsKey('y')) {
      context.handle(_yMeta, y.isAcceptableOrUnknown(data['y']!, _yMeta));
    } else if (isInserting) {
      context.missing(_yMeta);
    }
    if (data.containsKey('z')) {
      context.handle(_zMeta, z.isAcceptableOrUnknown(data['z']!, _zMeta));
    } else if (isInserting) {
      context.missing(_zMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RoomPoint map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RoomPoint(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      roomId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}room_id'])!,
      x: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}x'])!,
      y: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}y'])!,
      z: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}z'])!,
    );
  }

  @override
  $RoomPointsTable createAlias(String alias) {
    return $RoomPointsTable(attachedDatabase, alias);
  }
}

class RoomPoint extends DataClass implements Insertable<RoomPoint> {
  final int id;
  final int roomId;
  final double x;
  final double y;
  final double z;
  const RoomPoint(
      {required this.id,
      required this.roomId,
      required this.x,
      required this.y,
      required this.z});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['room_id'] = Variable<int>(roomId);
    map['x'] = Variable<double>(x);
    map['y'] = Variable<double>(y);
    map['z'] = Variable<double>(z);
    return map;
  }

  RoomPointsCompanion toCompanion(bool nullToAbsent) {
    return RoomPointsCompanion(
      id: Value(id),
      roomId: Value(roomId),
      x: Value(x),
      y: Value(y),
      z: Value(z),
    );
  }

  factory RoomPoint.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RoomPoint(
      id: serializer.fromJson<int>(json['id']),
      roomId: serializer.fromJson<int>(json['roomId']),
      x: serializer.fromJson<double>(json['x']),
      y: serializer.fromJson<double>(json['y']),
      z: serializer.fromJson<double>(json['z']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'roomId': serializer.toJson<int>(roomId),
      'x': serializer.toJson<double>(x),
      'y': serializer.toJson<double>(y),
      'z': serializer.toJson<double>(z),
    };
  }

  RoomPoint copyWith({int? id, int? roomId, double? x, double? y, double? z}) =>
      RoomPoint(
        id: id ?? this.id,
        roomId: roomId ?? this.roomId,
        x: x ?? this.x,
        y: y ?? this.y,
        z: z ?? this.z,
      );
  RoomPoint copyWithCompanion(RoomPointsCompanion data) {
    return RoomPoint(
      id: data.id.present ? data.id.value : this.id,
      roomId: data.roomId.present ? data.roomId.value : this.roomId,
      x: data.x.present ? data.x.value : this.x,
      y: data.y.present ? data.y.value : this.y,
      z: data.z.present ? data.z.value : this.z,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RoomPoint(')
          ..write('id: $id, ')
          ..write('roomId: $roomId, ')
          ..write('x: $x, ')
          ..write('y: $y, ')
          ..write('z: $z')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, roomId, x, y, z);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RoomPoint &&
          other.id == this.id &&
          other.roomId == this.roomId &&
          other.x == this.x &&
          other.y == this.y &&
          other.z == this.z);
}

class RoomPointsCompanion extends UpdateCompanion<RoomPoint> {
  final Value<int> id;
  final Value<int> roomId;
  final Value<double> x;
  final Value<double> y;
  final Value<double> z;
  const RoomPointsCompanion({
    this.id = const Value.absent(),
    this.roomId = const Value.absent(),
    this.x = const Value.absent(),
    this.y = const Value.absent(),
    this.z = const Value.absent(),
  });
  RoomPointsCompanion.insert({
    this.id = const Value.absent(),
    required int roomId,
    required double x,
    required double y,
    required double z,
  })  : roomId = Value(roomId),
        x = Value(x),
        y = Value(y),
        z = Value(z);
  static Insertable<RoomPoint> custom({
    Expression<int>? id,
    Expression<int>? roomId,
    Expression<double>? x,
    Expression<double>? y,
    Expression<double>? z,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (roomId != null) 'room_id': roomId,
      if (x != null) 'x': x,
      if (y != null) 'y': y,
      if (z != null) 'z': z,
    });
  }

  RoomPointsCompanion copyWith(
      {Value<int>? id,
      Value<int>? roomId,
      Value<double>? x,
      Value<double>? y,
      Value<double>? z}) {
    return RoomPointsCompanion(
      id: id ?? this.id,
      roomId: roomId ?? this.roomId,
      x: x ?? this.x,
      y: y ?? this.y,
      z: z ?? this.z,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (roomId.present) {
      map['room_id'] = Variable<int>(roomId.value);
    }
    if (x.present) {
      map['x'] = Variable<double>(x.value);
    }
    if (y.present) {
      map['y'] = Variable<double>(y.value);
    }
    if (z.present) {
      map['z'] = Variable<double>(z.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RoomPointsCompanion(')
          ..write('id: $id, ')
          ..write('roomId: $roomId, ')
          ..write('x: $x, ')
          ..write('y: $y, ')
          ..write('z: $z')
          ..write(')'))
        .toString();
  }
}

class $WallFeaturesTableTable extends WallFeaturesTable
    with TableInfo<$WallFeaturesTableTable, WallFeaturesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WallFeaturesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _roomIdMeta = const VerificationMeta('roomId');
  @override
  late final GeneratedColumn<int> roomId = GeneratedColumn<int>(
      'room_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES rooms (id)'));
  static const VerificationMeta _featureIdMeta =
      const VerificationMeta('featureId');
  @override
  late final GeneratedColumn<String> featureId = GeneratedColumn<String>(
      'feature_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _connectedRoomIdMeta =
      const VerificationMeta('connectedRoomId');
  @override
  late final GeneratedColumn<String> connectedRoomId = GeneratedColumn<String>(
      'connected_room_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _connectionSideMeta =
      const VerificationMeta('connectionSide');
  @override
  late final GeneratedColumn<String> connectionSide = GeneratedColumn<String>(
      'connection_side', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _startXMeta = const VerificationMeta('startX');
  @override
  late final GeneratedColumn<double> startX = GeneratedColumn<double>(
      'start_x', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _startYMeta = const VerificationMeta('startY');
  @override
  late final GeneratedColumn<double> startY = GeneratedColumn<double>(
      'start_y', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _startZMeta = const VerificationMeta('startZ');
  @override
  late final GeneratedColumn<double> startZ = GeneratedColumn<double>(
      'start_z', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _endXMeta = const VerificationMeta('endX');
  @override
  late final GeneratedColumn<double> endX = GeneratedColumn<double>(
      'end_x', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _endYMeta = const VerificationMeta('endY');
  @override
  late final GeneratedColumn<double> endY = GeneratedColumn<double>(
      'end_y', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _endZMeta = const VerificationMeta('endZ');
  @override
  late final GeneratedColumn<double> endZ = GeneratedColumn<double>(
      'end_z', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _hingeSideMeta =
      const VerificationMeta('hingeSide');
  @override
  late final GeneratedColumn<String> hingeSide = GeneratedColumn<String>(
      'hinge_side', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('start'));
  static const VerificationMeta _swingSideMeta =
      const VerificationMeta('swingSide');
  @override
  late final GeneratedColumn<String> swingSide = GeneratedColumn<String>(
      'swing_side', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('left'));
  static const VerificationMeta _openingDirectionMeta =
      const VerificationMeta('openingDirection');
  @override
  late final GeneratedColumn<String> openingDirection = GeneratedColumn<String>(
      'opening_direction', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('interior'));
  static const VerificationMeta _openingHeightMeta =
      const VerificationMeta('openingHeight');
  @override
  late final GeneratedColumn<double> openingHeight = GeneratedColumn<double>(
      'opening_height', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _sillHeightMeta =
      const VerificationMeta('sillHeight');
  @override
  late final GeneratedColumn<double> sillHeight = GeneratedColumn<double>(
      'sill_height', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        roomId,
        featureId,
        type,
        connectedRoomId,
        connectionSide,
        startX,
        startY,
        startZ,
        endX,
        endY,
        endZ,
        hingeSide,
        swingSide,
        openingDirection,
        openingHeight,
        sillHeight
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'wall_features_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<WallFeaturesTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('room_id')) {
      context.handle(_roomIdMeta,
          roomId.isAcceptableOrUnknown(data['room_id']!, _roomIdMeta));
    } else if (isInserting) {
      context.missing(_roomIdMeta);
    }
    if (data.containsKey('feature_id')) {
      context.handle(_featureIdMeta,
          featureId.isAcceptableOrUnknown(data['feature_id']!, _featureIdMeta));
    } else if (isInserting) {
      context.missing(_featureIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('connected_room_id')) {
      context.handle(
          _connectedRoomIdMeta,
          connectedRoomId.isAcceptableOrUnknown(
              data['connected_room_id']!, _connectedRoomIdMeta));
    }
    if (data.containsKey('connection_side')) {
      context.handle(
          _connectionSideMeta,
          connectionSide.isAcceptableOrUnknown(
              data['connection_side']!, _connectionSideMeta));
    }
    if (data.containsKey('start_x')) {
      context.handle(_startXMeta,
          startX.isAcceptableOrUnknown(data['start_x']!, _startXMeta));
    } else if (isInserting) {
      context.missing(_startXMeta);
    }
    if (data.containsKey('start_y')) {
      context.handle(_startYMeta,
          startY.isAcceptableOrUnknown(data['start_y']!, _startYMeta));
    } else if (isInserting) {
      context.missing(_startYMeta);
    }
    if (data.containsKey('start_z')) {
      context.handle(_startZMeta,
          startZ.isAcceptableOrUnknown(data['start_z']!, _startZMeta));
    } else if (isInserting) {
      context.missing(_startZMeta);
    }
    if (data.containsKey('end_x')) {
      context.handle(
          _endXMeta, endX.isAcceptableOrUnknown(data['end_x']!, _endXMeta));
    } else if (isInserting) {
      context.missing(_endXMeta);
    }
    if (data.containsKey('end_y')) {
      context.handle(
          _endYMeta, endY.isAcceptableOrUnknown(data['end_y']!, _endYMeta));
    } else if (isInserting) {
      context.missing(_endYMeta);
    }
    if (data.containsKey('end_z')) {
      context.handle(
          _endZMeta, endZ.isAcceptableOrUnknown(data['end_z']!, _endZMeta));
    } else if (isInserting) {
      context.missing(_endZMeta);
    }
    if (data.containsKey('hinge_side')) {
      context.handle(_hingeSideMeta,
          hingeSide.isAcceptableOrUnknown(data['hinge_side']!, _hingeSideMeta));
    }
    if (data.containsKey('swing_side')) {
      context.handle(_swingSideMeta,
          swingSide.isAcceptableOrUnknown(data['swing_side']!, _swingSideMeta));
    }
    if (data.containsKey('opening_direction')) {
      context.handle(
          _openingDirectionMeta,
          openingDirection.isAcceptableOrUnknown(
              data['opening_direction']!, _openingDirectionMeta));
    }
    if (data.containsKey('opening_height')) {
      context.handle(
          _openingHeightMeta,
          openingHeight.isAcceptableOrUnknown(
              data['opening_height']!, _openingHeightMeta));
    }
    if (data.containsKey('sill_height')) {
      context.handle(
          _sillHeightMeta,
          sillHeight.isAcceptableOrUnknown(
              data['sill_height']!, _sillHeightMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WallFeaturesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WallFeaturesTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      roomId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}room_id'])!,
      featureId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}feature_id'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      connectedRoomId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}connected_room_id']),
      connectionSide: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}connection_side']),
      startX: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}start_x'])!,
      startY: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}start_y'])!,
      startZ: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}start_z'])!,
      endX: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}end_x'])!,
      endY: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}end_y'])!,
      endZ: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}end_z'])!,
      hingeSide: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}hinge_side'])!,
      swingSide: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}swing_side'])!,
      openingDirection: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}opening_direction'])!,
      openingHeight: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}opening_height']),
      sillHeight: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}sill_height']),
    );
  }

  @override
  $WallFeaturesTableTable createAlias(String alias) {
    return $WallFeaturesTableTable(attachedDatabase, alias);
  }
}

class WallFeaturesTableData extends DataClass
    implements Insertable<WallFeaturesTableData> {
  final int id;
  final int roomId;
  final String featureId;
  final String type;
  final String? connectedRoomId;
  final String? connectionSide;
  final double startX;
  final double startY;
  final double startZ;
  final double endX;
  final double endY;
  final double endZ;
  final String hingeSide;
  final String swingSide;
  final String openingDirection;
  final double? openingHeight;
  final double? sillHeight;
  const WallFeaturesTableData(
      {required this.id,
      required this.roomId,
      required this.featureId,
      required this.type,
      this.connectedRoomId,
      this.connectionSide,
      required this.startX,
      required this.startY,
      required this.startZ,
      required this.endX,
      required this.endY,
      required this.endZ,
      required this.hingeSide,
      required this.swingSide,
      required this.openingDirection,
      this.openingHeight,
      this.sillHeight});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['room_id'] = Variable<int>(roomId);
    map['feature_id'] = Variable<String>(featureId);
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || connectedRoomId != null) {
      map['connected_room_id'] = Variable<String>(connectedRoomId);
    }
    if (!nullToAbsent || connectionSide != null) {
      map['connection_side'] = Variable<String>(connectionSide);
    }
    map['start_x'] = Variable<double>(startX);
    map['start_y'] = Variable<double>(startY);
    map['start_z'] = Variable<double>(startZ);
    map['end_x'] = Variable<double>(endX);
    map['end_y'] = Variable<double>(endY);
    map['end_z'] = Variable<double>(endZ);
    map['hinge_side'] = Variable<String>(hingeSide);
    map['swing_side'] = Variable<String>(swingSide);
    map['opening_direction'] = Variable<String>(openingDirection);
    if (!nullToAbsent || openingHeight != null) {
      map['opening_height'] = Variable<double>(openingHeight);
    }
    if (!nullToAbsent || sillHeight != null) {
      map['sill_height'] = Variable<double>(sillHeight);
    }
    return map;
  }

  WallFeaturesTableCompanion toCompanion(bool nullToAbsent) {
    return WallFeaturesTableCompanion(
      id: Value(id),
      roomId: Value(roomId),
      featureId: Value(featureId),
      type: Value(type),
      connectedRoomId: connectedRoomId == null && nullToAbsent
          ? const Value.absent()
          : Value(connectedRoomId),
      connectionSide: connectionSide == null && nullToAbsent
          ? const Value.absent()
          : Value(connectionSide),
      startX: Value(startX),
      startY: Value(startY),
      startZ: Value(startZ),
      endX: Value(endX),
      endY: Value(endY),
      endZ: Value(endZ),
      hingeSide: Value(hingeSide),
      swingSide: Value(swingSide),
      openingDirection: Value(openingDirection),
      openingHeight: openingHeight == null && nullToAbsent
          ? const Value.absent()
          : Value(openingHeight),
      sillHeight: sillHeight == null && nullToAbsent
          ? const Value.absent()
          : Value(sillHeight),
    );
  }

  factory WallFeaturesTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WallFeaturesTableData(
      id: serializer.fromJson<int>(json['id']),
      roomId: serializer.fromJson<int>(json['roomId']),
      featureId: serializer.fromJson<String>(json['featureId']),
      type: serializer.fromJson<String>(json['type']),
      connectedRoomId: serializer.fromJson<String?>(json['connectedRoomId']),
      connectionSide: serializer.fromJson<String?>(json['connectionSide']),
      startX: serializer.fromJson<double>(json['startX']),
      startY: serializer.fromJson<double>(json['startY']),
      startZ: serializer.fromJson<double>(json['startZ']),
      endX: serializer.fromJson<double>(json['endX']),
      endY: serializer.fromJson<double>(json['endY']),
      endZ: serializer.fromJson<double>(json['endZ']),
      hingeSide: serializer.fromJson<String>(json['hingeSide']),
      swingSide: serializer.fromJson<String>(json['swingSide']),
      openingDirection: serializer.fromJson<String>(json['openingDirection']),
      openingHeight: serializer.fromJson<double?>(json['openingHeight']),
      sillHeight: serializer.fromJson<double?>(json['sillHeight']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'roomId': serializer.toJson<int>(roomId),
      'featureId': serializer.toJson<String>(featureId),
      'type': serializer.toJson<String>(type),
      'connectedRoomId': serializer.toJson<String?>(connectedRoomId),
      'connectionSide': serializer.toJson<String?>(connectionSide),
      'startX': serializer.toJson<double>(startX),
      'startY': serializer.toJson<double>(startY),
      'startZ': serializer.toJson<double>(startZ),
      'endX': serializer.toJson<double>(endX),
      'endY': serializer.toJson<double>(endY),
      'endZ': serializer.toJson<double>(endZ),
      'hingeSide': serializer.toJson<String>(hingeSide),
      'swingSide': serializer.toJson<String>(swingSide),
      'openingDirection': serializer.toJson<String>(openingDirection),
      'openingHeight': serializer.toJson<double?>(openingHeight),
      'sillHeight': serializer.toJson<double?>(sillHeight),
    };
  }

  WallFeaturesTableData copyWith(
          {int? id,
          int? roomId,
          String? featureId,
          String? type,
          Value<String?> connectedRoomId = const Value.absent(),
          Value<String?> connectionSide = const Value.absent(),
          double? startX,
          double? startY,
          double? startZ,
          double? endX,
          double? endY,
          double? endZ,
          String? hingeSide,
          String? swingSide,
          String? openingDirection,
          Value<double?> openingHeight = const Value.absent(),
          Value<double?> sillHeight = const Value.absent()}) =>
      WallFeaturesTableData(
        id: id ?? this.id,
        roomId: roomId ?? this.roomId,
        featureId: featureId ?? this.featureId,
        type: type ?? this.type,
        connectedRoomId: connectedRoomId.present
            ? connectedRoomId.value
            : this.connectedRoomId,
        connectionSide:
            connectionSide.present ? connectionSide.value : this.connectionSide,
        startX: startX ?? this.startX,
        startY: startY ?? this.startY,
        startZ: startZ ?? this.startZ,
        endX: endX ?? this.endX,
        endY: endY ?? this.endY,
        endZ: endZ ?? this.endZ,
        hingeSide: hingeSide ?? this.hingeSide,
        swingSide: swingSide ?? this.swingSide,
        openingDirection: openingDirection ?? this.openingDirection,
        openingHeight:
            openingHeight.present ? openingHeight.value : this.openingHeight,
        sillHeight: sillHeight.present ? sillHeight.value : this.sillHeight,
      );
  WallFeaturesTableData copyWithCompanion(WallFeaturesTableCompanion data) {
    return WallFeaturesTableData(
      id: data.id.present ? data.id.value : this.id,
      roomId: data.roomId.present ? data.roomId.value : this.roomId,
      featureId: data.featureId.present ? data.featureId.value : this.featureId,
      type: data.type.present ? data.type.value : this.type,
      connectedRoomId: data.connectedRoomId.present
          ? data.connectedRoomId.value
          : this.connectedRoomId,
      connectionSide: data.connectionSide.present
          ? data.connectionSide.value
          : this.connectionSide,
      startX: data.startX.present ? data.startX.value : this.startX,
      startY: data.startY.present ? data.startY.value : this.startY,
      startZ: data.startZ.present ? data.startZ.value : this.startZ,
      endX: data.endX.present ? data.endX.value : this.endX,
      endY: data.endY.present ? data.endY.value : this.endY,
      endZ: data.endZ.present ? data.endZ.value : this.endZ,
      hingeSide: data.hingeSide.present ? data.hingeSide.value : this.hingeSide,
      swingSide: data.swingSide.present ? data.swingSide.value : this.swingSide,
      openingDirection: data.openingDirection.present
          ? data.openingDirection.value
          : this.openingDirection,
      openingHeight: data.openingHeight.present
          ? data.openingHeight.value
          : this.openingHeight,
      sillHeight:
          data.sillHeight.present ? data.sillHeight.value : this.sillHeight,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WallFeaturesTableData(')
          ..write('id: $id, ')
          ..write('roomId: $roomId, ')
          ..write('featureId: $featureId, ')
          ..write('type: $type, ')
          ..write('connectedRoomId: $connectedRoomId, ')
          ..write('connectionSide: $connectionSide, ')
          ..write('startX: $startX, ')
          ..write('startY: $startY, ')
          ..write('startZ: $startZ, ')
          ..write('endX: $endX, ')
          ..write('endY: $endY, ')
          ..write('endZ: $endZ, ')
          ..write('hingeSide: $hingeSide, ')
          ..write('swingSide: $swingSide, ')
          ..write('openingDirection: $openingDirection, ')
          ..write('openingHeight: $openingHeight, ')
          ..write('sillHeight: $sillHeight')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      roomId,
      featureId,
      type,
      connectedRoomId,
      connectionSide,
      startX,
      startY,
      startZ,
      endX,
      endY,
      endZ,
      hingeSide,
      swingSide,
      openingDirection,
      openingHeight,
      sillHeight);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WallFeaturesTableData &&
          other.id == this.id &&
          other.roomId == this.roomId &&
          other.featureId == this.featureId &&
          other.type == this.type &&
          other.connectedRoomId == this.connectedRoomId &&
          other.connectionSide == this.connectionSide &&
          other.startX == this.startX &&
          other.startY == this.startY &&
          other.startZ == this.startZ &&
          other.endX == this.endX &&
          other.endY == this.endY &&
          other.endZ == this.endZ &&
          other.hingeSide == this.hingeSide &&
          other.swingSide == this.swingSide &&
          other.openingDirection == this.openingDirection &&
          other.openingHeight == this.openingHeight &&
          other.sillHeight == this.sillHeight);
}

class WallFeaturesTableCompanion
    extends UpdateCompanion<WallFeaturesTableData> {
  final Value<int> id;
  final Value<int> roomId;
  final Value<String> featureId;
  final Value<String> type;
  final Value<String?> connectedRoomId;
  final Value<String?> connectionSide;
  final Value<double> startX;
  final Value<double> startY;
  final Value<double> startZ;
  final Value<double> endX;
  final Value<double> endY;
  final Value<double> endZ;
  final Value<String> hingeSide;
  final Value<String> swingSide;
  final Value<String> openingDirection;
  final Value<double?> openingHeight;
  final Value<double?> sillHeight;
  const WallFeaturesTableCompanion({
    this.id = const Value.absent(),
    this.roomId = const Value.absent(),
    this.featureId = const Value.absent(),
    this.type = const Value.absent(),
    this.connectedRoomId = const Value.absent(),
    this.connectionSide = const Value.absent(),
    this.startX = const Value.absent(),
    this.startY = const Value.absent(),
    this.startZ = const Value.absent(),
    this.endX = const Value.absent(),
    this.endY = const Value.absent(),
    this.endZ = const Value.absent(),
    this.hingeSide = const Value.absent(),
    this.swingSide = const Value.absent(),
    this.openingDirection = const Value.absent(),
    this.openingHeight = const Value.absent(),
    this.sillHeight = const Value.absent(),
  });
  WallFeaturesTableCompanion.insert({
    this.id = const Value.absent(),
    required int roomId,
    required String featureId,
    required String type,
    this.connectedRoomId = const Value.absent(),
    this.connectionSide = const Value.absent(),
    required double startX,
    required double startY,
    required double startZ,
    required double endX,
    required double endY,
    required double endZ,
    this.hingeSide = const Value.absent(),
    this.swingSide = const Value.absent(),
    this.openingDirection = const Value.absent(),
    this.openingHeight = const Value.absent(),
    this.sillHeight = const Value.absent(),
  })  : roomId = Value(roomId),
        featureId = Value(featureId),
        type = Value(type),
        startX = Value(startX),
        startY = Value(startY),
        startZ = Value(startZ),
        endX = Value(endX),
        endY = Value(endY),
        endZ = Value(endZ);
  static Insertable<WallFeaturesTableData> custom({
    Expression<int>? id,
    Expression<int>? roomId,
    Expression<String>? featureId,
    Expression<String>? type,
    Expression<String>? connectedRoomId,
    Expression<String>? connectionSide,
    Expression<double>? startX,
    Expression<double>? startY,
    Expression<double>? startZ,
    Expression<double>? endX,
    Expression<double>? endY,
    Expression<double>? endZ,
    Expression<String>? hingeSide,
    Expression<String>? swingSide,
    Expression<String>? openingDirection,
    Expression<double>? openingHeight,
    Expression<double>? sillHeight,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (roomId != null) 'room_id': roomId,
      if (featureId != null) 'feature_id': featureId,
      if (type != null) 'type': type,
      if (connectedRoomId != null) 'connected_room_id': connectedRoomId,
      if (connectionSide != null) 'connection_side': connectionSide,
      if (startX != null) 'start_x': startX,
      if (startY != null) 'start_y': startY,
      if (startZ != null) 'start_z': startZ,
      if (endX != null) 'end_x': endX,
      if (endY != null) 'end_y': endY,
      if (endZ != null) 'end_z': endZ,
      if (hingeSide != null) 'hinge_side': hingeSide,
      if (swingSide != null) 'swing_side': swingSide,
      if (openingDirection != null) 'opening_direction': openingDirection,
      if (openingHeight != null) 'opening_height': openingHeight,
      if (sillHeight != null) 'sill_height': sillHeight,
    });
  }

  WallFeaturesTableCompanion copyWith(
      {Value<int>? id,
      Value<int>? roomId,
      Value<String>? featureId,
      Value<String>? type,
      Value<String?>? connectedRoomId,
      Value<String?>? connectionSide,
      Value<double>? startX,
      Value<double>? startY,
      Value<double>? startZ,
      Value<double>? endX,
      Value<double>? endY,
      Value<double>? endZ,
      Value<String>? hingeSide,
      Value<String>? swingSide,
      Value<String>? openingDirection,
      Value<double?>? openingHeight,
      Value<double?>? sillHeight}) {
    return WallFeaturesTableCompanion(
      id: id ?? this.id,
      roomId: roomId ?? this.roomId,
      featureId: featureId ?? this.featureId,
      type: type ?? this.type,
      connectedRoomId: connectedRoomId ?? this.connectedRoomId,
      connectionSide: connectionSide ?? this.connectionSide,
      startX: startX ?? this.startX,
      startY: startY ?? this.startY,
      startZ: startZ ?? this.startZ,
      endX: endX ?? this.endX,
      endY: endY ?? this.endY,
      endZ: endZ ?? this.endZ,
      hingeSide: hingeSide ?? this.hingeSide,
      swingSide: swingSide ?? this.swingSide,
      openingDirection: openingDirection ?? this.openingDirection,
      openingHeight: openingHeight ?? this.openingHeight,
      sillHeight: sillHeight ?? this.sillHeight,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (roomId.present) {
      map['room_id'] = Variable<int>(roomId.value);
    }
    if (featureId.present) {
      map['feature_id'] = Variable<String>(featureId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (connectedRoomId.present) {
      map['connected_room_id'] = Variable<String>(connectedRoomId.value);
    }
    if (connectionSide.present) {
      map['connection_side'] = Variable<String>(connectionSide.value);
    }
    if (startX.present) {
      map['start_x'] = Variable<double>(startX.value);
    }
    if (startY.present) {
      map['start_y'] = Variable<double>(startY.value);
    }
    if (startZ.present) {
      map['start_z'] = Variable<double>(startZ.value);
    }
    if (endX.present) {
      map['end_x'] = Variable<double>(endX.value);
    }
    if (endY.present) {
      map['end_y'] = Variable<double>(endY.value);
    }
    if (endZ.present) {
      map['end_z'] = Variable<double>(endZ.value);
    }
    if (hingeSide.present) {
      map['hinge_side'] = Variable<String>(hingeSide.value);
    }
    if (swingSide.present) {
      map['swing_side'] = Variable<String>(swingSide.value);
    }
    if (openingDirection.present) {
      map['opening_direction'] = Variable<String>(openingDirection.value);
    }
    if (openingHeight.present) {
      map['opening_height'] = Variable<double>(openingHeight.value);
    }
    if (sillHeight.present) {
      map['sill_height'] = Variable<double>(sillHeight.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WallFeaturesTableCompanion(')
          ..write('id: $id, ')
          ..write('roomId: $roomId, ')
          ..write('featureId: $featureId, ')
          ..write('type: $type, ')
          ..write('connectedRoomId: $connectedRoomId, ')
          ..write('connectionSide: $connectionSide, ')
          ..write('startX: $startX, ')
          ..write('startY: $startY, ')
          ..write('startZ: $startZ, ')
          ..write('endX: $endX, ')
          ..write('endY: $endY, ')
          ..write('endZ: $endZ, ')
          ..write('hingeSide: $hingeSide, ')
          ..write('swingSide: $swingSide, ')
          ..write('openingDirection: $openingDirection, ')
          ..write('openingHeight: $openingHeight, ')
          ..write('sillHeight: $sillHeight')
          ..write(')'))
        .toString();
  }
}

abstract class _$ArchScanDatabase extends GeneratedDatabase {
  _$ArchScanDatabase(QueryExecutor e) : super(e);
  $ArchScanDatabaseManager get managers => $ArchScanDatabaseManager(this);
  late final $ProjectsTable projects = $ProjectsTable(this);
  late final $RoomsTable rooms = $RoomsTable(this);
  late final $RoomPointsTable roomPoints = $RoomPointsTable(this);
  late final $WallFeaturesTableTable wallFeaturesTable =
      $WallFeaturesTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [projects, rooms, roomPoints, wallFeaturesTable];
}

typedef $$ProjectsTableCreateCompanionBuilder = ProjectsCompanion Function({
  Value<int> id,
  required String uuid,
  required String name,
  required DateTime createdAt,
  required DateTime updatedAt,
});
typedef $$ProjectsTableUpdateCompanionBuilder = ProjectsCompanion Function({
  Value<int> id,
  Value<String> uuid,
  Value<String> name,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

final class $$ProjectsTableReferences
    extends BaseReferences<_$ArchScanDatabase, $ProjectsTable, Project> {
  $$ProjectsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$RoomsTable, List<Room>> _roomsRefsTable(
          _$ArchScanDatabase db) =>
      MultiTypedResultKey.fromTable(db.rooms,
          aliasName: 'projects__id__rooms__project_id');

  $$RoomsTableProcessedTableManager get roomsRefs {
    final manager = $$RoomsTableTableManager($_db, $_db.rooms)
        .filter((f) => f.projectId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_roomsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ProjectsTableFilterComposer
    extends Composer<_$ArchScanDatabase, $ProjectsTable> {
  $$ProjectsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get uuid => $composableBuilder(
      column: $table.uuid, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  Expression<bool> roomsRefs(
      Expression<bool> Function($$RoomsTableFilterComposer f) f) {
    final $$RoomsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.rooms,
        getReferencedColumn: (t) => t.projectId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RoomsTableFilterComposer(
              $db: $db,
              $table: $db.rooms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ProjectsTableOrderingComposer
    extends Composer<_$ArchScanDatabase, $ProjectsTable> {
  $$ProjectsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get uuid => $composableBuilder(
      column: $table.uuid, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$ProjectsTableAnnotationComposer
    extends Composer<_$ArchScanDatabase, $ProjectsTable> {
  $$ProjectsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get uuid =>
      $composableBuilder(column: $table.uuid, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> roomsRefs<T extends Object>(
      Expression<T> Function($$RoomsTableAnnotationComposer a) f) {
    final $$RoomsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.rooms,
        getReferencedColumn: (t) => t.projectId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RoomsTableAnnotationComposer(
              $db: $db,
              $table: $db.rooms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ProjectsTableTableManager extends RootTableManager<
    _$ArchScanDatabase,
    $ProjectsTable,
    Project,
    $$ProjectsTableFilterComposer,
    $$ProjectsTableOrderingComposer,
    $$ProjectsTableAnnotationComposer,
    $$ProjectsTableCreateCompanionBuilder,
    $$ProjectsTableUpdateCompanionBuilder,
    (Project, $$ProjectsTableReferences),
    Project,
    PrefetchHooks Function({bool roomsRefs})> {
  $$ProjectsTableTableManager(_$ArchScanDatabase db, $ProjectsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProjectsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProjectsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProjectsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> uuid = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              ProjectsCompanion(
            id: id,
            uuid: uuid,
            name: name,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String uuid,
            required String name,
            required DateTime createdAt,
            required DateTime updatedAt,
          }) =>
              ProjectsCompanion.insert(
            id: id,
            uuid: uuid,
            name: name,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$ProjectsTable, Project>(table),
                    $$ProjectsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({roomsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (roomsRefs) db.rooms],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (roomsRefs)
                    await $_getPrefetchedData<Project, $ProjectsTable, Room>(
                        currentTable: table,
                        referencedTable:
                            $$ProjectsTableReferences._roomsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ProjectsTableReferences(db, table, p0).roomsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.projectId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ProjectsTableProcessedTableManager = ProcessedTableManager<
    _$ArchScanDatabase,
    $ProjectsTable,
    Project,
    $$ProjectsTableFilterComposer,
    $$ProjectsTableOrderingComposer,
    $$ProjectsTableAnnotationComposer,
    $$ProjectsTableCreateCompanionBuilder,
    $$ProjectsTableUpdateCompanionBuilder,
    (Project, $$ProjectsTableReferences),
    Project,
    PrefetchHooks Function({bool roomsRefs})>;
typedef $$RoomsTableCreateCompanionBuilder = RoomsCompanion Function({
  Value<int> id,
  required int projectId,
  required String roomId,
  required String name,
  required String type,
  Value<bool> isClosed,
});
typedef $$RoomsTableUpdateCompanionBuilder = RoomsCompanion Function({
  Value<int> id,
  Value<int> projectId,
  Value<String> roomId,
  Value<String> name,
  Value<String> type,
  Value<bool> isClosed,
});

final class $$RoomsTableReferences
    extends BaseReferences<_$ArchScanDatabase, $RoomsTable, Room> {
  $$RoomsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProjectsTable _projectIdTable(_$ArchScanDatabase db) =>
      db.projects.createAlias('rooms__project_id__projects__id');

  $$ProjectsTableProcessedTableManager get projectId {
    final $_column = $_itemColumn<int>('project_id')!;

    final manager = $$ProjectsTableTableManager($_db, $_db.projects)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_projectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$RoomPointsTable, List<RoomPoint>>
      _roomPointsRefsTable(_$ArchScanDatabase db) =>
          MultiTypedResultKey.fromTable(db.roomPoints,
              aliasName: 'rooms__id__room_points__room_id');

  $$RoomPointsTableProcessedTableManager get roomPointsRefs {
    final manager = $$RoomPointsTableTableManager($_db, $_db.roomPoints)
        .filter((f) => f.roomId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_roomPointsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$WallFeaturesTableTable,
      List<WallFeaturesTableData>> _wallFeaturesTableRefsTable(
          _$ArchScanDatabase db) =>
      MultiTypedResultKey.fromTable(db.wallFeaturesTable,
          aliasName: 'rooms__id__wall_features_table__room_id');

  $$WallFeaturesTableTableProcessedTableManager get wallFeaturesTableRefs {
    final manager =
        $$WallFeaturesTableTableTableManager($_db, $_db.wallFeaturesTable)
            .filter((f) => f.roomId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_wallFeaturesTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$RoomsTableFilterComposer
    extends Composer<_$ArchScanDatabase, $RoomsTable> {
  $$RoomsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get roomId => $composableBuilder(
      column: $table.roomId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isClosed => $composableBuilder(
      column: $table.isClosed, builder: (column) => ColumnFilters(column));

  $$ProjectsTableFilterComposer get projectId {
    final $$ProjectsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.projectId,
        referencedTable: $db.projects,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProjectsTableFilterComposer(
              $db: $db,
              $table: $db.projects,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> roomPointsRefs(
      Expression<bool> Function($$RoomPointsTableFilterComposer f) f) {
    final $$RoomPointsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.roomPoints,
        getReferencedColumn: (t) => t.roomId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RoomPointsTableFilterComposer(
              $db: $db,
              $table: $db.roomPoints,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> wallFeaturesTableRefs(
      Expression<bool> Function($$WallFeaturesTableTableFilterComposer f) f) {
    final $$WallFeaturesTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.wallFeaturesTable,
        getReferencedColumn: (t) => t.roomId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WallFeaturesTableTableFilterComposer(
              $db: $db,
              $table: $db.wallFeaturesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$RoomsTableOrderingComposer
    extends Composer<_$ArchScanDatabase, $RoomsTable> {
  $$RoomsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get roomId => $composableBuilder(
      column: $table.roomId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isClosed => $composableBuilder(
      column: $table.isClosed, builder: (column) => ColumnOrderings(column));

  $$ProjectsTableOrderingComposer get projectId {
    final $$ProjectsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.projectId,
        referencedTable: $db.projects,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProjectsTableOrderingComposer(
              $db: $db,
              $table: $db.projects,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$RoomsTableAnnotationComposer
    extends Composer<_$ArchScanDatabase, $RoomsTable> {
  $$RoomsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get roomId =>
      $composableBuilder(column: $table.roomId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<bool> get isClosed =>
      $composableBuilder(column: $table.isClosed, builder: (column) => column);

  $$ProjectsTableAnnotationComposer get projectId {
    final $$ProjectsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.projectId,
        referencedTable: $db.projects,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProjectsTableAnnotationComposer(
              $db: $db,
              $table: $db.projects,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> roomPointsRefs<T extends Object>(
      Expression<T> Function($$RoomPointsTableAnnotationComposer a) f) {
    final $$RoomPointsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.roomPoints,
        getReferencedColumn: (t) => t.roomId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RoomPointsTableAnnotationComposer(
              $db: $db,
              $table: $db.roomPoints,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> wallFeaturesTableRefs<T extends Object>(
      Expression<T> Function($$WallFeaturesTableTableAnnotationComposer a) f) {
    final $$WallFeaturesTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.wallFeaturesTable,
            getReferencedColumn: (t) => t.roomId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$WallFeaturesTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.wallFeaturesTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$RoomsTableTableManager extends RootTableManager<
    _$ArchScanDatabase,
    $RoomsTable,
    Room,
    $$RoomsTableFilterComposer,
    $$RoomsTableOrderingComposer,
    $$RoomsTableAnnotationComposer,
    $$RoomsTableCreateCompanionBuilder,
    $$RoomsTableUpdateCompanionBuilder,
    (Room, $$RoomsTableReferences),
    Room,
    PrefetchHooks Function(
        {bool projectId, bool roomPointsRefs, bool wallFeaturesTableRefs})> {
  $$RoomsTableTableManager(_$ArchScanDatabase db, $RoomsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RoomsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RoomsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RoomsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> projectId = const Value.absent(),
            Value<String> roomId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<bool> isClosed = const Value.absent(),
          }) =>
              RoomsCompanion(
            id: id,
            projectId: projectId,
            roomId: roomId,
            name: name,
            type: type,
            isClosed: isClosed,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int projectId,
            required String roomId,
            required String name,
            required String type,
            Value<bool> isClosed = const Value.absent(),
          }) =>
              RoomsCompanion.insert(
            id: id,
            projectId: projectId,
            roomId: roomId,
            name: name,
            type: type,
            isClosed: isClosed,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$RoomsTable, Room>(table),
                    $$RoomsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {projectId = false,
              roomPointsRefs = false,
              wallFeaturesTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (roomPointsRefs) db.roomPoints,
                if (wallFeaturesTableRefs) db.wallFeaturesTable
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (projectId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.projectId,
                    referencedTable: $$RoomsTableReferences._projectIdTable(db),
                    referencedColumn:
                        $$RoomsTableReferences._projectIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (roomPointsRefs)
                    await $_getPrefetchedData<Room, $RoomsTable, RoomPoint>(
                        currentTable: table,
                        referencedTable:
                            $$RoomsTableReferences._roomPointsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$RoomsTableReferences(db, table, p0)
                                .roomPointsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.roomId == item.id),
                        typedResults: items),
                  if (wallFeaturesTableRefs)
                    await $_getPrefetchedData<Room, $RoomsTable,
                            WallFeaturesTableData>(
                        currentTable: table,
                        referencedTable: $$RoomsTableReferences
                            ._wallFeaturesTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$RoomsTableReferences(db, table, p0)
                                .wallFeaturesTableRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.roomId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$RoomsTableProcessedTableManager = ProcessedTableManager<
    _$ArchScanDatabase,
    $RoomsTable,
    Room,
    $$RoomsTableFilterComposer,
    $$RoomsTableOrderingComposer,
    $$RoomsTableAnnotationComposer,
    $$RoomsTableCreateCompanionBuilder,
    $$RoomsTableUpdateCompanionBuilder,
    (Room, $$RoomsTableReferences),
    Room,
    PrefetchHooks Function(
        {bool projectId, bool roomPointsRefs, bool wallFeaturesTableRefs})>;
typedef $$RoomPointsTableCreateCompanionBuilder = RoomPointsCompanion Function({
  Value<int> id,
  required int roomId,
  required double x,
  required double y,
  required double z,
});
typedef $$RoomPointsTableUpdateCompanionBuilder = RoomPointsCompanion Function({
  Value<int> id,
  Value<int> roomId,
  Value<double> x,
  Value<double> y,
  Value<double> z,
});

final class $$RoomPointsTableReferences
    extends BaseReferences<_$ArchScanDatabase, $RoomPointsTable, RoomPoint> {
  $$RoomPointsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $RoomsTable _roomIdTable(_$ArchScanDatabase db) =>
      db.rooms.createAlias('room_points__room_id__rooms__id');

  $$RoomsTableProcessedTableManager get roomId {
    final $_column = $_itemColumn<int>('room_id')!;

    final manager = $$RoomsTableTableManager($_db, $_db.rooms)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_roomIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$RoomPointsTableFilterComposer
    extends Composer<_$ArchScanDatabase, $RoomPointsTable> {
  $$RoomPointsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get x => $composableBuilder(
      column: $table.x, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get y => $composableBuilder(
      column: $table.y, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get z => $composableBuilder(
      column: $table.z, builder: (column) => ColumnFilters(column));

  $$RoomsTableFilterComposer get roomId {
    final $$RoomsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.roomId,
        referencedTable: $db.rooms,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RoomsTableFilterComposer(
              $db: $db,
              $table: $db.rooms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$RoomPointsTableOrderingComposer
    extends Composer<_$ArchScanDatabase, $RoomPointsTable> {
  $$RoomPointsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get x => $composableBuilder(
      column: $table.x, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get y => $composableBuilder(
      column: $table.y, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get z => $composableBuilder(
      column: $table.z, builder: (column) => ColumnOrderings(column));

  $$RoomsTableOrderingComposer get roomId {
    final $$RoomsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.roomId,
        referencedTable: $db.rooms,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RoomsTableOrderingComposer(
              $db: $db,
              $table: $db.rooms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$RoomPointsTableAnnotationComposer
    extends Composer<_$ArchScanDatabase, $RoomPointsTable> {
  $$RoomPointsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get x =>
      $composableBuilder(column: $table.x, builder: (column) => column);

  GeneratedColumn<double> get y =>
      $composableBuilder(column: $table.y, builder: (column) => column);

  GeneratedColumn<double> get z =>
      $composableBuilder(column: $table.z, builder: (column) => column);

  $$RoomsTableAnnotationComposer get roomId {
    final $$RoomsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.roomId,
        referencedTable: $db.rooms,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RoomsTableAnnotationComposer(
              $db: $db,
              $table: $db.rooms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$RoomPointsTableTableManager extends RootTableManager<
    _$ArchScanDatabase,
    $RoomPointsTable,
    RoomPoint,
    $$RoomPointsTableFilterComposer,
    $$RoomPointsTableOrderingComposer,
    $$RoomPointsTableAnnotationComposer,
    $$RoomPointsTableCreateCompanionBuilder,
    $$RoomPointsTableUpdateCompanionBuilder,
    (RoomPoint, $$RoomPointsTableReferences),
    RoomPoint,
    PrefetchHooks Function({bool roomId})> {
  $$RoomPointsTableTableManager(_$ArchScanDatabase db, $RoomPointsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RoomPointsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RoomPointsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RoomPointsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> roomId = const Value.absent(),
            Value<double> x = const Value.absent(),
            Value<double> y = const Value.absent(),
            Value<double> z = const Value.absent(),
          }) =>
              RoomPointsCompanion(
            id: id,
            roomId: roomId,
            x: x,
            y: y,
            z: z,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int roomId,
            required double x,
            required double y,
            required double z,
          }) =>
              RoomPointsCompanion.insert(
            id: id,
            roomId: roomId,
            x: x,
            y: y,
            z: z,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$RoomPointsTable, RoomPoint>(table),
                    $$RoomPointsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({roomId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (roomId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.roomId,
                    referencedTable:
                        $$RoomPointsTableReferences._roomIdTable(db),
                    referencedColumn:
                        $$RoomPointsTableReferences._roomIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$RoomPointsTableProcessedTableManager = ProcessedTableManager<
    _$ArchScanDatabase,
    $RoomPointsTable,
    RoomPoint,
    $$RoomPointsTableFilterComposer,
    $$RoomPointsTableOrderingComposer,
    $$RoomPointsTableAnnotationComposer,
    $$RoomPointsTableCreateCompanionBuilder,
    $$RoomPointsTableUpdateCompanionBuilder,
    (RoomPoint, $$RoomPointsTableReferences),
    RoomPoint,
    PrefetchHooks Function({bool roomId})>;
typedef $$WallFeaturesTableTableCreateCompanionBuilder
    = WallFeaturesTableCompanion Function({
  Value<int> id,
  required int roomId,
  required String featureId,
  required String type,
  Value<String?> connectedRoomId,
  Value<String?> connectionSide,
  required double startX,
  required double startY,
  required double startZ,
  required double endX,
  required double endY,
  required double endZ,
  Value<String> hingeSide,
  Value<String> swingSide,
  Value<String> openingDirection,
  Value<double?> openingHeight,
  Value<double?> sillHeight,
});
typedef $$WallFeaturesTableTableUpdateCompanionBuilder
    = WallFeaturesTableCompanion Function({
  Value<int> id,
  Value<int> roomId,
  Value<String> featureId,
  Value<String> type,
  Value<String?> connectedRoomId,
  Value<String?> connectionSide,
  Value<double> startX,
  Value<double> startY,
  Value<double> startZ,
  Value<double> endX,
  Value<double> endY,
  Value<double> endZ,
  Value<String> hingeSide,
  Value<String> swingSide,
  Value<String> openingDirection,
  Value<double?> openingHeight,
  Value<double?> sillHeight,
});

final class $$WallFeaturesTableTableReferences extends BaseReferences<
    _$ArchScanDatabase, $WallFeaturesTableTable, WallFeaturesTableData> {
  $$WallFeaturesTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $RoomsTable _roomIdTable(_$ArchScanDatabase db) =>
      db.rooms.createAlias('wall_features_table__room_id__rooms__id');

  $$RoomsTableProcessedTableManager get roomId {
    final $_column = $_itemColumn<int>('room_id')!;

    final manager = $$RoomsTableTableManager($_db, $_db.rooms)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_roomIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$WallFeaturesTableTableFilterComposer
    extends Composer<_$ArchScanDatabase, $WallFeaturesTableTable> {
  $$WallFeaturesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get featureId => $composableBuilder(
      column: $table.featureId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get connectedRoomId => $composableBuilder(
      column: $table.connectedRoomId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get connectionSide => $composableBuilder(
      column: $table.connectionSide,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get startX => $composableBuilder(
      column: $table.startX, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get startY => $composableBuilder(
      column: $table.startY, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get startZ => $composableBuilder(
      column: $table.startZ, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get endX => $composableBuilder(
      column: $table.endX, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get endY => $composableBuilder(
      column: $table.endY, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get endZ => $composableBuilder(
      column: $table.endZ, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get hingeSide => $composableBuilder(
      column: $table.hingeSide, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get swingSide => $composableBuilder(
      column: $table.swingSide, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get openingDirection => $composableBuilder(
      column: $table.openingDirection,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get openingHeight => $composableBuilder(
      column: $table.openingHeight, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get sillHeight => $composableBuilder(
      column: $table.sillHeight, builder: (column) => ColumnFilters(column));

  $$RoomsTableFilterComposer get roomId {
    final $$RoomsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.roomId,
        referencedTable: $db.rooms,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RoomsTableFilterComposer(
              $db: $db,
              $table: $db.rooms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$WallFeaturesTableTableOrderingComposer
    extends Composer<_$ArchScanDatabase, $WallFeaturesTableTable> {
  $$WallFeaturesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get featureId => $composableBuilder(
      column: $table.featureId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get connectedRoomId => $composableBuilder(
      column: $table.connectedRoomId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get connectionSide => $composableBuilder(
      column: $table.connectionSide,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get startX => $composableBuilder(
      column: $table.startX, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get startY => $composableBuilder(
      column: $table.startY, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get startZ => $composableBuilder(
      column: $table.startZ, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get endX => $composableBuilder(
      column: $table.endX, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get endY => $composableBuilder(
      column: $table.endY, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get endZ => $composableBuilder(
      column: $table.endZ, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get hingeSide => $composableBuilder(
      column: $table.hingeSide, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get swingSide => $composableBuilder(
      column: $table.swingSide, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get openingDirection => $composableBuilder(
      column: $table.openingDirection,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get openingHeight => $composableBuilder(
      column: $table.openingHeight,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get sillHeight => $composableBuilder(
      column: $table.sillHeight, builder: (column) => ColumnOrderings(column));

  $$RoomsTableOrderingComposer get roomId {
    final $$RoomsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.roomId,
        referencedTable: $db.rooms,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RoomsTableOrderingComposer(
              $db: $db,
              $table: $db.rooms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$WallFeaturesTableTableAnnotationComposer
    extends Composer<_$ArchScanDatabase, $WallFeaturesTableTable> {
  $$WallFeaturesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get featureId =>
      $composableBuilder(column: $table.featureId, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get connectedRoomId => $composableBuilder(
      column: $table.connectedRoomId, builder: (column) => column);

  GeneratedColumn<String> get connectionSide => $composableBuilder(
      column: $table.connectionSide, builder: (column) => column);

  GeneratedColumn<double> get startX =>
      $composableBuilder(column: $table.startX, builder: (column) => column);

  GeneratedColumn<double> get startY =>
      $composableBuilder(column: $table.startY, builder: (column) => column);

  GeneratedColumn<double> get startZ =>
      $composableBuilder(column: $table.startZ, builder: (column) => column);

  GeneratedColumn<double> get endX =>
      $composableBuilder(column: $table.endX, builder: (column) => column);

  GeneratedColumn<double> get endY =>
      $composableBuilder(column: $table.endY, builder: (column) => column);

  GeneratedColumn<double> get endZ =>
      $composableBuilder(column: $table.endZ, builder: (column) => column);

  GeneratedColumn<String> get hingeSide =>
      $composableBuilder(column: $table.hingeSide, builder: (column) => column);

  GeneratedColumn<String> get swingSide =>
      $composableBuilder(column: $table.swingSide, builder: (column) => column);

  GeneratedColumn<String> get openingDirection => $composableBuilder(
      column: $table.openingDirection, builder: (column) => column);

  GeneratedColumn<double> get openingHeight => $composableBuilder(
      column: $table.openingHeight, builder: (column) => column);

  GeneratedColumn<double> get sillHeight => $composableBuilder(
      column: $table.sillHeight, builder: (column) => column);

  $$RoomsTableAnnotationComposer get roomId {
    final $$RoomsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.roomId,
        referencedTable: $db.rooms,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RoomsTableAnnotationComposer(
              $db: $db,
              $table: $db.rooms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$WallFeaturesTableTableTableManager extends RootTableManager<
    _$ArchScanDatabase,
    $WallFeaturesTableTable,
    WallFeaturesTableData,
    $$WallFeaturesTableTableFilterComposer,
    $$WallFeaturesTableTableOrderingComposer,
    $$WallFeaturesTableTableAnnotationComposer,
    $$WallFeaturesTableTableCreateCompanionBuilder,
    $$WallFeaturesTableTableUpdateCompanionBuilder,
    (WallFeaturesTableData, $$WallFeaturesTableTableReferences),
    WallFeaturesTableData,
    PrefetchHooks Function({bool roomId})> {
  $$WallFeaturesTableTableTableManager(
      _$ArchScanDatabase db, $WallFeaturesTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WallFeaturesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WallFeaturesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WallFeaturesTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> roomId = const Value.absent(),
            Value<String> featureId = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<String?> connectedRoomId = const Value.absent(),
            Value<String?> connectionSide = const Value.absent(),
            Value<double> startX = const Value.absent(),
            Value<double> startY = const Value.absent(),
            Value<double> startZ = const Value.absent(),
            Value<double> endX = const Value.absent(),
            Value<double> endY = const Value.absent(),
            Value<double> endZ = const Value.absent(),
            Value<String> hingeSide = const Value.absent(),
            Value<String> swingSide = const Value.absent(),
            Value<String> openingDirection = const Value.absent(),
            Value<double?> openingHeight = const Value.absent(),
            Value<double?> sillHeight = const Value.absent(),
          }) =>
              WallFeaturesTableCompanion(
            id: id,
            roomId: roomId,
            featureId: featureId,
            type: type,
            connectedRoomId: connectedRoomId,
            connectionSide: connectionSide,
            startX: startX,
            startY: startY,
            startZ: startZ,
            endX: endX,
            endY: endY,
            endZ: endZ,
            hingeSide: hingeSide,
            swingSide: swingSide,
            openingDirection: openingDirection,
            openingHeight: openingHeight,
            sillHeight: sillHeight,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int roomId,
            required String featureId,
            required String type,
            Value<String?> connectedRoomId = const Value.absent(),
            Value<String?> connectionSide = const Value.absent(),
            required double startX,
            required double startY,
            required double startZ,
            required double endX,
            required double endY,
            required double endZ,
            Value<String> hingeSide = const Value.absent(),
            Value<String> swingSide = const Value.absent(),
            Value<String> openingDirection = const Value.absent(),
            Value<double?> openingHeight = const Value.absent(),
            Value<double?> sillHeight = const Value.absent(),
          }) =>
              WallFeaturesTableCompanion.insert(
            id: id,
            roomId: roomId,
            featureId: featureId,
            type: type,
            connectedRoomId: connectedRoomId,
            connectionSide: connectionSide,
            startX: startX,
            startY: startY,
            startZ: startZ,
            endX: endX,
            endY: endY,
            endZ: endZ,
            hingeSide: hingeSide,
            swingSide: swingSide,
            openingDirection: openingDirection,
            openingHeight: openingHeight,
            sillHeight: sillHeight,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$WallFeaturesTableTable, WallFeaturesTableData>(
                        table),
                    $$WallFeaturesTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({roomId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (roomId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.roomId,
                    referencedTable:
                        $$WallFeaturesTableTableReferences._roomIdTable(db),
                    referencedColumn:
                        $$WallFeaturesTableTableReferences._roomIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$WallFeaturesTableTableProcessedTableManager = ProcessedTableManager<
    _$ArchScanDatabase,
    $WallFeaturesTableTable,
    WallFeaturesTableData,
    $$WallFeaturesTableTableFilterComposer,
    $$WallFeaturesTableTableOrderingComposer,
    $$WallFeaturesTableTableAnnotationComposer,
    $$WallFeaturesTableTableCreateCompanionBuilder,
    $$WallFeaturesTableTableUpdateCompanionBuilder,
    (WallFeaturesTableData, $$WallFeaturesTableTableReferences),
    WallFeaturesTableData,
    PrefetchHooks Function({bool roomId})>;

class $ArchScanDatabaseManager {
  final _$ArchScanDatabase _db;
  $ArchScanDatabaseManager(this._db);
  $$ProjectsTableTableManager get projects =>
      $$ProjectsTableTableManager(_db, _db.projects);
  $$RoomsTableTableManager get rooms =>
      $$RoomsTableTableManager(_db, _db.rooms);
  $$RoomPointsTableTableManager get roomPoints =>
      $$RoomPointsTableTableManager(_db, _db.roomPoints);
  $$WallFeaturesTableTableTableManager get wallFeaturesTable =>
      $$WallFeaturesTableTableTableManager(_db, _db.wallFeaturesTable);
}
