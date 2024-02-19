class Language {
  final String name;
  final int speakers;
  final String place;
  Language({required this.name, required this.speakers, required this.place});
  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
      name: json['language'],
      speakers: json['speakers'],
      place: json['place'],
    );
  }
}
