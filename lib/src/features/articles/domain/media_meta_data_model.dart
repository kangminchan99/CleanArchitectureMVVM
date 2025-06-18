import 'package:json_annotation/json_annotation.dart';

part 'media_meta_data_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class MediaDataModel {
  String? url;
  String? format;
  int? height;
  int? width;

  MediaDataModel({this.url, this.format, this.height, this.width});

  factory MediaDataModel.fromJson(Map<String, dynamic> json) =>
      _$MediaDataModelFromJson(json);

  toJson() => _$MediaDataModelToJson(this);

  static List<MediaDataModel> fromJsonList(List json) {
    return json.map((e) => MediaDataModel.fromJson(e)).toList();
  }
}
