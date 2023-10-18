class Movie {
  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  String? mediaType;
  String? originalLanguage;
  String? originalName;
  String? overview;
  String? posterPath;
  DateTime? releaseDate;
  String? name;
  double? voteAverage;
  int? voteCount;
  List<String>? originCountry;

  Movie({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.mediaType,
    this.originalLanguage,
    this.originalName,
    this.overview,
    this.posterPath,
    this.releaseDate,
    this.name,
    this.voteAverage,
    this.voteCount,
    this.originCountry,
  });

  factory Movie.fromJson(Map<dynamic, dynamic> json) {
    return Movie(
      adult: json['adult'] ?? false,
      backdropPath: json['backdrop_path'] ?? '',
      genreIds: List<int>.from(json['genre_ids']),
      mediaType: json['media_type'] ?? '',
      originalLanguage: json['original_language'] ?? '',
      originalName: json['original_name'] ?? '',
      overview: json['overview'] ?? '',
      posterPath: json['poster_path'] ?? '',
      releaseDate: DateTime.parse(json['release_date']),
      name: json['name'] ?? '',
      voteAverage: json['vote_average'] ?? 0.0,
      voteCount: json['vote_count'] ?? 0,
      originCountry: List<String>.from(json['origin_country']),
    );
  }
}
