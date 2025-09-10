class LeaderboardUser {
  final int rank;
  final String name;
  final int points;
  final String? avatarUrl;

  const LeaderboardUser({
    required this.rank,
    required this.name,
    required this.points,
    this.avatarUrl,
  });

  String get pointsDisplay => '$points points';
  String get initials =>
      name.isNotEmpty ? name.substring(0, 1).toUpperCase() : 'U';

  // Mock data for development
  static List<LeaderboardUser> getMockData() {
    return const [
      LeaderboardUser(rank: 1, name: 'Ethan', points: 1200),
      LeaderboardUser(rank: 2, name: 'Noah', points: 1150),
      LeaderboardUser(rank: 3, name: 'Liam', points: 1100),
      LeaderboardUser(rank: 4, name: 'Oliver', points: 1050),
      LeaderboardUser(rank: 5, name: 'Alex', points: 1000),
    ];
  }
}
