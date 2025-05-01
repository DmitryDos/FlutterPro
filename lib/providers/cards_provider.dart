import 'package:flutter/cupertino.dart';
import 'package:flutter_pro/data/image_dto.dart';
import 'package:flutter_pro/providers/user_provider.dart';
import 'package:flutter_pro/services/cached_images_service.dart';

class LikedCatsProvider extends ChangeNotifier {
  CachedImagesService? _service;
  void initService(final CachedImagesService service) {
    _service = service;
    loadCats();
  }

  List<UniqueImageDTO> _likedCats = [];

  Future<void> loadCats() async {
    _likedCats = await _service!.getImages();
    notifyListeners();
  }

  List<UniqueImageDTO> filter(final String name) {
    return _likedCats
        .where((final image) =>
            image.name.toLowerCase().contains(name.toLowerCase()))
        .toList();
  }

  Future<void> addCat(final ImageDTO image) async {
    _service!.saveImage(image, UserData.instance.darkTheme);
  }

  Future<void> removeCat(final UniqueImageDTO image) async {
    _service!.removeUImage(image);
    _likedCats.removeWhere(
        (final img) => img.url == image.url && img.date == image.date);
    notifyListeners();
  }

  Future<void> clear() async {
    _likedCats.clear();
    _service!.clear();
    notifyListeners();
  }
}
