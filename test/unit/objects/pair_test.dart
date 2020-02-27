@TestOn('vm')

import 'package:test/test.dart';

import 'package:kotlin_extensions/object.dart';
import 'package:kotlin_extensions/pair.dart';

void main() {
  group('Pair', () {
    test('first and second return the correct values', () {
      Pair(5, 'Hello').let((pair) {
        expect(pair.first, 5);
        expect(pair.second, 'Hello');
      });

      Pair(false, 42.5).let((pair) {
        expect(pair.first, false);
        expect(pair.second, 42.5);
      });
    });

    test('stores the correct type', () {
      Pair(5, 'Hello').let((pair) {
        expect(pair.first, isA<int>());
        expect(pair.second, isA<String>());
      });

      Pair(false, 42.5).let((pair) {
        expect(pair.first, isA<bool>());
        expect(pair.second, isA<num>());
      });
    });

    test('toString displays the values', () {
      expect('${Pair(false, 'Hello')}', 'Pair(false, Hello)');
      expect('${Pair('Hello', 'World')}', 'Pair(Hello, World)');
      expect('${Pair(5, '5.4')}', 'Pair(5, 5.4)');
    });
  });
}
