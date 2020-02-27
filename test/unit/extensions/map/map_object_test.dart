@TestOn('vm')

import 'package:test/test.dart';

import 'package:kotlin_extensions/map.dart';
import 'package:kotlin_extensions/object.dart';

void main() {
  group('get', () {
    test('returns the value when the key is in the map', () {
      expect({'Hello': 1, 'World': 2}.get('Hello'), 1);
      expect({5.5: 42, 7.2: 58}.get(5.5), 42);
    });

    test('returns null when the element is not in the map', () {
      expect({'Hello': 1, 'World': 2}.get('Foo'), isNull);
      expect({3.14159265: 'pi'}.get(2.17), isNull);
    });

    test('chains together', () {
      expect(
        {
          'first': {
            'second': {'third': 'value'}
          }
        }.get('first').get('second').get('third'),
        'value',
      );
    });

    test('allows null checking', () {
      expect(null?.get('test')?.get('test2'), isNull);
      expect({'test': null}.get('test')?.get('test2'), isNull);
    });

    test('returns the correct type', () {
      expect({'Hello': 'World'}.get('Hello'), isA<String>());
      expect({'Hello': 5}.get('Hello'), isA<int>());
    });
  });

  group('getOrDefault', () {
    test('returns the correct value when the key is in the map', () {
      expect({'Hello': 'World'}.getOrDefault('Hello', 'Foo'), 'World');
      expect({5.4: 88}.getOrDefault(5.4, 6), 88);
    });

    test('returns the default when the key is not in the map', () {
      expect({'Hello': 'World'}.getOrDefault('Hallo', 'Foo'), 'Foo');
      expect({5.4: 88}.getOrDefault(5.45, 6), 6);
    });

    test('returns the correct type', () {
      expect({'Hello': 'World'}.getOrDefault('Hello', 'Foo'), isA<String>());
      expect({'Hello': 5}.getOrDefault('Hello', 8), isA<int>());

      expect({'Hello': 'World'}.getOrDefault('Hallo', 'Foo'), isA<String>());
      expect({'Hello': 5}.getOrDefault('Hallo', 8), isA<int>());
    });
  });

  group('getOrElse', () {
    test('returns the correct value when the key is in the map', () {
      expect({'Hello': 'World'}.getOrElse('Hello', () => 'Foo'), 'World');
      expect({5.4: 88}.getOrElse(5.4, () => 6), 88);
    });

    test('returns the result of defaultValue not in the map', () {
      expect({'Hello': 'World'}.getOrElse('Hallo', () => 'Foo'), 'Foo');
      expect({5.4: 88}.getOrElse(5.45, () => 10 + 5), 15);
    });

    test('does not call defaultValue when the key is in the map', () {
      var param = '';
      <String, String>{'Hello': 'World'}
          .getOrElse('Hello', () => param = 'Foo');

      expect(param, '');
    });

    test('returns the correct type', () {
      expect(
        {'Hello': 'World'}.getOrElse('Hello', () => 'Foo'),
        isA<String>(),
      );
      expect({'Hello': 5}.getOrElse('Hello', () => 8), isA<int>());

      expect(
        {'Hello': 'World'}.getOrElse('Hallo', () => 'Foo'),
        isA<String>(),
      );
      expect({'Hello': 5}.getOrElse('Hallo', () => 8), isA<int>());
    });
  });

  group('mapKeys', () {
    test('handles empty map', () {
      expect({}.mapKeys((i) => i), {});
    });

    test('maps the keys of the map', () {
      expect(
        {0: 1, 2: 3}.mapKeys((k) => '$k').keys,
        ['0', '2'],
      );
    });

    test('keeps the same values of the map', () {
      expect(
        {0: 1, 2: 3}.mapKeys((k) => '$k').values,
        [1, 3],
      );
    });

    test('leaves the original map unmodified', () {
      <String, int>{'Hello': 0, 'World': 42}.let((originalMap) {
        expect(
          originalMap.mapKeys((k) => '$k-'),
          {'Hello-': 0, 'World-': 42},
        );

        expect(originalMap, {'Hello': 0, 'World': 42});
      });
    });
  });

  group('mapValues', () {
    test('handles an empty map', () {
      expect({}.mapValues((i) => i), {});
    });

    test('maps the values of the map', () {
      expect(
        {0: 1, 2: 3}.mapValues((k) => '$k').values,
        ['1', '3'],
      );
    });

    test('keeps the same keys of the map', () {
      expect(
        {0: 1, 2: 3}.mapValues((k) => '$k').keys,
        [0, 2],
      );
    });

    test('leaves the original map unmodified', () {
      <String, int>{'Hello': 0, 'World': 42}.let((originalMap) {
        expect(
          originalMap.mapValues((i) => i + 5),
          {'Hello': 5, 'World': 47},
        );

        expect(originalMap, {'Hello': 0, 'World': 42});
      });
    });
  });
}
