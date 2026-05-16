import 'package:flutter/material.dart';

import '../models/doctor.dart';
import '../theme/app_theme.dart';

class DoctorAvatar extends StatelessWidget {
  const DoctorAvatar({super.key, required this.doctor, this.size = 70});

  final Doctor doctor;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Color(doctor.colorValue),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white, width: 3),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.10),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            Icons.medical_services_outlined,
            color: AppColors.primary.withValues(alpha: 0.16),
            size: size * 0.62,
          ),
          Text(
            doctor.initials,
            style: TextStyle(
              color: AppColors.primaryDark,
              fontSize: size * 0.25,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}
