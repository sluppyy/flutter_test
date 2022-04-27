class Video {
  final int id;
  final String title;
  final String author;
  final String previewSrc;
  final int durationBySec;
  final bool isLiked;
  final String src;

  Video(
      this.title,
      this.author, {
        this.previewSrc = "assets/club.jpg",
        this.durationBySec = 60*3 + 26,
        this.isLiked = false,
        required this.src,
        required this.id
      });

  Video like() {
    return Video(
        title,
        author,
        previewSrc: previewSrc,
        durationBySec: durationBySec,
        isLiked: !isLiked,
        src: src,
        id: id);
  }

  static Video empty() => Video("title", "author", src: "", id: 0);
}