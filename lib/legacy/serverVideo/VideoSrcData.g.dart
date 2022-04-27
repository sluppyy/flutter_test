// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'VideoSrcData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoSrcData _$VideoSrcDataFromJson(Map<String, dynamic> json) => VideoSrcData(
      json['id'] as int,
      VideoSrcDataAttributes.fromJson(
          json['attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VideoSrcDataToJson(VideoSrcData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'attributes': instance.attributes,
    };
