// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'VideoData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoData _$VideoDataFromJson(Map<String, dynamic> json) => VideoData(
      json['id'] as int,
      VideoDataAttributes.fromJson(json['attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VideoDataToJson(VideoData instance) => <String, dynamic>{
      'id': instance.id,
      'attributes': instance.attributes,
    };
