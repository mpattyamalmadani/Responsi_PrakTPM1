import 'dart:convert';

DetailModel detailModelFromJson(String str) => DetailModel.fromJson(json.decode(str));

String detailModelToJson(DetailModel data) => json.encode(data.toJson());

class DetailModel {
  Movie? movie;

  DetailModel({
    this.movie,
  });

  DetailModel.fromJson(Map<String, dynamic> json) {
    movie = json['data'] != null ? Movie.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (movie != null) {
      data['data'] = movie!.toJson();
    }
    return data;
  }
}

class Movie {
  String? title;
  String? year;
  String? rated;
  String? released;
  String? runtime;
  String? genre;
  String? director;
  String? writer;
  String? actors;
  String? plot;
  String? language;
  String? country;
  String? awards;
  String? poster;
  List<Rating>? ratings;
  String? metascore;
  String? imdbRating;
  String? imdbVotes;
  String? imdbID;
  String? type;
  String? dvd;
  String? boxOffice;
  String? production;
  String? website;

  Movie({
    this.title,
    this.year,
    this.rated,
    this.released,
    this.runtime,
    this.genre,
    this.director,
    this.writer,
    this.actors,
    this.plot,
    this.language,
    this.country,
    this.awards,
    this.poster,
    this.ratings,
    this.metascore,
    this.imdbRating,
    this.imdbVotes,
    this.imdbID,
    this.type,
    this.dvd,
    this.boxOffice,
    this.production,
    this.website,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['Title'],
      year: json['Year'],
      rated: json['Rated'],
      released: json['Released'],
      runtime: json['Runtime'],
      genre: json['Genre'],
      director: json['Director'],
      writer: json['Writer'],
      actors: json['Actors'],
      plot: json['Plot'],
      language: json['Language'],
      country: json['Country'],
      awards: json['Awards'],
      poster: json['Poster'],
      ratings: List<Rating>.from(json['Ratings'].map((x) => Rating.fromJson(x))),
      metascore: json['Metascore'],
      imdbRating: json['imdbRating'],
      imdbVotes: json['imdbVotes'],
      imdbID: json['imdbID'],
      type: json['Type'],
      dvd: json['DVD'],
      boxOffice: json['BoxOffice'],
      production: json['Production'],
      website: json['Website'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['Title'] = title;
    data['Year'] = year;
    data['Rated'] = rated;
    data['Released'] = released;
    data['Runtime'] = runtime;
    data['Genre'] = genre;
    data['Director'] = director;
    data['Writer'] = writer;
    data['Actors'] = actors;
    data['Plot'] = plot;
    data['Language'] = language;
    data['Country'] = country;
    data['Awards'] = awards;
    data['Poster'] = poster;
    data['Ratings'] = ratings != null ? List<dynamic>.from(ratings!.map((x) => x.toJson())) : null;
    data['Metascore'] = metascore;
    data['imdbRating'] = imdbRating;
    data['imdbVotes'] = imdbVotes;
    data['imdbID'] = imdbID;
    data['Type'] = type;
    data['DVD'] = dvd;
    data['BoxOffice'] = boxOffice;
    data['Production'] = production;
    data['Website'] = website;
    return data;
  }
}

class Rating {
  String? source;
  String? value;

  Rating({
    this.source,
    this.value,
  });

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
    source: json['Source'],
    value: json['Value'],
  );

  Map<String, dynamic> toJson() => {
    'Source': source,
    'Value': value,
  };
}
