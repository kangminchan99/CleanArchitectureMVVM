import 'package:json_annotation/json_annotation.dart';

import 'media_meta_data_model.dart';

part 'media_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class MediaModel {
  String? type;
  String? subtype;
  String? caption;
  String? copyright;
  int? approvedForSyndication;
  @JsonKey(name: 'media-metadata')
  List<MediaDataModel>? mediaMetadata;

  MediaModel({
    this.type,
    this.subtype,
    this.caption,
    this.copyright,
    this.approvedForSyndication,
    this.mediaMetadata,
  });

  factory MediaModel.fromJson(Map<String, dynamic> json) =>
      _$MediaModelFromJson(json);

  toJson() => _$MediaModelToJson(this);

  static List<MediaModel> fromJsonList(List json) {
    return json.map((e) => MediaModel.fromJson(e)).toList();
  }
}
