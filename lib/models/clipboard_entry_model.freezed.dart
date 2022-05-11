// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'clipboard_entry_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ClipboardEntry _$ClipboardEntryFromJson(Map<String, dynamic> json) {
  return _ClipboardEntry.fromJson(json);
}

/// @nodoc
mixin _$ClipboardEntry {
  String get text => throw _privateConstructorUsedError;
  bool? get pinned => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ClipboardEntryCopyWith<ClipboardEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClipboardEntryCopyWith<$Res> {
  factory $ClipboardEntryCopyWith(
          ClipboardEntry value, $Res Function(ClipboardEntry) then) =
      _$ClipboardEntryCopyWithImpl<$Res>;
  $Res call({String text, bool? pinned});
}

/// @nodoc
class _$ClipboardEntryCopyWithImpl<$Res>
    implements $ClipboardEntryCopyWith<$Res> {
  _$ClipboardEntryCopyWithImpl(this._value, this._then);

  final ClipboardEntry _value;
  // ignore: unused_field
  final $Res Function(ClipboardEntry) _then;

  @override
  $Res call({
    Object? text = freezed,
    Object? pinned = freezed,
  }) {
    return _then(_value.copyWith(
      text: text == freezed
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      pinned: pinned == freezed
          ? _value.pinned
          : pinned // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
abstract class _$$_ClipboardEntryCopyWith<$Res>
    implements $ClipboardEntryCopyWith<$Res> {
  factory _$$_ClipboardEntryCopyWith(
          _$_ClipboardEntry value, $Res Function(_$_ClipboardEntry) then) =
      __$$_ClipboardEntryCopyWithImpl<$Res>;
  @override
  $Res call({String text, bool? pinned});
}

/// @nodoc
class __$$_ClipboardEntryCopyWithImpl<$Res>
    extends _$ClipboardEntryCopyWithImpl<$Res>
    implements _$$_ClipboardEntryCopyWith<$Res> {
  __$$_ClipboardEntryCopyWithImpl(
      _$_ClipboardEntry _value, $Res Function(_$_ClipboardEntry) _then)
      : super(_value, (v) => _then(v as _$_ClipboardEntry));

  @override
  _$_ClipboardEntry get _value => super._value as _$_ClipboardEntry;

  @override
  $Res call({
    Object? text = freezed,
    Object? pinned = freezed,
  }) {
    return _then(_$_ClipboardEntry(
      text: text == freezed
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      pinned: pinned == freezed
          ? _value.pinned
          : pinned // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_ClipboardEntry extends _ClipboardEntry with DiagnosticableTreeMixin {
  const _$_ClipboardEntry({required this.text, this.pinned}) : super._();

  factory _$_ClipboardEntry.fromJson(Map<String, dynamic> json) =>
      _$$_ClipboardEntryFromJson(json);

  @override
  final String text;
  @override
  final bool? pinned;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ClipboardEntry(text: $text, pinned: $pinned)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ClipboardEntry'))
      ..add(DiagnosticsProperty('text', text))
      ..add(DiagnosticsProperty('pinned', pinned));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ClipboardEntry &&
            const DeepCollectionEquality().equals(other.text, text) &&
            const DeepCollectionEquality().equals(other.pinned, pinned));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(text),
      const DeepCollectionEquality().hash(pinned));

  @JsonKey(ignore: true)
  @override
  _$$_ClipboardEntryCopyWith<_$_ClipboardEntry> get copyWith =>
      __$$_ClipboardEntryCopyWithImpl<_$_ClipboardEntry>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ClipboardEntryToJson(this);
  }
}

abstract class _ClipboardEntry extends ClipboardEntry {
  const factory _ClipboardEntry(
      {required final String text, final bool? pinned}) = _$_ClipboardEntry;
  const _ClipboardEntry._() : super._();

  factory _ClipboardEntry.fromJson(Map<String, dynamic> json) =
      _$_ClipboardEntry.fromJson;

  @override
  String get text => throw _privateConstructorUsedError;
  @override
  bool? get pinned => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_ClipboardEntryCopyWith<_$_ClipboardEntry> get copyWith =>
      throw _privateConstructorUsedError;
}
