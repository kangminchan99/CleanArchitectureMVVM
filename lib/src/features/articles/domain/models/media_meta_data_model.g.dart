// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_meta_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MediaDataModel _$MediaDataModelFromJson(Map<String, dynamic> json) =>
    MediaDataModel(
      url: json['url'] as String?,
      format: json['format'] as String?,
      height: (json['height'] as num?)?.toInt(),
      width: (json['width'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MediaDataModelToJson(MediaDataModel instance) =>
    <String, dynamic>{
      'url': instance.url,
      'format': instance.format,
      'height': instance.height,
      'width': instance.width,
    };
