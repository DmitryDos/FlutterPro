import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class ShareImageButton extends StatefulWidget {
  final List<Map<String, String>> images;

  const ShareImageButton({super.key, required this.images});

  @override
  ShareImageButtonState createState() => ShareImageButtonState();
}

class ShareImageButtonState extends State<ShareImageButton> {
  bool isDownloading = false;

  Future<void> _downloadAndShareImage(final String url) async {
    if (await Permission.storage.request().isGranted) {
      setState(() {
        isDownloading = true;
      });

      try {
        final directory = await getTemporaryDirectory();
        final filePath =
            '${directory.path}/${Uri.parse(url).pathSegments.last}';

        final dio = Dio();
        await dio.download(url, filePath);

        await Share.shareUri(Uri.parse(filePath));
      } catch (e) {
        _handleError(e);
      } finally {
        setState(() {
          isDownloading = false;
        });
      }
    } else {
      _showSnackBar('Разрешение на запись в хранилище не предоставлено');
    }
  }

  void _handleError(final dynamic error) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка: $error')),
      );
    }
  }

  void _showSnackBar(final String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

  @override
  Widget build(final BuildContext context) {
    return SizedBox(
      width: 30,
      child: InkWell(
        onTap: () async {
          if (widget.images.isNotEmpty) {
            final String url = widget.images.first['url']!;
            await _downloadAndShareImage(url);
          }
        },
        child: Icon(
          isDownloading ? Icons.downloading : Icons.share,
          color: Colors.grey,
          size: 30,
        ),
      ),
    );
  }
}
