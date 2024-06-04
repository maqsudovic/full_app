// main.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';
import 'package:full_app/view/pages/static_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    HomePage(),
    ResultsPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      home: kIsWeb
          ? Scaffold(
              body: Row(
                children: [
                  NavigationRail(
                    selectedIndex: _selectedIndex,
                    onDestinationSelected: (index) {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                    destinations: [
                      NavigationRailDestination(
                        icon: Icon(Icons.home),
                        label: Text('Home'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.list),
                        label: Text('Results'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.person),
                        label: Text('Profile'),
                      ),
                    ],
                  ),
                  Expanded(
                    child: _pages[_selectedIndex],
                  ),
                ],
              ),
            )
          : Scaffold(
              body: _pages[_selectedIndex],
              bottomNavigationBar: BottomNavigationBar(
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.list),
                    label: 'Results',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'Profile',
                  ),
                ],
                currentIndex: _selectedIndex,
                onTap: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              ),
            ),
    );
  }
}
  Widget _buildGridItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 48.0),
          SizedBox(height: 8.0),
          Text(
            title,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
}

class ResultsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StatisticsPage(),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfilePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Plan> plans = [];

  void _showPlanDialog() async {
    Plan newPlan = await showDialog(
      context: context,
      builder: (context) => PlanDialog(plan: Plan(title: '', date: DateTime.now())),
    );
    if (newPlan != null) {
      setState(() {
        plans.add(newPlan);
      });
    }
  }

  void _editPlan(Plan plan) async {
    Plan updatedPlan = await showDialog(
      context: context,
      builder: (context) => PlanDialog(plan: plan),
    );
    if (updatedPlan != null) {
      setState(() {
        plans[plans.indexOf(plan)] = updatedPlan;
      });
    }
  }

  void _deletePlan(Plan plan) {
    setState(() {
      plans.remove(plan);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        children: [
          _buildGridItem(
            icon: Icons.calendar_today,
            title: 'Plans',
            onTap: _showPlanDialog,
          ),
          _buildGridItem(
            icon: Icons.note,
            title: 'Reminders',
            onTap: () {
              // TODO: Implement Reminders functionality
            },
          ),
        ],
      ),
    );
  }

  Widget _buildGridItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48.0),
            SizedBox(height: 8.0),
            Text(title, style: TextStyle(fontSize: 16.0)),
          ],
        ),
      ),
    );
  }
}

class Plan {
  final String title;
  final DateTime date;

  Plan({required this.title, required this.date});
}

class PlanDialog extends StatefulWidget {
  final Plan plan;

  PlanDialog({required this.plan});

  @override
  _PlanDialogState createState() => _PlanDialogState();
}

class _PlanDialogState extends State<PlanDialog> {
  late TextEditingController _titleController;
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.plan.title);
    _selectedDate = widget.plan.date;
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.plan == null ? 'Add Plan' : 'Edit Plan'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleController,
            decoration: InputDecoration(
              hintText: 'Plan Title',
            ),
          ),
          SizedBox(height: 16.0),
          GestureDetector(
            onTap: () async {
              final selectedDate = await showDatePicker(
                context: context,
                initialDate: _selectedDate,
                firstDate: DateTime.now(),
                lastDate: DateTime(2100),
              );
              if (selectedDate != null) {
                setState(() {
                  _selectedDate = selectedDate;
                });
              }
            },
            child: Row(
              children: [
                Icon(Icons.calendar_today),
                SizedBox(width: 8.0),
                Text(DateFormat('yyyy-MM-dd').format(_selectedDate)),
              ],
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(null);
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(Plan(
              title: _titleController.text,
              date: _selectedDate,
            ));
          },
          child: Text(widget.plan == null ? 'Add' : 'Save'),
        ),
        if (widget.plan != null)
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(null);
              _deletePlan(widget.plan);
            },
            child: Text('Delete'),
          ),
      ],
    );
  }

  void _deletePlan(Plan plan) {
    // TODO: Implement plan deletion logic
  }
}
