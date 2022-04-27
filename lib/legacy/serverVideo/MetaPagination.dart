import 'package:json_annotation/json_annotation.dart';

part 'MetaPagination.g.dart';

@JsonSerializable()
class MetaPagination {
  final int page;
  final int pageSize;
  final int pageCount;
  final int total;

  MetaPagination(
      this.page,
      this.pageSize,
      this.pageCount,
      this.total);

  factory MetaPagination.fromJson(Map<String, dynamic> json) => _$MetaPaginationFromJson(json);
  Map<String, dynamic> toJson() => _$MetaPaginationToJson(this);
}