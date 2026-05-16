import 'package:flutter/material.dart';

import '../models/doctor.dart';
import '../theme/app_theme.dart';
import '../widgets/app_button.dart';
import '../widgets/doctor_avatar.dart';
import '../widgets/responsive_page.dart';
import 'appointment_booking_screen.dart';

class DoctorProfileScreen extends StatelessWidget {
  const DoctorProfileScreen({super.key, required this.doctor});

  final Doctor doctor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Doctor profile')),
      body: ResponsivePage(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ProfileHeader(doctor: doctor),
            const SizedBox(height: 20),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _StatTile(
                  icon: Icons.star_rounded,
                  label: 'Rating',
                  value: '${doctor.rating}',
                ),
                _StatTile(
                  icon: Icons.chat_bubble_outline_rounded,
                  label: 'Reviews',
                  value: '${doctor.reviewCount}',
                ),
                _StatTile(
                  icon: Icons.work_history_outlined,
                  label: 'Experience',
                  value: '${doctor.experienceYears} yrs',
                ),
                _StatTile(
                  icon: Icons.payments_outlined,
                  label: 'Fee',
                  value: doctor.consultationFee,
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text('About', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(
              doctor.bio,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.muted,
                height: 1.45,
              ),
            ),
            const SizedBox(height: 24),
            Text('Services', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: doctor.services
                  .map(
                    (service) => _InfoPill(
                      label: service,
                      icon: Icons.check_circle_outline,
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 24),
            Text(
              'Available days',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: doctor.availableDays
                  .map((day) => _InfoPill(label: day))
                  .toList(),
            ),
            const SizedBox(height: 24),
            Text(
              'Popular slots',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: doctor.timeSlots
                  .map(
                    (slot) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Text(
                        slot,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 30),
            AppButton(
              label: 'Book appointment',
              icon: Icons.calendar_month_outlined,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => AppointmentBookingScreen(doctor: doctor),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({required this.doctor});

  final Doctor doctor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final avatar = DoctorAvatar(doctor: doctor, size: 96);
          final info = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                doctor.name,
                style: Theme.of(
                  context,
                ).textTheme.headlineMedium?.copyWith(color: Colors.white),
              ),
              const SizedBox(height: 6),
              Text(
                doctor.specialty,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 14),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    color: Colors.white,
                    size: 18,
                  ),
                  const SizedBox(width: 5),
                  Flexible(
                    child: Text(
                      doctor.location,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );

          if (constraints.maxWidth < 560) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [avatar, const SizedBox(height: 16), info],
            );
          }

          return Row(
            children: [
              avatar,
              const SizedBox(width: 18),
              Expanded(child: info),
            ],
          );
        },
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: AppColors.primary),
            const SizedBox(height: 10),
            Text(
              value,
              style: const TextStyle(
                color: AppColors.text,
                fontWeight: FontWeight.w900,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 2),
            Text(label, style: const TextStyle(color: AppColors.muted)),
          ],
        ),
      ),
    );
  }
}

class _InfoPill extends StatelessWidget {
  const _InfoPill({required this.label, this.icon});

  final String label;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, color: AppColors.primary, size: 18),
            const SizedBox(width: 7),
          ],
          Text(
            label,
            style: const TextStyle(
              color: AppColors.text,
              fontWeight: FontWeight.w800,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}