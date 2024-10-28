import 'package:flutter/material.dart';
import 'package:realm/realm.dart';
import 'package:schedify/models/shift.dart';
import 'package:schedify/utils/database.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    Shift wd = Shift(ObjectId());

    wd.startBreak();
    wd.endBreak();

    wd.end();

    Database.instance.write(() {
      Database.instance.add(wd);
    });

    // clear all
    // Database.instance.write(() {
    //   for (var wd in Database.instance.all<WorkDay>()) {
    //     Database.instance.delete(wd);
    //   }
    // });

    test();
  }

  test() async {
    // wait for 2 sec
    debugPrint("WAITING FOR 1 SEC");
    await Future.delayed(const Duration(seconds: 1));

    debugPrint("Getting all work days");
    // get all work days
    var wds = Database.instance.all<Shift>();
    for (var wd in wds) {
      debugPrint("Start: ${wd.startDate} - End: ${wd.endDate}.");
      for (var brk in wd.breaks) {
        debugPrint("Break Start: ${brk.startDate} - End: ${brk.endDate}.");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(child: Container(color: Colors.red)),
    );
  }
}
