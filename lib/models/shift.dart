import "package:realm/realm.dart";
import "package:schedify/utils/database.dart";

part 'shift.realm.dart';

@RealmModel()
class _Shift {
  @PrimaryKey()
  late ObjectId id;

  late DateTime? startDate;
  late DateTime? endDate;

  late List<_Break> breaks;

  late _Break? currentBreak;

  void start() {
    Database.realm?.write(() {
      breaks = [];
      currentBreak = null;
      startDate ??= DateTime.now();
    });
  }

  void end() {
    Database.realm?.write(() {
      endDate ??= DateTime.now();
      currentBreak?.end();
    });
  }

  void startBreak() {
    Database.realm?.write(() {
      currentBreak = Break(ObjectId());
      currentBreak!.start();
      breaks.add(currentBreak!);
    });
  }

  void endBreak() {
    Database.realm?.write(() {
      currentBreak?.end();
      currentBreak = null;
    });
  }
}

@RealmModel()
class _Break {
  @PrimaryKey()
  late ObjectId id;

  late DateTime? startDate;
  late DateTime? endDate;

  void start() {
    Database.realm?.write(() {
      startDate ??= DateTime.now();
    });
  }

  void end() {
    Database.realm?.write(() {
      endDate ??= DateTime.now();
    });
  }
}
