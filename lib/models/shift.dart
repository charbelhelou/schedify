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

  Duration get duration {
    var duration = Duration.zero;
    if (endDate == null) {
      duration = DateTime.now().difference(startDate!);
    } else {
      duration = endDate!.difference(startDate!);
    }

    return duration;
  }

  void start() {
    Database.instance.write(() {
      currentBreak = null;
      startDate ??= DateTime.now();
    });
  }

  void end() {
    Database.instance.write(() {
      currentBreak?.end();
      endDate ??= DateTime.now();
    });
  }

  void startBreak() {
    Database.instance.write(() {
      currentBreak = Break(ObjectId());
      currentBreak!.start();
      breaks.add(currentBreak!);
    });
  }

  void endBreak() {
    Database.instance.write(() {
      currentBreak?.end();
      currentBreak = null;
    });
  }

  @override
  String toString() =>
      "Shift { id: $id, startDate: $startDate, endDate: $endDate\nBreaks: [${breaks.map((br) => br.toString())}]\nCurrentBreak: $currentBreak }";
}

@RealmModel()
class _Break {
  @PrimaryKey()
  late ObjectId id;

  late DateTime? startDate;
  late DateTime? endDate;

  void start() {
    startDate ??= DateTime.now();
  }

  void end() {
    endDate ??= DateTime.now();
  }

  @override
  String toString() =>
      'Break { id: $id, startDate: $startDate, endDate: $endDate }';
}
