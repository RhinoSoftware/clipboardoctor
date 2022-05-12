import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'clipboard_entry_model.freezed.dart';
part 'clipboard_entry_model.g.dart';

@freezed
class ClipboardItem with _$ClipboardItem {
  const ClipboardItem._();

  // ignore: invalid_annotation_target
  @JsonSerializable(explicitToJson: true)
  const factory ClipboardItem({
    required String text,
    //bool with default value
    @Default(false) bool pinned,
  }) = _ClipboardEntry;

  factory ClipboardItem.fromJson(Map<String, dynamic> json) => _$ClipboardItemFromJson(json);

  String toJsonString() => jsonEncode(toJson());

  //return ClipboardItem from jsonString
  static ClipboardItem fromJsonString(String jsonString) => ClipboardItem.fromJson(jsonDecode(jsonString));
}
