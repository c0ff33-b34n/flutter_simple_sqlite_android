class Film {
  late final int id;
  late final String title;
  late final String director;
  late final int releaseYear;

  Film({
    required this.id,
    required this.title,
    required this.director,
    required this.releaseYear,
  });

  Film.fromMap(Map<String, dynamic> result)
      : id = result['id'],
        title = result['title'],
        director = result['director'],
        releaseYear = result['releaseYear'];

  Map<String, Object> toMap() {
    return {
      'id': id,
      'title': title,
      'director': director,
      'releaseYear': releaseYear,
    };
  }
}
