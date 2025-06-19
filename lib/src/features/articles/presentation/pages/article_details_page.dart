import 'package:cleanarchitecture/src/features/articles/domain/models/article_model.dart';
import 'package:flutter/material.dart';

class ArticleDetailsPage extends StatefulWidget {
  final ArticleModel model;
  const ArticleDetailsPage({super.key, required this.model});

  @override
  State<ArticleDetailsPage> createState() => _ArticleDetailsPageState();
}

class _ArticleDetailsPageState extends State<ArticleDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
