import 'package:realm/realm.dart';
import 'package:schedify/models/shift.dart';
import 'package:schedify/utils/database.dart';
import 'package:schedify/utils/shared_preferences_helper.dart';

class ShiftManager {
  Shift? currentShift;

  ShiftManager._() {
    getCurrentShift().then((shift) {
      currentShift = shift;
    });
  }

  static final ShiftManager instance = ShiftManager._();

  static const String _kCurrentWorkDayId = 'currentWorkDayId';

  Future<void> startShift() async {
    Shift? currentShift = await getCurrentShift();
    if (currentShift != null) {
      return;
    }
    Shift shift = Shift(ObjectId());
    shift.start();
    setCurrentShift(shift);
  }

  Future<Shift?> getCurrentShift() async {
    String? currentWorkDayId =
        await SharedPreferencesHelper.getString(_kCurrentWorkDayId);

    if (currentWorkDayId == null) {
      return null;
    }

    Shift? shift = Database.instance.find<Shift>(currentWorkDayId);
    return shift;
  }

  setCurrentShift(Shift shift) async {
    Shift? currentShift = await getCurrentShift();

    if (currentShift != null) {
      return;
    }

    await SharedPreferencesHelper.setString(
        _kCurrentWorkDayId, shift.id.toString());
  }

  startBreak() {
    currentShift?.startBreak();
  }
}
