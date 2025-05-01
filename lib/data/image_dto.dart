class ImageDTO {
  final String url;
  final String name;
  final String title;
  final String origin;
  final String description;

  ImageDTO({
    this.url = '',
    this.name = 'Not Set',
    this.title = 'Not Set',
    this.origin = 'Not Set',
    this.description = 'Not Set',
  });

  Map<String, String> toMap() {
    return {
      'url': url,
      'name': name,
      'title': title,
      'origin': origin,
      'description': description,
    };
  }
}

class UniqueImageDTO extends ImageDTO {
  final DateTime date;

  UniqueImageDTO({
    required this.date,
    super.url,
    super.name,
    super.title,
    super.origin,
    super.description,
  });

  @override
  Map<String, String> toMap() {
    return {
      ...super.toMap(),
      'date': date.toIso8601String(),
    };
  }
}
