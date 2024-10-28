import 'dart:async';

import 'package:flutter/material.dart';
import 'package:schedify/models/shift.dart';
import 'package:schedify/screens/shifts_screen.dart';
import 'package:schedify/utils/shift_manager.dart';
import 'package:schedify/widgets/ch_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late StreamSubscription<Shift> _shiftStartedSubscription;
  late StreamSubscription<Shift> _shiftEndedSubscription;
  late StreamSubscription<Shift> _breakStartedSubscription;
  late StreamSubscription<Shift> _breakEndedSubscription;

  Shift? _currentShift;

  @override
  void initState() {
    super.initState();

    initSubscriptions();
    initShift();
  }

  @override
  void dispose() {
    cancelSubscriptions();
    super.dispose();
  }

  void initSubscriptions() {
    _shiftStartedSubscription =
        ShiftManager.instance.onShiftStarted.listen(_onShiftStarted);
    _shiftEndedSubscription =
        ShiftManager.instance.onShiftEnded.listen(_onShiftEnded);
    _breakStartedSubscription =
        ShiftManager.instance.onBreakStarted.listen(_onBreakStarted);
    _breakEndedSubscription =
        ShiftManager.instance.onBreakEnded.listen(_onBreakEnded);
  }

  void cancelSubscriptions() {
    _shiftStartedSubscription.cancel();
    _shiftEndedSubscription.cancel();
    _breakStartedSubscription.cancel();
    _breakEndedSubscription.cancel();
  }

  void initShift() async {
    Shift? shift = await ShiftManager.instance.getCurrentShift();
    setState(() {
      _currentShift = shift;
    });
  }

  void _onShiftStarted(Shift shift) {
    setState(() {
      _currentShift = shift;
    });
  }

  void _onShiftEnded(Shift shift) {
    setState(() {
      _currentShift = null;
    });
  }

  void _onBreakStarted(Shift shift) {
    setState(() {
      _currentShift = shift;
    });
  }

  void _onBreakEnded(Shift shift) {
    setState(() {
      _currentShift = shift;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(
          child: Container(
        // color: Colors.green,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: Colors.blue,
              ),
              onPressed: () {
                if (_currentShift == null) {
                  ShiftManager.instance.startShift();
                } else {
                  ShiftManager.instance.endShift();
                }
              },
              child: CHText(
                _currentShift == null ? 'Start Shift' : 'End Shift',
                fontColor: Colors.white,
                fontSize: 20,
              ),
            ),
            if (_currentShift != null)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Colors.blue,
                ),
                onPressed: () {
                  if (_currentShift!.currentBreak == null) {
                    ShiftManager.instance.startBreak();
                  } else {
                    ShiftManager.instance.endBreak();
                  }
                },
                child: CHText(
                  _currentShift!.currentBreak == null
                      ? 'Start Break'
                      : 'End Break',
                  fontColor: Colors.white,
                  fontSize: 20,
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Colors.blue,
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ShiftsScreen(),
                  ));
                },
                child: const CHText(
                  'View All',
                  fontColor: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
