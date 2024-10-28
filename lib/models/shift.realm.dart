// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shift.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Shift extends _Shift with RealmEntity, RealmObjectBase, RealmObject {
  Shift(
    ObjectId id, {
    DateTime? startDate,
    DateTime? endDate,
    Iterable<Break> breaks = const [],
    Break? currentBreak,
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'startDate', startDate);
    RealmObjectBase.set(this, 'endDate', endDate);
    RealmObjectBase.set<RealmList<Break>>(
        this, 'breaks', RealmList<Break>(breaks));
    RealmObjectBase.set(this, 'currentBreak', currentBreak);
  }

  Shift._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, 'id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, 'id', value);

  @override
  DateTime? get startDate =>
      RealmObjectBase.get<DateTime>(this, 'startDate') as DateTime?;
  @override
  set startDate(DateTime? value) =>
      RealmObjectBase.set(this, 'startDate', value);

  @override
  DateTime? get endDate =>
      RealmObjectBase.get<DateTime>(this, 'endDate') as DateTime?;
  @override
  set endDate(DateTime? value) => RealmObjectBase.set(this, 'endDate', value);

  @override
  RealmList<Break> get breaks =>
      RealmObjectBase.get<Break>(this, 'breaks') as RealmList<Break>;
  @override
  set breaks(covariant RealmList<Break> value) =>
      throw RealmUnsupportedSetError();

  @override
  Break? get currentBreak =>
      RealmObjectBase.get<Break>(this, 'currentBreak') as Break?;
  @override
  set currentBreak(covariant Break? value) =>
      RealmObjectBase.set(this, 'currentBreak', value);

  @override
  Stream<RealmObjectChanges<Shift>> get changes =>
      RealmObjectBase.getChanges<Shift>(this);

  @override
  Stream<RealmObjectChanges<Shift>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<Shift>(this, keyPaths);

  @override
  Shift freeze() => RealmObjectBase.freezeObject<Shift>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'startDate': startDate.toEJson(),
      'endDate': endDate.toEJson(),
      'breaks': breaks.toEJson(),
      'currentBreak': currentBreak.toEJson(),
    };
  }

  static EJsonValue _toEJson(Shift value) => value.toEJson();
  static Shift _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'id': EJsonValue id,
      } =>
        Shift(
          fromEJson(id),
          startDate: fromEJson(ejson['startDate']),
          endDate: fromEJson(ejson['endDate']),
          breaks: fromEJson(ejson['breaks']),
          currentBreak: fromEJson(ejson['currentBreak']),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(Shift._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(ObjectType.realmObject, Shift, 'Shift', [
      SchemaProperty('id', RealmPropertyType.objectid, primaryKey: true),
      SchemaProperty('startDate', RealmPropertyType.timestamp, optional: true),
      SchemaProperty('endDate', RealmPropertyType.timestamp, optional: true),
      SchemaProperty('breaks', RealmPropertyType.object,
          linkTarget: 'Break', collectionType: RealmCollectionType.list),
      SchemaProperty('currentBreak', RealmPropertyType.object,
          optional: true, linkTarget: 'Break'),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class Break extends _Break with RealmEntity, RealmObjectBase, RealmObject {
  Break(
    ObjectId id, {
    DateTime? startDate,
    DateTime? endDate,
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'startDate', startDate);
    RealmObjectBase.set(this, 'endDate', endDate);
  }

  Break._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, 'id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, 'id', value);

  @override
  DateTime? get startDate =>
      RealmObjectBase.get<DateTime>(this, 'startDate') as DateTime?;
  @override
  set startDate(DateTime? value) =>
      RealmObjectBase.set(this, 'startDate', value);

  @override
  DateTime? get endDate =>
      RealmObjectBase.get<DateTime>(this, 'endDate') as DateTime?;
  @override
  set endDate(DateTime? value) => RealmObjectBase.set(this, 'endDate', value);

  @override
  Stream<RealmObjectChanges<Break>> get changes =>
      RealmObjectBase.getChanges<Break>(this);

  @override
  Stream<RealmObjectChanges<Break>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<Break>(this, keyPaths);

  @override
  Break freeze() => RealmObjectBase.freezeObject<Break>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'startDate': startDate.toEJson(),
      'endDate': endDate.toEJson(),
    };
  }

  static EJsonValue _toEJson(Break value) => value.toEJson();
  static Break _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'id': EJsonValue id,
      } =>
        Break(
          fromEJson(id),
          startDate: fromEJson(ejson['startDate']),
          endDate: fromEJson(ejson['endDate']),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(Break._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(ObjectType.realmObject, Break, 'Break', [
      SchemaProperty('id', RealmPropertyType.objectid, primaryKey: true),
      SchemaProperty('startDate', RealmPropertyType.timestamp, optional: true),
      SchemaProperty('endDate', RealmPropertyType.timestamp, optional: true),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
