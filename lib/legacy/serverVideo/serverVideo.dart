import 'package:json_annotation/json_annotation.dart';

import 'VideoData.dart';

part 'serverVideo.g.dart';

@JsonSerializable()
class ServerVideo {
  final List<VideoData> data;

  ServerVideo(this.data);

  factory ServerVideo.fromJson(Map<String, dynamic> json) => _$ServerVideoFromJson(json);
  Map<String, dynamic> toJson() => _$ServerVideoToJson(this);
}
