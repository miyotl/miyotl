class CultureEntry {
  final String titleOriginal;
  final String titleTranslated;
  final String linkOriginal;
  final String linkTranslated;
  final String sourceId;
  final String imageUrl;
  final String category;
  final List<String> tags;

  const CultureEntry({
    required this.titleOriginal,
    required this.titleTranslated,
    required this.linkOriginal,
    required this.linkTranslated,
    required this.sourceId,
    required this.imageUrl,
    required this.category,
    required this.tags,
  });

  factory CultureEntry.fromJson(Map<String, dynamic> json) {
    return CultureEntry(
      titleOriginal: json['title_original'],
      titleTranslated: json['title_translated'],
      linkOriginal: json['link_original'],
      linkTranslated: json['link_translated'],
      sourceId: json['source'],
      imageUrl: json['image'],
      category: json['category'],
      tags: json['tags']?.split(', '),
    );
  }
}