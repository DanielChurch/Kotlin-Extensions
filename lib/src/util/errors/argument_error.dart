import 'package:kotlin_extensions/map.dart';

void checkAllNotNull(Map<String, Object> values) {
  final nullValues = values.whereValues((v) => v == null);

  if (nullValues.isNotEmpty) {
    throw ArgumentError('All of: ${nullValues.keys} must not be null');
  }
}

/* TODO: probably remove?
    return comparator.assertNotNull<T>('comparator')((it) {
      return reduceOrNull((i, j) => it(i, j) >= 0 ? i : j);
    });
*/
// extension AssertNotNull<T> on T {
//   R Function(Block<T, R>) assertNotNull<R>([String description]) {
//     return (Block<T, R> block) {
//       ArgumentError.checkNotNull(this, description);

//       return block(this);
//     };
//   }
// }

/*


/* TODO: probably remove?
    return selector.assertNotNull('selector', (selector) {
      return reduceOrNull((i, j) {
        return selector(i).compareTo(selector(j)) >= 0 ? i : j;
      });
    });

    return selector.assertNotNull<T>('selector', (it) {
      return reduceOrNull((i, j) {
        return it(i).compareTo(it(j)) >= 0 ? i : j;
      });
    });
*/
extension AssertNotNull<T> on T {
  R assertNotNull<R>(String description, Block<T, R> block) {
    ArgumentError.checkNotNull(this, description);

    return block(this);
  }
}
*/
