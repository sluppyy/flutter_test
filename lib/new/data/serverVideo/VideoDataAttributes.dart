import 'package:json_annotation/json_annotation.dart';

import 'VideoPreview.dart';
import 'VideoSrc.dart';

part 'VideoDataAttributes.g.dart';

@JsonSerializable()
class VideoDataAttributes {
  final String        createdAt;
  final String        updatedAt;
  final String        publishedAt;
  final String        title;
  final VideoSrc      src;
  final VideoPreview  preview;
  final bool          is_liked;

  VideoDataAttributes(
      this.createdAt,
      this.updatedAt,
      this.publishedAt,
      this.title,
      this.src,
      this.preview,
      this.is_liked
      );

  factory VideoDataAttributes.fromJson(Map<String, dynamic> json) => _$VideoDataAttributesFromJson(json);
  Map<String, dynamic> toJson() => _$VideoDataAttributesToJson(this);
}