import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'clinic_location_screen.dart';
import 'doctor_list_screen.dart';
import 'home_screen.dart';
import 'my_appointments_screen.dart';
import 'profile_settings_screen.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key, this.initialIndex = 0});

  static const routeName = '/home';

  final int initialIndex;

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  void _goToTab(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomeScreen(
        onSeeDoctors: () => _goToTab(1),
        onSeeAppointments: () => _goToTab(2),
        onSeeLocation: () => _goToTab(3),
      ),
      const DoctorListScreen(),
      MyAppointmentsScreen(onBookNow: () => _goToTab(1)),
      const ClinicLocationScreen(),
      const ProfileSettingsScreen(),
    ];

    final titles = [
      'Home',
      'Find doctors',
      'My appointments',
      'Clinic location',
      'Profile',
    ];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(titles[_selectedIndex]),
        actions: [
          IconButton(
            tooltip: 'Notifications',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'No new notifications. Reminders are simulated.',
                  ),
                ),
              );
            },
            icon: const Icon(Icons.notifications_none_rounded),
          ),
          const SizedBox(width: 6),
        ],
      ),
      body: IndexedStack(index: _selectedIndex, children: pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _goToTab,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.medical_services_outlined),
            selectedIcon: Icon(Icons.medical_services_rounded),
            label: 'Doctors',
          ),
          NavigationDestination(
            icon: Icon(Icons.event_note_outlined),
            selectedIcon: Icon(Icons.event_note_rounded),
            label: 'Visits',
          ),
          NavigationDestination(
            icon: Icon(Icons.location_on_outlined),
            selectedIcon: Icon(Icons.location_on_rounded),
            label: 'Clinic',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline_rounded),
            selectedIcon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
      ),
      floatingActionButton: _selectedIndex == 1
          ? null
          : FloatingActionButton(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              tooltip: 'Book appointment',
              onPressed: () => _goToTab(1),
              child: const Icon(Icons.add_rounded),
            ),
    );
  }
}
