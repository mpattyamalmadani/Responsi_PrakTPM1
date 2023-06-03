import 'dart:convert';

HomeDataModel homeDataModelFromJson(String str) => HomeDataModel.fromJson(json.decode(str));

String homeDataModelToJson(HomeDataModel data) => json.encode(data.toJson());

class HomeDataModel {
  late List<Movie> movies;

  HomeDataModel({
    required this.movies,
  });

  factory HomeDataModel.fromJson(Map<String, dynamic> json) => HomeDataModel(
    movies: List<Movie>.from(json["Search"].map((x) => Movie.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "movies": List<dynamic>.from(movies.map((x) => x.toJson())),
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

class Images {
  Poster? poster;

  Images({this.poster});

  Images.fromJson(Map<String, dynamic> json) {
    poster = json['Poster'] != null ? Poster.fromJson(json['Poster']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.poster != null) {
      data['Poster'] = this.poster!.toJson();
    }
    return data;
  }
}

class Poster {
  String? jpg;

  Poster({this.jpg});

  Poster.fromJson(Map<String, dynamic> json) {
    jpg = json['jpg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jpg'] = this.jpg;
    return data;
  }
}

