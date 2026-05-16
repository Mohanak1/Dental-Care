import 'package:flutter/material.dart';

import '../data/dummy_data.dart';
import '../models/doctor.dart';
import '../theme/app_theme.dart';
import '../widgets/app_text_field.dart';
import '../widgets/doctor_card.dart';
import '../widgets/responsive_page.dart';
import 'doctor_profile_screen.dart';

class DoctorListScreen extends StatefulWidget {
  const DoctorListScreen({super.key});

  @override
  State<DoctorListScreen> createState() => _DoctorListScreenState();
}

class _DoctorListScreenState extends State<DoctorListScreen> {
  final _searchController = TextEditingController();
  String _selectedSpecialty = 'All';

  List<String> get _specialties {
    return ['All', ...dummyDoctors.map((doctor) => doctor.specialty).toSet()];
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_refreshSearch);
  }

  @override
  void dispose() {
    _searchController.removeListener(_refreshSearch);
    _searchController.dispose();
    super.dispose();
  }

  void _refreshSearch() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final query = _searchController.text.toLowerCase().trim();
    final filtered = dummyDoctors.where((doctor) {
      final matchesQuery =
          query.isEmpty ||
          doctor.name.toLowerCase().contains(query) ||
          doctor.specialty.toLowerCase().contains(query) ||
          doctor.location.toLowerCase().contains(query);
      final matchesSpecialty =
          _selectedSpecialty == 'All' || doctor.specialty == _selectedSpecialty;
      return matchesQuery && matchesSpecialty;
    }).toList();

    return ResponsivePage(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
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
                  'Choose your specialist',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 12),
                AppTextField(
                  controller: _searchController,
                  label: 'Search',
                  hint: 'Doctor, specialty, or clinic',
                  icon: Icons.search_rounded,
                  textInputAction: TextInputAction.search,
                ),
                const SizedBox(height: 14),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _specialties.map((specialty) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ChoiceChip(
                          label: Text(specialty),
                          selected: specialty == _selectedSpecialty,
                          onSelected: (_) {
                            setState(() => _selectedSpecialty = specialty);
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Text(
            '${filtered.length} doctors available',
            style: const TextStyle(
              color: AppColors.muted,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: filtered.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final doctor = filtered[index];
              return DoctorCard(
                doctor: doctor,
                onTap: () => _openDoctor(context, doctor),
              );
            },
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
