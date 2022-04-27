// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'VideoPreviewData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoPreviewData _$VideoPreviewDataFromJson(Map<String, dynamic> json) =>
    VideoPreviewData(
      json['id'] as int,
      VideoPreviewDataAttributes.fromJson(
          json['attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VideoPreviewDataToJson(VideoPreviewData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'attributes': instance.attributes,
    };
