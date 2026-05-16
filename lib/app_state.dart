import 'package:flutter/material.dart';

import 'models/appointment.dart';
import 'models/doctor.dart';
import 'utils/date_formatters.dart';

class AppState extends ChangeNotifier {
  String _userName = 'Muhana';
  String _userEmail = 'Muhana@gmail.com';
  bool _isLoggedIn = false;
  bool _remindersEnabled = true;
  final List<Appointment> _appointments = [];

  String get userName => _userName;
  String get userEmail => _userEmail;
  bool get isLoggedIn => _isLoggedIn;
  bool get remindersEnabled => _remindersEnabled;

  List<Appointment> get appointments => List.unmodifiable(_appointments);

  Appointment? get nextAppointment {
    final upcoming =
        _appointments
            .where(
              (appointment) => appointment.status == AppointmentStatus.upcoming,
            )
            .toList()
          ..sort((a, b) {
            final dateCompare = a.date.compareTo(b.date);
            if (dateCompare != 0) {
              return dateCompare;
            }
            return a.time.compareTo(b.time);
          });

    if (upcoming.isEmpty) {
      return null;
    }
    return upcoming.first;
  }

  void login({required String email, required String password}) {
    final cleanedEmail = email.trim();
    if (cleanedEmail.isNotEmpty) {
      _userEmail = cleanedEmail;
      _userName = _nameFromEmail(cleanedEmail);
    }
    _isLoggedIn = true;
    notifyListeners();
  }

  void signUp({
    required String name,
    required String email,
    required String password,
  }) {
    final cleanedName = name.trim();
    final cleanedEmail = email.trim();
    _userName = cleanedName.isEmpty ? 'DentalCare Patient' : cleanedName;
    _userEmail = cleanedEmail.isEmpty ? 'patient@dentalcare.app' : cleanedEmail;
    _isLoggedIn = true;
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    notifyListeners();
  }

  void setRemindersEnabled(bool enabled) {
    _remindersEnabled = enabled;
    notifyListeners();
  }

  Appointment bookAppointment({
    required Doctor doctor,
    required DateTime date,
    required String time,
    required String reason,
  }) {
    final appointment = Appointment(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      doctor: doctor,
      date: DateTime(date.year, date.month, date.day),
      time: time,
      reason: reason.trim().isEmpty
          ? 'General dental consultation'
          : reason.trim(),
      status: AppointmentStatus.upcoming,
      createdAt: DateTime.now(),
    );
    _appointments.insert(0, appointment);
    notifyListeners();
    return appointment;
  }

  void cancelAppointment(String appointmentId) {
    final index = _appointments.indexWhere(
      (appointment) => appointment.id == appointmentId,
    );
    if (index == -1) {
      return;
    }
    _appointments[index] = _appointments[index].copyWith(
      status: AppointmentStatus.cancelled,
    );
    notifyListeners();
  }

  String simulatedReminderFor(Appointment appointment) {
    if (!_remindersEnabled) {
      return 'Reminders are off. Turn them on from Profile to receive simulated alerts.';
    }
    return 'Reminder set for ${appointment.doctor.name} on ${fullDate(appointment.date)} at ${appointment.time}. Please arrive 10 minutes early.';
  }

  String _nameFromEmail(String email) {
    final firstPart = email.split('@').first;
    if (firstPart.trim().isEmpty) {
      return 'DentalCare Patient';
    }
    return firstPart
        .split(RegExp(r'[._-]'))
        .where((part) => part.isNotEmpty)
        .map((part) => part[0].toUpperCase() + part.substring(1))
        .join(' ');
  }
}

class AppScope extends InheritedNotifier<AppState> {
  const AppScope({super.key, required AppState notifier, required super.child})
    : super(notifier: notifier);

  static AppState of(BuildContext context, {bool listen = true}) {
    if (listen) {
      final scope = context.dependOnInheritedWidgetOfExactType<AppScope>();
      assert(scope != null, 'AppScope was not found in the widget tree.');
      return scope!.notifier!;
    }

    final element = context.getElementForInheritedWidgetOfExactType<AppScope>();
    final scope = element?.widget as AppScope?;
    assert(scope != null, 'AppScope was not found in the widget tree.');
    return scope!.notifier!;
  }
}
