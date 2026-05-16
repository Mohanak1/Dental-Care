import 'package:flutter/material.dart';

import '../app_state.dart';
import '../models/appointment.dart';
import '../theme/app_theme.dart';
import '../widgets/appointment_card.dart';
import '../widgets/empty_state.dart';
import '../widgets/responsive_page.dart';

class MyAppointmentsScreen extends StatefulWidget {
  const MyAppointmentsScreen({super.key, required this.onBookNow});

  final VoidCallback onBookNow;

  @override
  State<MyAppointmentsScreen> createState() => _MyAppointmentsScreenState();
}

class _MyAppointmentsScreenState extends State<MyAppointmentsScreen> {
  String _filter = 'All';

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final appointments = state.appointments.where((appointment) {
      if (_filter == 'All') {
        return true;
      }
      return appointment.status.label == _filter;
    }).toList();

    return ResponsivePage(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
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
                    Icons.event_note_outlined,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Appointment history',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${state.appointments.length} local bookings saved',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: ['All', 'Upcoming', 'Completed', 'Cancelled'].map((item) {
              return ChoiceChip(
                label: Text(item),
                selected: _filter == item,
                onSelected: (_) => setState(() => _filter = item),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          if (appointments.isEmpty)
            EmptyState(
              icon: Icons.event_busy_outlined,
              title: 'No appointments found',
              message: _filter == 'All'
                  ? 'Book an appointment with one of the available doctors.'
                  : 'There are no appointments in this filter yet.',
              actionLabel: 'Book now',
              onAction: widget.onBookNow,
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: appointments.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final appointment = appointments[index];
                return AppointmentCard(
                  appointment: appointment,
                  onCancel: appointment.status == AppointmentStatus.upcoming
                      ? () => _confirmCancel(context, appointment)
                      : null,
                );
              },
            ),
        ],
      ),
    );
  }

  void _confirmCancel(BuildContext context, Appointment appointment) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Cancel appointment?'),
          content: Text(
            'This will mark your visit with ${appointment.doctor.name} as cancelled in local history.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Keep'),
            ),
            FilledButton(
              onPressed: () {
                AppScope.of(
                  context,
                  listen: false,
                ).cancelAppointment(appointment.id);
                Navigator.of(dialogContext).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Appointment cancelled.')),
                );
              },
              child: const Text('Cancel appointment'),
            ),
          ],
        );
      },
    );
  }
}
