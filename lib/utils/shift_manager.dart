import 'dart:async';

import 'package:realm/realm.dart';
import 'package:schedify/models/shift.dart';
import 'package:schedify/utils/database.dart';
import 'package:schedify/utils/shared_preferences_helper.dart';

class ShiftActionResponse {
  final bool success;
  final String? message;
  ShiftActionResponse(this.success, this.message);
}

class ShiftManager {
  // StreamControllers for shift start and end events
  final _onShiftStartedController = StreamController<Shift>.broadcast();
  final _onShiftEndedController = StreamController<Shift>.broadcast();
  final _onBreakStartedController = StreamController<Shift>.broadcast();
  final _onBreakEndedController = StreamController<Shift>.broadcast();

  // Public streams for other classes to listen to
  Stream<Shift> get onShiftStarted => _onShiftStartedController.stream;
  Stream<Shift> get onShiftEnded => _onShiftEndedController.stream;
  Stream<Shift> get onBreakStarted => _onBreakStartedController.stream;
  Stream<Shift> get onBreakEnded => _onBreakEndedController.stream;

  ShiftManager._();

  static final ShiftManager instance = ShiftManager._();

  static const String _kCurrentWorkDayId = 'currentWorkDayId';

  Future<ShiftActionResponse> startShift({bool? force}) async {
    if (force == true) {
      await SharedPreferencesHelper.remove(_kCurrentWorkDayId);
      Database.instance.write(() {
        Database.instance.deleteAll<Shift>();
      });
    } else {
      Shift? currentShift = await getCurrentShift();
      if (currentShift != null) {
        return ShiftActionResponse(false, 'Shift already started');
      }
    }

    Shift shift = Shift(ObjectId());
    shift = Database.instance.write<Shift>(() {
      return Database.instance.add<Shift>(shift);
    });
    shift.start();
    var response = await _setCurrentShift(shift);
    if (response.success) {
      _onShiftStartedController.add(shift);
      return response;
    }
    return ShiftActionResponse(false, response.message);
  }

  Future<ShiftActionResponse> endShift() async {
    Shift? currentShift = await getCurrentShift();
    if (currentShift == null) {
      return ShiftActionResponse(false, 'No current shift found');
    }
    currentShift.end();
    _onShiftEndedController.add(currentShift);
    await SharedPreferencesHelper.remove(_kCurrentWorkDayId);
    return ShiftActionResponse(true, null);
  }

  Future<ShiftActionResponse> deleteAllShifts() async {
    Database.instance.write(() {
      Database.instance.deleteAll<Shift>();
    });
    await SharedPreferencesHelper.remove(_kCurrentWorkDayId);
    return ShiftActionResponse(true, null);
  }

  Future<Shift?> getCurrentShift() async {
    String? currentWorkDayId =
        await SharedPreferencesHelper.getString(_kCurrentWorkDayId);

    if (currentWorkDayId == null) {
      return null;
    }

    Shift? shift =
        Database.instance.find<Shift>(ObjectId.fromHexString(currentWorkDayId));
    return shift;
  }

  Future<ShiftActionResponse> _setCurrentShift(Shift shift) async {
    Shift? currentShift = await getCurrentShift();

    if (currentShift != null) {
      return ShiftActionResponse(false, 'Shift already started');
    }

    await SharedPreferencesHelper.setString(
        _kCurrentWorkDayId, shift.id.toString());
    return ShiftActionResponse(true, null);
  }

  Future<ShiftActionResponse> startBreak() async {
    Shift? currentShift = await getCurrentShift();
    if (currentShift == null) {
      return ShiftActionResponse(false, 'No shift found');
    }

    try {
      currentShift.startBreak();
      _onBreakStartedController.add(currentShift);
      return ShiftActionResponse(true, null);
    } catch (e) {
      return ShiftActionResponse(
          false, 'Failed to start break: ${e.toString()}');
    }
  }

  Future<ShiftActionResponse> endBreak() async {
    Shift? currentShift = await getCurrentShift();
    if (currentShift == null) {
      return ShiftActionResponse(false, 'No shift found');
    }

    if (currentShift.currentBreak == null) {
      return ShiftActionResponse(false, 'No break in progress');
    }

    try {
      currentShift.endBreak();
      _onBreakEndedController.add(currentShift);
      return ShiftActionResponse(true, null);
    } catch (e) {
      return ShiftActionResponse(false, 'Failed to end break: ${e.toString()}');
    }
  }
}
