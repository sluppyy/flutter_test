import 'package:json_annotation/json_annotation.dart';

part 'VideoPreviewDataAttributes.g.dart';

@JsonSerializable()
class VideoPreviewDataAttributes {
  final String url;

  VideoPreviewDataAttributes(this.url);

  factory VideoPreviewDataAttributes.fromJson(Map<String, dynamic> json) => _$VideoPreviewDataAttributesFromJson(json);
  Map<String, dynamic> toJson() => _$VideoPreviewDataAttributesToJson(this);
}