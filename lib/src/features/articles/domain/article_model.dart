import 'package:json_annotation/json_annotation.dart';

part 'article_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ArticleModel {
  String? uri;
  String? url;
  int? id;
  int? assetId;
  String? source;
  String? publishedDate;
  String? updated;
  String? section;
  String? subsection;
  @JsonKey(name: 'nytdsection')
  String? nytdSection;
  String? adxKeywords;
  String? column;
  String? byline;
  String? type;
  String? title;
  String? abstract;
  List<String>? desFacet;
  List<String>? orgFacet;
  List<String>? perFacet;
  List<String>? geoFacet;
  List<MediaModle?> media;
  int? etaId;

  ArticleModel({
    this.uri,
    this.url,
    this.id,
    this.assetId,
    this.source,
    this.publishedDate,
    this.updated,
    this.section,
    this.subsection,
    this.nytdSection,
    this.adxKeywords,
    this.column,
    this.byline,
    this.type,
    this.title,
    this.abstract,
    this.desFacet,
    this.orgFacet,
    this.perFacet,
    this.geoFacet,
    required this.media,
    this.etaId,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) =>
      _$ArticleModelFromJson(json);

  toJson() => _$ArticleModelToJson(this);

  static List<ArticleModel> fromJsonList(List? json) {
    return json?.map((e) => ArticleModel.fromJson(e)).toList() ?? [];
  }
}
