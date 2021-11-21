// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MediaItem _$MediaItemFromJson(Map<String, dynamic> json) {
  return MediaItem(
    json['id'] as String,
    json['description'] as String?,
    json['productUrl'] as String?,
    json['baseUrl'] as String?,
  );
}

Map<String, dynamic> _$MediaItemToJson(MediaItem instance) {
  final val = <String, dynamic>{
    'id': instance.id,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('description', instance.description);
  writeNotNull('productUrl', instance.productUrl);
  writeNotNull('baseUrl', instance.baseUrl);
  return val;
}
