// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LikedServerVideo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LikedServerVideo _$LikedServerVideoFromJson(Map<String, dynamic> json) =>
    LikedServerVideo(
      json['id'] as int,
      json['title'] as String,
      SSrc.fromJson(json['src'] as Map<String, dynamic>),
      SimplePreview.fromJson(json['preview'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LikedServerVideoToJson(LikedServerVideo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'src': instance.src,
      'preview': instance.preview,
    };
