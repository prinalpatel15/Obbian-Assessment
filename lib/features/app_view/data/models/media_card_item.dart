/// Image card used by the "Explore" and "Neighborhood" carousels.
class MediaCardItem {
  const MediaCardItem({
    required this.image,
    this.title,
    this.isVideo = false,
  });

  final String image;
  final String? title;
  final bool isVideo;
}
