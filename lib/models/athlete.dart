class Athlete {
  final String id;
  final String name;
  final int age;
  final String gender;
  final String district;
  final String city;
  final List<String> sports;
  final Map<String, int> percentiles;
  final String? photoUrl;
  final bool mobileVerified;
  final bool guardianVerified;
  final bool schoolVerified;

  const Athlete({
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
    required this.district,
    required this.city,
    required this.sports,
    required this.percentiles,
    this.photoUrl,
    this.mobileVerified = false,
    this.guardianVerified = false,
    this.schoolVerified = false,
  });

  String get displayId => 'SM-IN-${id.substring(id.length - 6).toUpperCase()}';
  String get genderDisplay => gender == 'M' ? 'Male' : gender == 'F' ? 'Female' : 'Other';
  
  int get overallPercentile {
    if (percentiles.isEmpty) return 0;
    return (percentiles.values.reduce((a, b) => a + b) / percentiles.length).round();
  }

  // Mock data for development
  static Athlete getMockAthlete() {
    return const Athlete(
      id: '7A2C94',
      name: 'Aditi Sharma',
      age: 16,
      gender: 'F',
      district: 'Indore',
      city: 'Indore',
      sports: ['Athletics', 'Basketball'],
      percentiles: {'strength': 74, 'speed': 69, 'endurance': 81},
      mobileVerified: true,
      guardianVerified: true,
      schoolVerified: false,
    );
  }
}
