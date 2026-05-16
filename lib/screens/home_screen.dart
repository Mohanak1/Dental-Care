import 'package:flutter/material.dart';

import '../app_state.dart';
import '../data/dummy_data.dart';
import '../models/doctor.dart';
import '../theme/app_theme.dart';
import '../widgets/app_button.dart';
import '../widgets/appointment_card.dart';
import '../widgets/doctor_card.dart';
import '../widgets/responsive_page.dart';
import 'doctor_profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.onSeeDoctors,
    required this.onSeeAppointments,
    required this.onSeeLocation,
  });

  final VoidCallback onSeeDoctors;
  final VoidCallback onSeeAppointments;
  final VoidCallback onSeeLocation;

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final nextAppointment = state.nextAppointment;

    return ResponsivePage(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _HeroPanel(
            name: state.userName,
            onBook: onSeeDoctors,
            onLocation: onSeeLocation,
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _QuickAction(
                icon: Icons.medical_services_outlined,
                label: 'Find doctor',
                onTap: onSeeDoctors,
              ),
              _QuickAction(
                icon: Icons.event_available_outlined,
                label: 'Appointments',
                onTap: onSeeAppointments,
              ),
              _QuickAction(
                icon: Icons.notifications_active_outlined,
                label: 'Reminder',
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Reminder messages appear after booking.'),
                    ),
                  );
                },
              ),
              _QuickAction(
                icon: Icons.location_on_outlined,
                label: 'Clinic map',
                onTap: onSeeLocation,
              ),
            ],
          ),
          const SizedBox(height: 26),
          SectionHeader(
            title: 'Featured doctors',
            actionLabel: 'See all',
            onAction: onSeeDoctors,
          ),
          const SizedBox(height: 12),
          LayoutBuilder(
            builder: (context, constraints) {
              final useGrid = constraints.maxWidth > 720;
              if (!useGrid) {
                return Column(
                  children: dummyDoctors.take(3).map((doctor) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: DoctorCard(
                        doctor: doctor,
                        compact: true,
                        onTap: () => _openDoctor(context, doctor),
                      ),
                    );
                  }).toList(),
                );
              }
              return GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 2.7,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children: dummyDoctors.take(4).map((doctor) {
                  return DoctorCard(
                    doctor: doctor,
                    compact: true,
                    onTap: () => _openDoctor(context, doctor),
                  );
                }).toList(),
              );
            },
          ),
          const SizedBox(height: 26),
          SectionHeader(
            title: 'Next appointment',
            actionLabel: nextAppointment == null ? null : 'History',
            onAction: nextAppointment == null ? null : onSeeAppointments,
          ),
          const SizedBox(height: 12),
          if (nextAppointment == null)
            _NoAppointment(onBook: onSeeDoctors)
          else
            AppointmentCard(
              appointment: nextAppointment,
              onCancel: () => state.cancelAppointment(nextAppointment.id),
            ),
        ],
      ),
    );
  }

  void _openDoctor(BuildContext context, Doctor doctor) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => DoctorProfileScreen(doctor: doctor)),
    );
  }
}

class _HeroPanel extends StatelessWidget {
  const _HeroPanel({
    required this.name,
    required this.onBook,
    required this.onLocation,
  });

  final String name;
  final VoidCallback onBook;
  final VoidCallback onLocation;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.18),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 620;
          final text = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello, $name',
                style: const TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Book trusted dental care with local clinic specialists.',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                  height: 1.15,
                ),
              ),
              const SizedBox(height: 18),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  FilledButton.icon(
                    onPressed: onBook,
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppColors.primaryDark,
                    ),
                    icon: const Icon(Icons.calendar_month_outlined),
                    label: const Text('Book appointment'),
                  ),
                  OutlinedButton.icon(
                    onPressed: onLocation,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white54),
                    ),
                    icon: const Icon(Icons.location_on_outlined),
                    label: const Text('Clinic'),
                  ),
                ],
              ),
            ],
          );

          final art = Container(
            width: isWide ? 190 : double.infinity,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.health_and_safety_outlined,
              size: 86,
              color: Colors.white,
            ),
          );

          if (!isWide) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [text, const SizedBox(height: 18), art],
            );
          }

          return Row(
            children: [
              Expanded(child: text),
              const SizedBox(width: 18),
              art,
            ],
          );
        },
      ),
    );
  }
}

class _QuickAction extends StatelessWidget {
  const _QuickAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 156,
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.border),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(icon, color: AppColors.primary),
                const SizedBox(height: 12),
                Text(
                  label,
                  style: const TextStyle(
                    color: AppColors.text,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NoAppointment extends StatelessWidget {
  const _NoAppointment({required this.onBook});

  final VoidCallback onBook;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: AppColors.sky,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.event_available_outlined,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Text(
              'No upcoming visits yet. Choose a doctor and reserve a time.',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(width: 10),
          AppButton(
            label: 'Book',
            icon: Icons.add_rounded,
            onPressed: onBook,
            fullWidth: false,
          ),
        ],
      ),
    );
  }
}
