import 'package:json_annotation/json_annotation.dart';

part 'VideoSrcDataAttributes.g.dart';

@JsonSerializable()
class VideoSrcDataAttributes {
  final String url;

  VideoSrcDataAttributes(this.url);

  factory VideoSrcDataAttributes.fromJson(Map<String, dynamic> json) => _$VideoSrcDataAttributesFromJson(json);
  Map<String, dynamic> toJson() => _$VideoSrcDataAttributesToJson(this);
}