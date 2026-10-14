class RecentPlace {
  const RecentPlace({
    required this.title,
    required this.address,
    required this.distance,
    this.isFavorite = false,
  });

  final String title;
  final String address;
  final String distance;
  final bool isFavorite;
}
