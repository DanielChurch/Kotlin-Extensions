@TestOn('vm')

import 'package:test/test.dart';

import 'package:kt_xt/object.dart';

void main() {
  group('also', () {
    test('returns `this`', () {
      expect(5.also((i) => 'Hello'), 5);
    });

    test('runs the block', () {
      final list = <String>[];

      5.also((i) {
        list.add('Test');
      });

      expect(list.single, 'Test');
    });

    test('passes the correct value', () {
      // We validate the block is run in another test
      24.also((i) => expect(i, 24));
    });
  });

  group('let', () {
    test('returns what is returned from the block', () {
      expect(5.let((i) => 'Hello'), 'Hello');
    });

    test('runs the block', () {
      final list = <String>[];

      5.let((i) {
        list.add('Test');
      });

      expect(list.single, 'Test');
    });

    test('passes the correct value', () {
      // We validate the block is run in another test
      24.let((i) => expect(i, 24));
    });
  });
}
