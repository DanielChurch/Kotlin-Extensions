import 'package:test/test.dart';

import 'package:kotlin_extensions/object.dart';

import '../../util/expect_extensions.dart';

void main() {
  group('on T', () {
    group('also', () {
      test('returns `this`', () {
        5.also((i) => 'Hello').expectEquals(5);
      });

      test('runs the block', () {
        final list = <String>[];

        5.also((i) => list.add('Test'));

        list.single.expectEquals('Test');
      });

      test('passes the correct value', () {
        // We validate the block is run in another test
        24.also((i) => i.expectEquals(24));
      });
    });

    group('let', () {
      test('returns what is returned from the block', () {
        5.let((i) => 'Hello').expectEquals('Hello');
      });

      test('runs the block', () {
        final list = <String>[];

        5.let((i) => list.add('Test'));

        list.single.expectEquals('Test');
      });

      test('passes the correct value', () {
        // We validate the block is run in another test
        24.let((i) => i.expectEquals(24));
      });
    });

    group('to', () {
      test('', () {
        'Hello'.to('World').expectIsA<MapEntry<String, String>>()
          ..key.expectEquals('Hello')
          ..value.expectEquals('World');
      });
    });
  });
}
