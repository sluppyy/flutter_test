import 'package:json_annotation/json_annotation.dart';

part 'SPreview.g.dart';

@JsonSerializable()
class SimplePreview {
    final String url;

    SimplePreview(
        this.url
        );

    factory SimplePreview.fromJson(Map<String, dynamic> json) => _$SimplePreviewFromJson(json);
    Map<String, dynamic> toJson() => _$SimplePreviewToJson(this);
}