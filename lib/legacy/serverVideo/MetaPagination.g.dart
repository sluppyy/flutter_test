// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MetaPagination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MetaPagination _$MetaPaginationFromJson(Map<String, dynamic> json) =>
    MetaPagination(
      json['page'] as int,
      json['pageSize'] as int,
      json['pageCount'] as int,
      json['total'] as int,
    );

Map<String, dynamic> _$MetaPaginationToJson(MetaPagination instance) =>
    <String, dynamic>{
      'page': instance.page,
      'pageSize': instance.pageSize,
      'pageCount': instance.pageCount,
      'total': instance.total,
    };
