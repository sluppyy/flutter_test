// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'VideoDataAttributes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoDataAttributes _$VideoDataAttributesFromJson(Map<String, dynamic> json) =>
    VideoDataAttributes(
      json['createdAt'] as String,
      json['updatedAt'] as String,
      json['publishedAt'] as String,
      json['title'] as String,
      VideoSrc.fromJson(json['src'] as Map<String, dynamic>),
      VideoPreview.fromJson(json['preview'] as Map<String, dynamic>),
      json['is_liked'] as bool,
    );

Map<String, dynamic> _$VideoDataAttributesToJson(
        VideoDataAttributes instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'publishedAt': instance.publishedAt,
      'title': instance.title,
      'src': instance.src,
      'preview': instance.preview,
      'is_liked': instance.is_liked,
    };
