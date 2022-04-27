import 'package:json_annotation/json_annotation.dart';

import 'VideoSrcData.dart';

part 'VideoSrc.g.dart';

@JsonSerializable()
class VideoSrc {
  final VideoSrcData data;

  VideoSrc(this.data);

  factory VideoSrc.fromJson(Map<String, dynamic> json) => _$VideoSrcFromJson(json);
  Map<String, dynamic> toJson() => _$VideoSrcToJson(this);
}