// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MediaItem _$MediaItemFromJson(Map<String, dynamic> json) => MediaItem(
      json['id'] as String,
      json['description'] as String?,
      json['productUrl'] as String?,
      json['baseUrl'] as String?,
      json['mimeType'] as String?,
      json['filename'] as String?,
    );

Map<String, dynamic> _$MediaItemToJson(MediaItem instance) => <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'productUrl': instance.productUrl,
      'baseUrl': instance.baseUrl,
      'mimeType': instance.mimeType,
      'filename': instance.filename,
    };
