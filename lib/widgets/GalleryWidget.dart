import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GalleryWidget extends StatefulWidget {
  const GalleryWidget({super.key, required this.images});
final List<String> images;
  @override
  State<GalleryWidget> createState() => _GalleryWidgetState();
}

class _GalleryWidgetState extends State<GalleryWidget> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
  
   );
  }
}