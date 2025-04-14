import 'package:flutter/cupertino.dart';

import '../data/image_dto.dart';

class LikedCatsProvider extends ChangeNotifier {
  LikedCatsProvider._privateConstructor();

  static final LikedCatsProvider _instance =
      LikedCatsProvider._privateConstructor();

  static LikedCatsProvider get instance => _instance;

  final List<UniqueImageDTO> _likedCats = [];
  var count = 0;

  List<UniqueImageDTO> filter(final String name) {
    return _likedCats.reversed
        .where((final image) => image.name
        .toLowerCase()
        .contains(name.toLowerCase()))
        .toList();

  }

  void addCat(final ImageDTO image) {
    final uImage = UniqueImageDTO(
      id: count++,
      date: DateTime.now(),
      url: image.url,
      title: image.title,
      description: image.description,
      name: image.name,
    );
    _likedCats.add(uImage);
    notifyListeners();
  }

  void removeCat(final int id) {
    _likedCats.removeWhere((final image) => image.id == id);
    notifyListeners();
  }
}
