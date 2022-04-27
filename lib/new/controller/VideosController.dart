import 'package:flutter/cupertino.dart';
import 'package:startup_namer/new/data/Video.dart';
import 'package:startup_namer/new/extensions/converters/NewVideoToOld.dart';
import 'package:startup_namer/new/repository/VideosRepository.dart';


class VideosController {
  VideosController(this._repository);

  final VideosRepository _repository;

  final allVideos = _AllVideos([]);
  final likedVideos = _LikedVideos([]);

  final selectedVideo = _SelectedVideo(null);

  void selectVideo(Video video) {
    selectedVideo.value = allVideos.videos.firstWhere((v) => v.id == video.id);
  }

  void unselectVideo() => selectedVideo.value = null;

  void likeVideo(Video video) async {
    if (selectedVideo.video?.id == video.id) {
      selectedVideo.value = selectedVideo.video?.like();

      _repository.like(video);

      downloadVideos();
      downloadLikedVideos();
    }
  }

  void downloadVideos() async {
    allVideos.value = await _repository.allVideos() ?? [];
  }


  void downloadLikedVideos() async {
    likedVideos.value = await _repository.likedVideos() ?? [];
  }
}

class _AllVideos extends ValueNotifier<List<Video>> {
  _AllVideos(List<Video> value) : super(value);

  List<Video> get videos => super.value;
}

class _LikedVideos extends ValueNotifier<List<Video>> {
  _LikedVideos(List<Video> value) : super(value);

  List<Video> get videos => super.value;
}

class _SelectedVideo extends ValueNotifier<Video?> {
  _SelectedVideo(Video? value) : super(value);

  Video? get video => super.value;
}