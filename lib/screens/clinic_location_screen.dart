import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/app_button.dart';
import '../widgets/responsive_page.dart';

class ClinicLocationScreen extends StatelessWidget {
  const ClinicLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'DentalCare Main Clinic',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Olaya Street, Riyadh 12211, Saudi Arabia',
                  style: TextStyle(color: AppColors.muted),
                ),
                const SizedBox(height: 18),
                const _MapPreview(),
                const SizedBox(height: 18),
                AppButton(
                  label: 'Open in Maps',
                  icon: Icons.map_outlined,
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Open in Maps is simulated. No real map integration is used.',
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          LayoutBuilder(
            builder: (context, constraints) {
              final useGrid = constraints.maxWidth > 700;
              final items = const <Widget>[
                _ClinicInfo(
                  icon: Icons.schedule_outlined,
                  title: 'Clinic hours',
                  value: 'Sun - Thu, 8:00 AM - 8:00 PM',
                ),
                _ClinicInfo(
                  icon: Icons.call_outlined,
                  title: 'Phone',
                  value: '+966 11 555 0199',
                ),
                _ClinicInfo(
                  icon: Icons.local_parking_outlined,
                  title: 'Parking',
                  value: 'Free patient parking on Basement B1',
                ),
                _ClinicInfo(
                  icon: Icons.accessible_outlined,
                  title: 'Access',
                  value: 'Elevator access and wheelchair-friendly entry',
                ),
              ];

              if (!useGrid) {
                return Column(
                  children: items
                      .map(
                        (item) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: item,
                        ),
                      )
                      .toList(),
                );
              }

              return GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 3.4,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: items,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _MapPreview extends StatelessWidget {
  const _MapPreview();

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.sky,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.border),
        ),
        child: CustomPaint(
          painter: _MapPainter(),
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.location_on_rounded, color: Colors.white),
                  SizedBox(width: 6),
                  Text(
                    'DentalCare',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final roadPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 16
      ..strokeCap = StrokeCap.round;
    final accentPaint = Paint()
      ..color = AppColors.primary.withValues(alpha: 0.22)
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
      Offset(size.width * 0.08, size.height * 0.24),
      Offset(size.width * 0.92, size.height * 0.18),
      roadPaint,
    );
    canvas.drawLine(
      Offset(size.width * 0.14, size.height * 0.72),
      Offset(size.width * 0.86, size.height * 0.82),
      roadPaint,
    );
    canvas.drawLine(
      Offset(size.width * 0.24, size.height * 0.08),
      Offset(size.width * 0.34, size.height * 0.92),
      accentPaint,
    );
    canvas.drawLine(
      Offset(size.width * 0.68, size.height * 0.06),
      Offset(size.width * 0.58, size.height * 0.94),
      accentPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ClinicInfo extends StatelessWidget {
  const _ClinicInfo({
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.text,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(value, style: const TextStyle(color: AppColors.muted)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
