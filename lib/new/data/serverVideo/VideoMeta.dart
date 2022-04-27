import 'package:json_annotation/json_annotation.dart';

import 'MetaPagination.dart';

part 'VideoMeta.g.dart';

@JsonSerializable()
class VideoMeta {
  final MetaPagination pagination;

  VideoMeta(this.pagination);

  factory VideoMeta.fromJson(Map<String, dynamic> json) => _$VideoMetaFromJson(json);
  Map<String, dynamic> toJson() => _$VideoMetaToJson(this);
}