class Language {
  final String name;
  final int speakers;
  final String place;
  Language({this.name, this.speakers, this.place});
  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
      name: json['language'],
      speakers: int.tryParse(json['speakers']),
      place: json['place'],
    );
  }
}
