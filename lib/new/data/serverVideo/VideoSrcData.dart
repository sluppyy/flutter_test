import 'package:json_annotation/json_annotation.dart';

import 'VideoSrcDataAttributes.dart';

part 'VideoSrcData.g.dart';

@JsonSerializable()
class VideoSrcData {
  final int id;
  final VideoSrcDataAttributes attributes;

  VideoSrcData(this.id, this.attributes);

  factory VideoSrcData.fromJson(Map<String, dynamic> json) => _$VideoSrcDataFromJson(json);
  Map<String, dynamic> toJson() => _$VideoSrcDataToJson(this);
}