import 'package:test/test.dart';

import 'package:kotlin_extensions/object.dart';
import 'package:kotlin_extensions/pair.dart';

import '../util/expect_extensions.dart';

void main() {
  group('Pair', () {
    test('first and second return the correct values', () {
      Pair(5, 'Hello').let((pair) {
        pair.first.expectEquals(5);
        pair.second.expectEquals('Hello');
      });

      Pair(false, 42.5).let((pair) {
        pair.first.expectEquals(false);
        pair.second.expectEquals(42.5);
      });
    });

    test('toString displays the values', () {
      Pair(false, 'Hello').toString().expectEquals('Pair(false, Hello)');
      Pair('Hello', 'World').toString().expectEquals('Pair(Hello, World)');
      Pair(5, '5.4').toString().expectEquals('Pair(5, 5.4)');
    });
  });
}
