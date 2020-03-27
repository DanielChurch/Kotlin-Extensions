import 'package:kotlin_extensions/function.dart';
import 'package:kotlin_extensions/map.dart';
import 'package:kotlin_extensions/list.dart';

import 'package:test/test.dart';

import '../../util/expect_extensions.dart';

void main() {
  group('on Map<T extends Comparable>', () {
    group('toSortedMap', () {
      test('returns a sorted version of the map', () {
        <int, String>{5: 'Yo', 2: 'Hello', 3: 'Hi'}.toSortedMap()
          ..keys.expectEquals([2, 3, 5])
          ..values.expectEquals(['Hello', 'Hi', 'Yo']);

        <String, int>{'A': 1, 'BB': 2, 'DDD': 3, 'CCC': 3, 'EEE': 3}
            .toSortedMap(
          compareBy<String>((s) => s.length).thenBy((s) => s),
        )..keys.expectEquals(['A', 'BB', 'CCC', 'DDD', 'EEE']);

        <int, String>{5: 'Yo', 2: 'Hello', 3: 'Hi'}
            .toSortedMap(compareBy((i) => -1));

        ['a', 'b'].sortedWith(compareBy((s) => s.length));

        <String, int>{'A': 1, 'BB': 2, 'DDD': 3, 'CCCC': 4, 'EEE': 3}
            .toSortedMap(
          compareBy<String>((s) => s.length).then(compareBy((s) => s)),
        )..keys.expectEquals(['A', 'BB', 'DDD', 'EEE', 'CCCC']);
      });
    });
  });
}
