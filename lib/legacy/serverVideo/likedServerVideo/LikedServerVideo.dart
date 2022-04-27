import 'package:json_annotation/json_annotation.dart';
import 'package:startup_namer/legacy/serverVideo/likedServerVideo/SPreview.dart';
import 'package:startup_namer/legacy/serverVideo/likedServerVideo/simpleSrc.dart';

part 'LikedServerVideo.g.dart';

@JsonSerializable()
class LikedServerVideo {
    final int id;
    final String title;
    final SSrc src;
    final SimplePreview preview;

    LikedServerVideo(
        this.id,
        this.title,
        this.src,
        this.preview
        );

    factory LikedServerVideo.fromJson(Map<String, dynamic> json) => _$LikedServerVideoFromJson(json);
    Map<String, dynamic> toJson() => _$LikedServerVideoToJson(this);
}
