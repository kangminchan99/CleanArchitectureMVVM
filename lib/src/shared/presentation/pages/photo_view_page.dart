import 'package:flutter/material.dart';

class PhotoViewPage extends StatefulWidget {
  final String path;
  final bool fromNet;
  const PhotoViewPage({super.key, required this.path, required this.fromNet});

  @override
  State<PhotoViewPage> createState() => _PhotoViewPageState();
}

class _PhotoViewPageState extends State<PhotoViewPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
