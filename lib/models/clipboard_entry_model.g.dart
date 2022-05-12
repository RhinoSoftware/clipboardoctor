// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'clipboard_entry_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ClipboardEntry _$$_ClipboardEntryFromJson(Map<String, dynamic> json) =>
    _$_ClipboardEntry(
      text: json['text'] as String,
      pinned: json['pinned'] as bool? ?? false,
    );

Map<String, dynamic> _$$_ClipboardEntryToJson(_$_ClipboardEntry instance) =>
    <String, dynamic>{
      'text': instance.text,
      'pinned': instance.pinned,
    };
