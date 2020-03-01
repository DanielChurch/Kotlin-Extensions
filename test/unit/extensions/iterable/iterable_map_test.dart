@TestOn('vm')

import 'package:test/test.dart';

import 'package:kotlin_extensions/iterable.dart';
import 'package:kotlin_extensions/object.dart';

import '../../util/expect_extensions.dart';

void main() {
  group('for an Iterable<Map>', () {
    group('toMap', () {
      test('handles an empty iterable', () {
        <MapEntry>[].toMap().expectEquals({});
      });

      test('converts an iterable of maps to a single map', () {
        [1.to(2), 3.to(4)].toMap().expectEquals({1: 2, 3: 4});

        [1, 2]
            .map((i) => 'test$i'.to(i))
            .toMap()
            .expectEquals({'test1': 1, 'test2': 2});
      });

      test('provides the last value for a given key', () {
        ['a'.to(1), 'a'.to(2), 'b'.to(3), 'b'.to(4)]
            .toMap()
            .expectEquals({'a': 2, 'b': 4});
      });
    });
  });
}
