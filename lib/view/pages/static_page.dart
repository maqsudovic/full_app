// lib/pages/statistics_page.dart

import 'package:flutter/material.dart';

class StatisticsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int completedTasks = 7;
    int incompleteTasks = 3;
    int reminders = 5;

    return Scaffold(
      appBar: AppBar(
        title: Text('Statistics'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.0),
            Text(
              'Tasks',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Completed tasks: $completedTasks'),
                Text('Incomplete tasks: $incompleteTasks'),
              ],
            ),
            SizedBox(height: 16.0),
            Text(
              'Reminders',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text('Number of reminders: $reminders'),
          ],
        ),
      ),
    );
  }
}