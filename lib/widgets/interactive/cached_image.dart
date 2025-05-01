import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pro/utils/utils.dart';
import 'package:flutter_pro/widgets/pulsular_loader.dart';

class CachedNetworkImageWithFallback extends StatelessWidget {
  final String url;
  final double width;
  final double height;
  final BoxFit fit;

  const CachedNetworkImageWithFallback({
    super.key,
    required this.url,
    required this.width,
    required this.height,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(final BuildContext context) {
    if (isLocalFile(url)) {
      return _buildLocalImage();
    } else {
      return _buildNetworkImage();
    }
  }

  Widget _buildLocalImage() {
    return Image.file(
      File(url),
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (final ctx, final error, final stack) =>
          _buildErrorWidget(),
    );
  }

  Widget _buildNetworkImage() {
    return CachedNetworkImage(
      imageUrl: url,
      width: width,
      height: height,
      fit: fit,
      placeholder: (final context, final url) => const Center(
        child: PulsatingCircle(color: Colors.pink),
      ),
      errorWidget: (final context, final url, final error) =>
          _buildErrorWidget(),
    );
  }

  Widget _buildErrorWidget() {
    return Container(
      width: width,
      height: height,
      color: Colors.grey[200],
      child: const Center(child: Icon(Icons.error, color: Colors.red)),
    );
  }
}
