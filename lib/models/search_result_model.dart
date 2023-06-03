import 'dart:convert';

SearchResultModel searchResultModelFromJson(String str) => SearchResultModel.fromJson(json.decode(str));

String searchResultModelToJson(SearchResultModel data) => json.encode(data.toJson());

class SearchResultModel {
  List<Movie> movies;

  SearchResultModel({
    required this.movies,
  });

  factory SearchResultModel.fromJson(Map<String, dynamic> json) => SearchResultModel(
    movies: List<Movie>.from(json["Search"].map((x) => Movie.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Search": List<dynamic>.from(movies.map((x) => x.toJson())),
  };
}

class Movie {
  String? title;
  String? year;
  String? imdbID;
  String? type;
  String? poster;

  Movie({
    this.title,
    this.year,
    this.imdbID,
    this.type,
    this.poster,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
    title: json['Title'],
    year: json['Year'],
    imdbID: json['imdbID'],
    type: json['Type'],
    poster: json['Poster'],
  );

  Map<String, dynamic> toJson() => {
    "Title": title,
    "Year": year,
    "imdbID": imdbID,
    "Type": type,
    "Poster": poster,
  };
}
