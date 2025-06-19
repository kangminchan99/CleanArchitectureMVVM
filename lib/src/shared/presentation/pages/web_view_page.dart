import 'package:flutter/material.dart';

class WebViewPage extends StatefulWidget {
  final String link;
  const WebViewPage({super.key, required this.link});

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
