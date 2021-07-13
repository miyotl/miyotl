class Lesson {
  final String language;
  final String author;
  final Map<String, String> words;

  Lesson(this.language, this.author, this.words);

  factory Lesson.fromJson(Map<String, dynamic> json) {
    Map<String, String> words;
    json.forEach((key, value) {
      if (key != 'Lanugage' || key != 'ID') {
        words[key] = value;
      }
    });
    return Lesson(json['Language'], json['ID'], words);
  }

  Map<String, dynamic> toJson() =>
      {'Language': language, 'Author': author, 'Words': words};
}
