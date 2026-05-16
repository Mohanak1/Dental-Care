import 'package:flutter/material.dart';

import '../models/doctor.dart';
import '../theme/app_theme.dart';
import 'app_button.dart';
import 'doctor_avatar.dart';

class DoctorCard extends StatelessWidget {
  const DoctorCard({
    super.key,
    required this.doctor,
    required this.onTap,
    this.compact = false,
  });

  final Doctor doctor;
  final VoidCallback onTap;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DoctorAvatar(doctor: doctor, size: compact ? 58 : 72),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctor.name,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      doctor.specialty,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _MiniInfo(
                          icon: Icons.star_rounded,
                          text: '${doctor.rating} (${doctor.reviewCount})',
                        ),
                        _MiniInfo(
                          icon: Icons.work_history_outlined,
                          text: '${doctor.experienceYears} yrs',
                        ),
                        _MiniInfo(
                          icon: Icons.payments_outlined,
                          text: doctor.consultationFee,
                        ),
                      ],
                    ),
                    if (!compact) ...[
                      const SizedBox(height: 12),
                      Text(
                        doctor.location,
                        style: const TextStyle(
                          color: AppColors.muted,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 8),
              AppButton(
                label: 'View',
                icon: Icons.arrow_forward_rounded,
                onPressed: onTap,
                fullWidth: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MiniInfo extends StatelessWidget {
  const _MiniInfo({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.sky,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppColors.primary),
          const SizedBox(width: 5),
          Text(
            text,
            style: const TextStyle(
              color: AppColors.primaryDark,
              fontWeight: FontWeight.w700,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
