import 'package:kotlin_extensions/typedefs.dart';

Comparator<T> compareBy<T>(Selector<T, Comparable> selector,
    [Selector<T, Comparable> selector2,
    Selector<T, Comparable> selector3,
    Selector<T, Comparable> selector4,
    Selector<T, Comparable> selector5,
    Selector<T, Comparable> selector6,
    Selector<T, Comparable> selector7,
    Selector<T, Comparable> selector8,
    Selector<T, Comparable> selector9,
    Selector<T, Comparable> selector10]) {
  return (T element1, T element2) {
    var output = 0;

    for (final _selector in [
      selector,
      selector2,
      selector3,
      selector4,
      selector5,
      selector6,
      selector7,
      selector8,
      selector9,
      selector10,
    ]) {
      if (_selector == null) continue;

      if (output != 0) return output;

      output = _selector(element1).compareTo(_selector(element2));
    }

    return output;
  };
}

Comparator<T> compareByDescending<T>(
  Selector<T, Comparable> selector, [
  Selector<T, Comparable> selector2,
  Selector<T, Comparable> selector3,
  Selector<T, Comparable> selector4,
  Selector<T, Comparable> selector5,
  Selector<T, Comparable> selector6,
  Selector<T, Comparable> selector7,
  Selector<T, Comparable> selector8,
  Selector<T, Comparable> selector9,
  Selector<T, Comparable> selector10,
]) {
  final comparison = compareBy(selector, selector2, selector3, selector4,
      selector5, selector6, selector7, selector8, selector9, selector10);

  return comparison.reversed;
}

extension Reversed<T> on Comparator<T> {
  /// Returns a [Comparator] that imposes the reverse ordering of this [Comparator].
  ///
  ///
  Comparator<T> get reversed {
    return (T element1, T element2) => -this(element1, element2);
  }
}

extension Then<T> on Comparator<T> {
  // TODO long term this should be infix. Otherwise, duplicate of thenComparator
  Comparator<T> then(Comparator<T> comparator) {
    ArgumentError.checkNotNull(comparator, 'comparator');

    return (T element1, T element2) {
      final value = this(element1, element2);

      if (value == 0) return comparator(element1, element2);

      return value;
    };
  }
}

extension ThenBy<T> on Comparator<T> {
  Comparator<T> thenBy<R extends Comparable>(Selector<T, R> selector) {
    ArgumentError.checkNotNull(selector, 'selector');

    return Then(this).then(compareBy(selector));
  }
}

extension ThenByDescending<T> on Comparator<T> {
  Comparator<T> thenByDescending<R extends Comparable>(
    Selector<T, R> selector,
  ) {
    ArgumentError.checkNotNull(selector, 'selector');

    return ThenDescending(this).thenDescending(compareBy(selector));
  }
}

extension ThenComparator<T> on Comparator<T> {
  Comparator<T> thenComparator(Comparator<T> comparator) {
    ArgumentError.checkNotNull(comparator, 'comparator');

    return Then(this).then(comparator);
  }
}

extension ThenDescending<T> on Comparator<T> {
  Comparator<T> thenDescending(Comparator<T> comparator) {
    ArgumentError.checkNotNull(comparator, 'comparator');

    return Then(this).then(comparator.reversed);
  }
}
