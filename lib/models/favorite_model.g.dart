
part of 'favorite_model.dart';

class FavoriteAdapter extends TypeAdapter<Favorite> {
  @override
  final int typeId = 1; // Update with a unique identifier

  @override
  Favorite read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Favorite(
      imdbID: fields[0] as String?, // Change malId to imdbID
      title: fields[1] as String?,
      url: fields[2] as String?,
      imageUrl: fields[3] as String?,
      synopsis: fields[4] as String?,
      imdbRating: fields[5] as double?, // Change score to imdbRating
    );
  }

  @override
  void write(BinaryWriter writer, Favorite obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.imdbID) // Change malId to imdbID
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.url)
      ..writeByte(3)
      ..write(obj.imageUrl)
      ..writeByte(4)
      ..write(obj.synopsis)
      ..writeByte(5)
      ..write(obj.imdbRating); // Change score to imdbRating
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is FavoriteAdapter &&
              runtimeType == other.runtimeType &&
              typeId == other.typeId;
}
