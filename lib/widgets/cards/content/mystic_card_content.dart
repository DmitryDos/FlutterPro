import 'package:flutter/material.dart';
import 'package:flutter_pro/data/image_dto.dart';
import 'package:flutter_pro/widgets/interactive/cached_image.dart';

class MysticCardContent extends StatelessWidget {
  final ImageDTO imageData;
  final double height;
  final double threshold;

  const MysticCardContent({
    super.key,
    required this.imageData,
    required this.height,
    this.threshold = 600,
  });

  @override
  Widget build(final BuildContext context) {
    return Stack(
      children: [
        CachedNetworkImageWithFallback(
          url: imageData.url,
          width: height * 4 / 7,
          height: height,
        ),
        Positioned(
          top: 10,
          left: 10,
          child: Opacity(
            opacity: 0.6,
            child: Image.asset(
              'assets/images/paw_print.png',
              width: height / 14,
              height: height / 14,
            ),
          ),
        ),
        Positioned(
          bottom: height > threshold ? 20 : 5,
          left: height > threshold ? 20 : 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                decoration: BoxDecoration(
                  color: Colors.black.withAlpha(150),
                  borderRadius:
                      BorderRadius.circular(height > threshold ? 12 : 6),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    imageData.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: height > threshold ? 24 : 18,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: height > threshold ? 300 : height / 7 * 4 - 16,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                decoration: BoxDecoration(
                  color: Colors.black.withAlpha(150),
                  borderRadius:
                      BorderRadius.circular(height > threshold ? 12 : 6),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      imageData.origin,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: height > threshold ? 14 : 10,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      imageData.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: height > threshold ? 14 : 10,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              if (height > threshold) const SizedBox(height: 10),
              if (height > threshold)
                const Row(
                  children: [
                    Icon(Icons.star, color: Colors.yellow, size: 20),
                    SizedBox(width: 5),
                    Icon(Icons.nights_stay, color: Colors.blue, size: 20),
                    SizedBox(width: 5),
                    Icon(Icons.auto_awesome, color: Colors.purple, size: 20),
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }
}
