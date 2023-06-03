import 'package:hive/hive.dart';
part 'favorite_model.g.dart';

@HiveType(typeId: 0)
class Favorite extends HiveObject {
  @HiveField(0)
  String? imdbID;

  @HiveField(1)
  String? title;

  @HiveField(2)
  String? url;

  @HiveField(3)
  String? imageUrl;

  @HiveField(4)
  String? synopsis;

  @HiveField(5)
  double? imdbRating;

  Favorite({
    required this.imdbID,
    required this.title,
    required this.url,
    required this.imageUrl,
    required this.synopsis,
    required this.imdbRating,
  });
}