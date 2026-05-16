import 'package:flutter/material.dart';

import '../app_state.dart';
import '../models/doctor.dart';
import '../theme/app_theme.dart';
import '../utils/date_formatters.dart';
import '../widgets/app_button.dart';
import '../widgets/app_text_field.dart';
import '../widgets/doctor_avatar.dart';
import '../widgets/responsive_page.dart';
import 'booking_confirmation_screen.dart';

class AppointmentBookingScreen extends StatefulWidget {
  const AppointmentBookingScreen({super.key, required this.doctor});

  final Doctor doctor;

  @override
  State<AppointmentBookingScreen> createState() =>
      _AppointmentBookingScreenState();
}

class _AppointmentBookingScreenState extends State<AppointmentBookingScreen> {
  late DateTime _selectedDate;
  late String _selectedTime;
  final _reasonController = TextEditingController(
    text: 'Routine dental checkup',
  );

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now().add(const Duration(days: 1));
    _selectedTime = widget.doctor.timeSlots.first;
  }

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  void _book() {
    final appointment = AppScope.of(context, listen: false).bookAppointment(
      doctor: widget.doctor,
      date: _selectedDate,
      time: _selectedTime,
      reason: _reasonController.text,
    );

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => BookingConfirmationScreen(appointment: appointment),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dates = List.generate(
      7,
      (index) => DateTime.now().add(Duration(days: index + 1)),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Book appointment')),
      body: ResponsivePage(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  DoctorAvatar(doctor: widget.doctor, size: 64),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.doctor.name,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 4),
                        Text(widget.doctor.specialty),
                        const SizedBox(height: 8),
                        Text(
                          widget.doctor.consultationFee,
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text('Select date', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: dates.map((date) {
                  final selected = _isSameDate(date, _selectedDate);
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: ChoiceChip(
                      selected: selected,
                      onSelected: (_) => setState(() => _selectedDate = date),
                      label: SizedBox(
                        width: 74,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(shortWeekdayName(date)),
                            const SizedBox(height: 4),
                            Text(
                              '${date.day}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 24),
            Text('Select time', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: widget.doctor.timeSlots.map((slot) {
                return ChoiceChip(
                  label: Text(slot),
                  selected: slot == _selectedTime,
                  onSelected: (_) => setState(() => _selectedTime = slot),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            AppTextField(
              controller: _reasonController,
              label: 'Reason for visit',
              hint: 'Tell the clinic what you need',
              icon: Icons.notes_outlined,
              maxLines: 3,
            ),
            const SizedBox(height: 24),
            Container(
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
                      'A simulated reminder will be shown after booking for ${fullDate(_selectedDate)} at $_selectedTime.',
                      style: const TextStyle(
                        color: AppColors.primaryDark,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            AppButton(
              label: 'Confirm booking',
              icon: Icons.check_circle_outline_rounded,
              onPressed: _book,
            ),
          ],
        ),
      ),
    );
  }

  bool _isSameDate(DateTime first, DateTime second) {
    return first.year == second.year &&
        first.month == second.month &&
        first.day == second.day;
  }
}
