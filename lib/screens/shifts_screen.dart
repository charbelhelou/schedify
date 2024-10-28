import 'package:flutter/material.dart';
import 'package:realm/realm.dart';
import 'package:intl/intl.dart';
import 'package:schedify/models/shift.dart';
import 'package:schedify/utils/database.dart';

class ShiftsScreen extends StatelessWidget {
  const ShiftsScreen({super.key});

  String _formatDuration(DateTime? start, DateTime? end) {
    if (start == null) return 'Not started';
    if (end == null) return 'In progress';

    Duration duration = end.difference(start);
    int hours = duration.inHours;
    int minutes = duration.inMinutes.remainder(60);
    int seconds = duration.inSeconds.remainder(60);

    return '${hours}h ${minutes}m ${seconds}s';
  }

  String _formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return 'Not set';
    return DateFormat('MMM dd, yyyy HH:mm').format(dateTime);
  }

  Widget _buildBreakItem(Break breakItem) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Break',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  _formatDuration(breakItem.startDate, breakItem.endDate),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.play_arrow, size: 16),
                const SizedBox(width: 4),
                Text(_formatDateTime(breakItem.startDate)),
              ],
            ),
            if (breakItem.endDate != null) ...[
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.stop, size: 16),
                  const SizedBox(width: 4),
                  Text(_formatDateTime(breakItem.endDate)),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildShiftCard(Shift shift) {
    bool isActive = shift.endDate == null;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: isActive ? Colors.green : Colors.grey,
                  width: 4,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      isActive ? 'Active Shift' : 'Completed Shift',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: isActive ? Colors.green[100] : Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        _formatDuration(shift.startDate, shift.endDate),
                        style: TextStyle(
                          color:
                              isActive ? Colors.green[900] : Colors.grey[900],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.play_arrow, size: 16),
                    const SizedBox(width: 4),
                    Text(_formatDateTime(shift.startDate)),
                  ],
                ),
                if (shift.endDate != null) ...[
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.stop, size: 16),
                      const SizedBox(width: 4),
                      Text(_formatDateTime(shift.endDate)),
                    ],
                  ),
                ],
              ],
            ),
          ),
          if (shift.breaks.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Breaks (${shift.breaks.length})',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: shift.breaks.length,
              itemBuilder: (context, index) =>
                  _buildBreakItem(shift.breaks[index]),
            ),
            const SizedBox(height: 8),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<RealmResultsChanges<Shift>>(
        stream: Database.instance.all<Shift>().changes,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final shifts = Database.instance
              .all<Shift>()
              .query('TRUEPREDICATE SORT(startDate DESC)')
              .toList();

          if (shifts.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.work_off,
                    size: 48,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'No shifts recorded yet',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: shifts.length,
            itemBuilder: (context, index) => _buildShiftCard(shifts[index]),
          );
        },
      ),
    );
  }
}
