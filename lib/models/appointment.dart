import 'doctor.dart';

enum AppointmentStatus { upcoming, completed, cancelled }

extension AppointmentStatusText on AppointmentStatus {
  String get label {
    switch (this) {
      case AppointmentStatus.upcoming:
        return 'Upcoming';
      case AppointmentStatus.completed:
        return 'Completed';
      case AppointmentStatus.cancelled:
        return 'Cancelled';
    }
  }
}

class Appointment {
  const Appointment({
    required this.id,
    required this.doctor,
    required this.date,
    required this.time,
    required this.reason,
    required this.status,
    required this.createdAt,
  });

  final String id;
  final Doctor doctor;
  final DateTime date;
  final String time;
  final String reason;
  final AppointmentStatus status;
  final DateTime createdAt;

  Appointment copyWith({
    Doctor? doctor,
    DateTime? date,
    String? time,
    String? reason,
    AppointmentStatus? status,
    DateTime? createdAt,
  }) {
    return Appointment(
      id: id,
      doctor: doctor ?? this.doctor,
      date: date ?? this.date,
      time: time ?? this.time,
      reason: reason ?? this.reason,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
