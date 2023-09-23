import 'package:test_vedio/constants/string.dart';


class MoviesData {
  late final int page;
  late final List<MovieModel> results;
  late final int totalPages;
  late final int totalResults;

  MoviesData.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    results =
        List.from(json['results']).map((e) => MovieModel.fromJson(e)).toList();
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }

  static fromJsom(MoviesData movie) {}
}

class MovieModel {
  late final bool adult;
  late final String image;
  late final List<int> genreIds;
  late final int id;
  late final String originalLanguage;
  late final String overview;
  late final double popularity;
  late final String posterPath;
  late final String releaseDate;
  late final String title;
  late final bool video;
  late final double? voteAverage;
  late final int voteCount;

  MovieModel.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    image = '$imageBaseUrl${json['backdrop_path']}';
    genreIds = List.castFrom<dynamic, int>(json['genre_ids']);
    id = json['id'] ?? 0;
    originalLanguage = json['original_language'];
    overview = json['overview'] ?? '';
    popularity = double.parse((json['popularity']??0).toString());
    posterPath = "$imageBaseUrl${json['poster_path']}";
    releaseDate = json['release_date'];
    title = json['title'] ?? "not found title";
    video = json['video'] ?? false;
    voteAverage = double.parse((json['vote_average']??0).toString());

    voteCount = json['vote_count'] ?? 0;
  }
}
