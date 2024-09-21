// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_server_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NewsServerModelAdapter extends TypeAdapter<NewsServerModel> {
  @override
  final int typeId = 1;

  @override
  NewsServerModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NewsServerModel(
      id: fields[5] as String,
      title: fields[0] as String,
      description: fields[1] as String,
      imageUrl: fields[2] as String,
      date: fields[3] as String,
      url: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, NewsServerModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.imageUrl)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.url)
      ..writeByte(5)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NewsServerModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
