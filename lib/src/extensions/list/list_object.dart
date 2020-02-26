import 'package:kt_xt/typedefs.dart';

extension Distinct<T> on List<T> {
  /// Returns a [List] containing only distinct elements from the given collection.
  ///
  /// The elements in the resulting [List] are in the same order as they were in the source [Iterable].
  ///
  /// Examples:
  /// ```Dart
  /// [0, 0, 1, 1, 2, 2].distinct(); // => [0, 1, 2]
  /// ['Hello', 'Hello', 'World'].distinct(); // => ['Hello', 'World']
  /// ```
  List<T> distinct() => toSet().toList();
}

extension DistinctBy<T> on List<T> {
  /// Returns a list containing only elements from the given array having distinct keys returned by the given selector function.
  ///
  /// The elements in the resulting list are in the same order as they were in the source array.
  ///
  /// Examples:
  /// ```Dart
  /// [0, 1, 2, 3].distinctBy((i) => i % 2); // => [0, 1]
  /// ```
  List<T> distinctBy<R>(Selector<T, R> selector) {
    final cache = {for (final element in reversed) selector(element): element};

    return cache.keys.toList().reversed.toSet().map((v) => cache[v]).toList();
  }
}

extension SortedBy<T> on List<T> {
  /// Returns a List of all elements sorted according to natural sort
  /// order of the value returned by specified selector function.
  ///
  /// The sort is stable. It means that equal elements preserve
  /// their order relative to each other after sorting.
  ///
  /// Example:
  /// ```Dart
  /// 1, 2, 3].sortedBy((i) => -i); // => [3, 2, 1]
  /// ```
  List<T> sortedBy<R extends Comparable>(Selector<T, R> selector) {
    // TODO: why not Comparable<T>?
    // Only run `selector` once per element
    final cache = {for (final element in this) element: selector(element)};

    return sortedWith((i, j) => cache[i].compareTo(cache[j]));
  }
}

extension SortedByDescending<T> on List<T> {
  /// Returns a [List] of all elements sorted descending according to natural
  /// sort order of the value returned by specified [selector] function.
  ///
  /// The sort is stable. It means that equal elements preserve their order
  /// relative to each other after sorting.
  ///
  /// Example:
  /// ```Dart
  /// ['Foo', 'Hello', 'Four'].sortedByDescending((str) => str.length); // => ['Hello', 'Four', 'Foo']
  /// ```
  List<T> sortedByDescending<R extends Comparable>(Selector<T, R> selector) {
    // TODO: why not Comparable<T>?
    return sortedBy(selector).reversed.toList();
  }
}

extension SortedWith<T> on List<T> {
  /// Returns a List of all elements sorted according to the specified comparator.
  ///
  /// The sort is stable. It means that equal elements preserve
  /// their order relative to each other after sorting.
  ///
  /// Example:
  /// ```Dart
  /// [2, 3, 1].sortedWith((i, j) => i > j ? 1 : -1); // => [1, 2, 3]
  /// ```
  List<T> sortedWith(Comparator<T> compare) => toList()..sort(compare);
}
