// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'serverVideo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServerVideo _$ServerVideoFromJson(Map<String, dynamic> json) => ServerVideo(
      (json['data'] as List<dynamic>)
          .map((e) => VideoData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ServerVideoToJson(ServerVideo instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
