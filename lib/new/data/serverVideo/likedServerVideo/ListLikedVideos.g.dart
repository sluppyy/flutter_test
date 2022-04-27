// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ListLikedVideos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListLikedVideos _$ListLikedVideosFromJson(Map<String, dynamic> json) =>
    ListLikedVideos(
      (json['data'] as List<dynamic>)
          .map((e) => LikedServerVideo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListLikedVideosToJson(ListLikedVideos instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
