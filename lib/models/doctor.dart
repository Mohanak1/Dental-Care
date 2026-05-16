class Doctor {
  const Doctor({
    required this.id,
    required this.name,
    required this.specialty,
    required this.initials,
    required this.rating,
    required this.reviewCount,
    required this.experienceYears,
    required this.location,
    required this.bio,
    required this.availableDays,
    required this.timeSlots,
    required this.services,
    required this.consultationFee,
    required this.colorValue,
  });

  final String id;
  final String name;
  final String specialty;
  final String initials;
  final double rating;
  final int reviewCount;
  final int experienceYears;
  final String location;
  final String bio;
  final List<String> availableDays;
  final List<String> timeSlots;
  final List<String> services;
  final String consultationFee;
  final int colorValue;
}
