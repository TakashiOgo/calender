// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_service.dart';

// ignore_for_file: type=lint
class ScheduleEntity extends DataClass implements Insertable<ScheduleEntity> {
  final int? id;
  final String title;
  final bool fullTime;
  final DateTime? startTime;
  final DateTime? finishedTime;
  final String? comment;
  const ScheduleEntity(
      {this.id,
      required this.title,
      required this.fullTime,
      this.startTime,
      this.finishedTime,
      this.comment});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    map['title'] = Variable<String>(title);
    map['full_time'] = Variable<bool>(fullTime);
    if (!nullToAbsent || startTime != null) {
      map['start_time'] = Variable<DateTime>(startTime);
    }
    if (!nullToAbsent || finishedTime != null) {
      map['finished_time'] = Variable<DateTime>(finishedTime);
    }
    if (!nullToAbsent || comment != null) {
      map['comment'] = Variable<String>(comment);
    }
    return map;
  }

  ScheduleEntitiesCompanion toCompanion(bool nullToAbsent) {
    return ScheduleEntitiesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      title: Value(title),
      fullTime: Value(fullTime),
      startTime: startTime == null && nullToAbsent
          ? const Value.absent()
          : Value(startTime),
      finishedTime: finishedTime == null && nullToAbsent
          ? const Value.absent()
          : Value(finishedTime),
      comment: comment == null && nullToAbsent
          ? const Value.absent()
          : Value(comment),
    );
  }

  factory ScheduleEntity.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ScheduleEntity(
      id: serializer.fromJson<int?>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      fullTime: serializer.fromJson<bool>(json['fullTime']),
      startTime: serializer.fromJson<DateTime?>(json['startTime']),
      finishedTime: serializer.fromJson<DateTime?>(json['finishedTime']),
      comment: serializer.fromJson<String?>(json['comment']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'title': serializer.toJson<String>(title),
      'fullTime': serializer.toJson<bool>(fullTime),
      'startTime': serializer.toJson<DateTime?>(startTime),
      'finishedTime': serializer.toJson<DateTime?>(finishedTime),
      'comment': serializer.toJson<String?>(comment),
    };
  }

  ScheduleEntity copyWith(
          {Value<int?> id = const Value.absent(),
          String? title,
          bool? fullTime,
          Value<DateTime?> startTime = const Value.absent(),
          Value<DateTime?> finishedTime = const Value.absent(),
          Value<String?> comment = const Value.absent()}) =>
      ScheduleEntity(
        id: id.present ? id.value : this.id,
        title: title ?? this.title,
        fullTime: fullTime ?? this.fullTime,
        startTime: startTime.present ? startTime.value : this.startTime,
        finishedTime:
            finishedTime.present ? finishedTime.value : this.finishedTime,
        comment: comment.present ? comment.value : this.comment,
      );
  @override
  String toString() {
    return (StringBuffer('ScheduleEntity(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('fullTime: $fullTime, ')
          ..write('startTime: $startTime, ')
          ..write('finishedTime: $finishedTime, ')
          ..write('comment: $comment')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, fullTime, startTime, finishedTime, comment);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ScheduleEntity &&
          other.id == this.id &&
          other.title == this.title &&
          other.fullTime == this.fullTime &&
          other.startTime == this.startTime &&
          other.finishedTime == this.finishedTime &&
          other.comment == this.comment);
}

class ScheduleEntitiesCompanion extends UpdateCompanion<ScheduleEntity> {
  final Value<int?> id;
  final Value<String> title;
  final Value<bool> fullTime;
  final Value<DateTime?> startTime;
  final Value<DateTime?> finishedTime;
  final Value<String?> comment;
  const ScheduleEntitiesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.fullTime = const Value.absent(),
    this.startTime = const Value.absent(),
    this.finishedTime = const Value.absent(),
    this.comment = const Value.absent(),
  });
  ScheduleEntitiesCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.fullTime = const Value.absent(),
    this.startTime = const Value.absent(),
    this.finishedTime = const Value.absent(),
    this.comment = const Value.absent(),
  }) : title = Value(title);
  static Insertable<ScheduleEntity> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<bool>? fullTime,
    Expression<DateTime>? startTime,
    Expression<DateTime>? finishedTime,
    Expression<String>? comment,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (fullTime != null) 'full_time': fullTime,
      if (startTime != null) 'start_time': startTime,
      if (finishedTime != null) 'finished_time': finishedTime,
      if (comment != null) 'comment': comment,
    });
  }

  ScheduleEntitiesCompanion copyWith(
      {Value<int?>? id,
      Value<String>? title,
      Value<bool>? fullTime,
      Value<DateTime?>? startTime,
      Value<DateTime?>? finishedTime,
      Value<String?>? comment}) {
    return ScheduleEntitiesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      fullTime: fullTime ?? this.fullTime,
      startTime: startTime ?? this.startTime,
      finishedTime: finishedTime ?? this.finishedTime,
      comment: comment ?? this.comment,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (fullTime.present) {
      map['full_time'] = Variable<bool>(fullTime.value);
    }
    if (startTime.present) {
      map['start_time'] = Variable<DateTime>(startTime.value);
    }
    if (finishedTime.present) {
      map['finished_time'] = Variable<DateTime>(finishedTime.value);
    }
    if (comment.present) {
      map['comment'] = Variable<String>(comment.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ScheduleEntitiesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('fullTime: $fullTime, ')
          ..write('startTime: $startTime, ')
          ..write('finishedTime: $finishedTime, ')
          ..write('comment: $comment')
          ..write(')'))
        .toString();
  }
}

class $ScheduleEntitiesTable extends ScheduleEntities
    with TableInfo<$ScheduleEntitiesTable, ScheduleEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ScheduleEntitiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, true,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _fullTimeMeta =
      const VerificationMeta('fullTime');
  @override
  late final GeneratedColumn<bool> fullTime =
      GeneratedColumn<bool>('full_time', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("full_time" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }),
          defaultValue: const Constant(false));
  static const VerificationMeta _startTimeMeta =
      const VerificationMeta('startTime');
  @override
  late final GeneratedColumn<DateTime> startTime = GeneratedColumn<DateTime>(
      'start_time', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _finishedTimeMeta =
      const VerificationMeta('finishedTime');
  @override
  late final GeneratedColumn<DateTime> finishedTime = GeneratedColumn<DateTime>(
      'finished_time', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _commentMeta =
      const VerificationMeta('comment');
  @override
  late final GeneratedColumn<String> comment = GeneratedColumn<String>(
      'comment', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, fullTime, startTime, finishedTime, comment];
  @override
  String get aliasedName => _alias ?? 'schedule_entities';
  @override
  String get actualTableName => 'schedule_entities';
  @override
  VerificationContext validateIntegrity(Insertable<ScheduleEntity> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('full_time')) {
      context.handle(_fullTimeMeta,
          fullTime.isAcceptableOrUnknown(data['full_time']!, _fullTimeMeta));
    }
    if (data.containsKey('start_time')) {
      context.handle(_startTimeMeta,
          startTime.isAcceptableOrUnknown(data['start_time']!, _startTimeMeta));
    }
    if (data.containsKey('finished_time')) {
      context.handle(
          _finishedTimeMeta,
          finishedTime.isAcceptableOrUnknown(
              data['finished_time']!, _finishedTimeMeta));
    }
    if (data.containsKey('comment')) {
      context.handle(_commentMeta,
          comment.isAcceptableOrUnknown(data['comment']!, _commentMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ScheduleEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ScheduleEntity(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id']),
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      fullTime: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}full_time'])!,
      startTime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}start_time']),
      finishedTime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}finished_time']),
      comment: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}comment']),
    );
  }

  @override
  $ScheduleEntitiesTable createAlias(String alias) {
    return $ScheduleEntitiesTable(attachedDatabase, alias);
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(e);
  late final $ScheduleEntitiesTable scheduleEntities =
      $ScheduleEntitiesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [scheduleEntities];
}
