import 'package:flutter/material.dart';

import '../app_state.dart';
import '../models/appointment.dart';
import '../theme/app_theme.dart';
import '../utils/date_formatters.dart';
import '../widgets/app_button.dart';
import '../widgets/responsive_page.dart';
import 'main_shell.dart';

class BookingConfirmationScreen extends StatelessWidget {
  const BookingConfirmationScreen({super.key, required this.appointment});

  final Appointment appointment;

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking confirmed'),
        automaticallyImplyLeading: false,
      ),
      body: ResponsivePage(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 92,
              height: 92,
              decoration: BoxDecoration(
                color: AppColors.success.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.check_circle_rounded,
                color: AppColors.success,
                size: 58,
              ),
            ),
            const SizedBox(height: 18),
            Text(
              'Appointment booked',
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Your visit has been added to local appointment history.',
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppColors.muted),
            ),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                children: [
                  _DetailRow(
                    icon: Icons.medical_services_outlined,
                    label: 'Doctor',
                    value: appointment.doctor.name,
                  ),
                  _DetailRow(
                    icon: Icons.calendar_month_outlined,
                    label: 'Date',
                    value: fullDate(appointment.date),
                  ),
                  _DetailRow(
                    icon: Icons.schedule_outlined,
                    label: 'Time',
                    value: appointment.time,
                  ),
                  _DetailRow(
                    icon: Icons.notes_outlined,
                    label: 'Reason',
                    value: appointment.reason,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.sky,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.notifications_active_outlined,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      state.simulatedReminderFor(appointment),
                      style: const TextStyle(
                        color: AppColors.primaryDark,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            AppButton(
              label: 'View my appointments',
              icon: Icons.event_note_outlined,
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (_) => const MainShell(initialIndex: 2),
                  ),
                  (route) => false,
                );
              },
            ),
            const SizedBox(height: 10),
            AppButton(
              label: 'Back to home',
              icon: Icons.home_outlined,
              outlined: true,
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const MainShell()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.primary),
          const SizedBox(width: 12),
          SizedBox(
            width: 76,
            child: Text(
              label,
              style: const TextStyle(
                color: AppColors.muted,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w800),
            ),
          ),
        ],
      ),
    );
  }
}
