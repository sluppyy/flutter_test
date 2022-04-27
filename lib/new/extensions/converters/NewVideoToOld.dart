import 'package:startup_namer/new/controller/VideosController.dart';
import 'package:startup_namer/new/data/Video.dart';
import 'package:startup_namer/legacy/MusicChoise.dart' as legacy;

extension NewToOld on Video {
  legacy.Video toVideo() => legacy.Video(
    title,
    author,
    id: id,
    src: src,
    preview_src: previewSrc,
    duration_by_sec: durationBySec,
    is_liked: isLiked
  );
}

extension OldToNew on legacy.Video {
  Video toVideo() => Video(
    title,
    author,
    id: id,
    src: src,
    previewSrc: preview_src,
    durationBySec: duration_by_sec,
    isLiked: is_liked
  );
}

extension NewToOldList on List<Video> {
  List<legacy.Video> toVideos() => map((v) => v.toVideo()).toList();
}

extension SelectOldAsNew on VideosController {
  void selectOldVideo(legacy.Video legacyVideo) => selectVideo(legacyVideo.toVideo());

  void likeOld(legacy.Video legacyVideo) => likeVideo(legacyVideo.toVideo());
}