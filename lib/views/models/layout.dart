import 'package:freezed_annotation/freezed_annotation.dart';

part 'layout.freezed.dart';

final RegExp linkRegExp = RegExp(
  r'^\[(.*?)\]\((.*?)\)$',
  caseSensitive: false,
  multiLine: false,
);

@freezed
class Layout with _$Layout {
  factory Layout.modelList({
    required List<Combo> fieldCombos,
  }) = _ModelListLayout;

  const Layout._();

  factory Layout.fromMap(Map<String, dynamic>? data) {
    if (data == null) {
      throw StateError('missing data for Layout');
    }
    final fieldCombos = data['fieldCombos'] as List<dynamic>?;
    if (fieldCombos == null) {
      throw StateError('missing fieldCombos for Layout');
    }
    return _ModelListLayout(
      fieldCombos: List.castFrom<dynamic, String>(fieldCombos)
          .map((s) => Combo.fromString(s))
          .toList(growable: false),
    );
  }
}

@freezed
class Combo with _$Combo {
  factory Combo({
    required List<Line> lines,
  }) = _Combo;

  const Combo._();

  factory Combo.fromString(String data) {
    return Combo(
      lines: data
          .split('\n')
          .map((line) => Line.fromString(line))
          .toList(growable: false),
    );
  }
}

@freezed
class Line with _$Line {
  factory Line({
    required List<Token> tokens,
  }) = _Line;

  const Line._();

  factory Line.fromString(String line) {
    final match = linkRegExp.firstMatch(line);
    if (match != null && match.group(2) != null) {
      return Line(tokens: [
        Token.link(
            labelFieldID: match.group(1) ?? '', hrefFieldID: match.group(2)!)
      ]);
    } else {
      return Line(tokens: [Token.string(fieldID: line)]);
    }
  }
}

@freezed
class Token with _$Token {
  factory Token.string({
    required String fieldID,
  }) = _StringToken;

  factory Token.link({
    required String labelFieldID,
    required String hrefFieldID,
  }) = _URLToken;

  const Token._();
}
