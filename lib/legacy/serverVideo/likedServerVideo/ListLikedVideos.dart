import 'package:json_annotation/json_annotation.dart';
import 'package:startup_namer/legacy/serverVideo/likedServerVideo/LikedServerVideo.dart';

part 'ListLikedVideos.g.dart';

@JsonSerializable()
class ListLikedVideos {
    final List<LikedServerVideo> data;

    ListLikedVideos(this.data);

    factory ListLikedVideos.fromJson(Map<String, dynamic> json) => _$ListLikedVideosFromJson(json);
    Map<String, dynamic> toJson() => _$ListLikedVideosToJson(this);
}