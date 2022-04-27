import 'package:json_annotation/json_annotation.dart';

import 'VideoDataAttributes.dart';

part 'VideoData.g.dart';

@JsonSerializable()
class VideoData {
  final int id;
  final VideoDataAttributes attributes;

  VideoData(this.id, this.attributes);

  factory VideoData.fromJson(Map<String, dynamic> json) => _$VideoDataFromJson(json);
  Map<String, dynamic> toJson() => _$VideoDataToJson(this);
}