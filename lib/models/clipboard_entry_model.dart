import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'clipboard_entry_model.freezed.dart';
part 'clipboard_entry_model.g.dart';

@freezed
class ClipboardEntry with _$ClipboardEntry {
  const ClipboardEntry._();

  // ignore: invalid_annotation_target
  @JsonSerializable(explicitToJson: true)
  const factory ClipboardEntry({
    required String text,
     bool? pinned,
  }) = _ClipboardEntry;

  factory ClipboardEntry.fromJson(Map<String, dynamic> json) =>
      _$ClipboardEntryFromJson(json);

      String toJsonString() => jsonEncode(toJson());

      //return ClipboardEntry from jsonString
      static ClipboardEntry fromJsonString(String jsonString) =>
          ClipboardEntry.fromJson(jsonDecode(jsonString));
}