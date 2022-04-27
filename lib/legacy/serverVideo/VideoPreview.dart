import 'package:json_annotation/json_annotation.dart';

import 'VideoPreviewData.dart';

part 'VideoPreview.g.dart';

@JsonSerializable()
class VideoPreview {
  final VideoPreviewData data;

  VideoPreview(this.data);

  factory VideoPreview.fromJson(Map<String, dynamic> json) => _$VideoPreviewFromJson(json);
  Map<String, dynamic> toJson() => _$VideoPreviewToJson(this);
}