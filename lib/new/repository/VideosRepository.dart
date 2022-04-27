import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:startup_namer/new/data/Video.dart';
import 'package:startup_namer/new/data/serverVideo/VideoData.dart';
import 'package:startup_namer/new/data/serverVideo/likedServerVideo/LikedServerVideo.dart';
import 'package:startup_namer/new/data/serverVideo/likedServerVideo/ListLikedVideos.dart';
import 'package:startup_namer/new/data/serverVideo/serverVideo.dart';

import '../data/GlobalVariables.dart';
import '../data/User.dart';

class VideosRepository {
  final ValueNotifier<User?> userStream;

  var _bearer = "";

  VideosRepository(this.userStream) {
    userStream.addListener(() {
      if (userStream.value == null) {_bearer = "";}
      else {_bearer = userStream.value!.bearer;}
    });
  }

  void like(Video video) async {
    if (_bearer == "") return;

    final likeOrDis = video.isLiked
        ? "dislike"
        : "like";

    await get(
        Uri.parse(server + "/api/videos/$likeOrDis/${video.id}"),
        headers: authHeader(bearer: _bearer)
    );
  }

  Future<List<Video>?> likedVideos() async {
    log("download ...");

    final likedVideosResult = await get(
        Uri.parse(server + "/api/videos/liked"),
        headers: authHeader(bearer: _bearer)
    );

    if (likedVideosResult.statusCode != 200) return null;

    return ListLikedVideos.fromJson(jsonDecode(likedVideosResult.body)).data.map((sv) => Video(
        sv.title,
        "author",
        src: server + sv.src.url,
        previewSrc: server + sv.preview.url,
        id: sv.id,
        isLiked: true)).toList();
  }

  Future<List<Video>?> allVideos() async {
    if (_bearer == "") return null;

    final result = await get(
        Uri.parse("$server/api/videos?populate=*"),
        headers: authHeader(bearer: _bearer)
    );

    return ServerVideo.fromJson(jsonDecode(result.body)).data.map((VideoData video) => Video(
        video.attributes.title,
        "author",
        src: server + video.attributes.src.data.attributes.url,
        previewSrc: server + video.attributes.preview.data.attributes.url,
        isLiked: video.attributes.is_liked,
        id: video.id
    )).toList();
  }
}