import 'package:json_annotation/json_annotation.dart';

import 'VideoPreviewDataAttributes.dart';

part 'VideoPreviewData.g.dart';

@JsonSerializable()
class VideoPreviewData {
  final int id;
  final VideoPreviewDataAttributes attributes;

  VideoPreviewData(this.id, this.attributes);

  factory VideoPreviewData.fromJson(Map<String, dynamic> json) => _$VideoPreviewDataFromJson(json);
  Map<String, dynamic> toJson() => _$VideoPreviewDataToJson(this);
}