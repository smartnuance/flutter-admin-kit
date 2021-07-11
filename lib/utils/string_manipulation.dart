import 'dart:math';

String tail(String s, int length) =>
    s.substring(s.length - min(length, s.length));
