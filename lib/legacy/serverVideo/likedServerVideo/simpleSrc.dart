import 'package:json_annotation/json_annotation.dart';

part 'simpleSrc.g.dart';

@JsonSerializable()
class SSrc {
    final String url;

    SSrc(this.url);

    factory SSrc.fromJson(Map<String, dynamic> json) => _$SSrcFromJson(json);
    Map<String, dynamic> toJson() => _$SSrcToJson(this);
}