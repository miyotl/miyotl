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
    this.titleOriginal,
    this.titleTranslated,
    this.linkOriginal,
    this.linkTranslated,
    this.sourceId,
    this.imageUrl,
    this.category,
    this.tags,
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