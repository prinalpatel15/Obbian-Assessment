class RideNavItem {
  const RideNavItem({required this.image, this.label});

  final String image;

  /// Hidden while the tab is selected (selected tab shows only the vehicle).
  final String? label;
}
