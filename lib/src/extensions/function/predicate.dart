import 'package:kotlin_extensions/typedefs.dart';

extension Negate<T> on Predicate<T> {
  Predicate<T> negate() => (T element) => !this(element);
}

extension Or<T> on Predicate<T> {
  Predicate<T> or(Predicate<T> predicate) {
    ArgumentError.checkNotNull(predicate);

    return (T element) => this(element) || predicate(element);
  }
}

extension And<T> on Predicate<T> {
  Predicate<T> and(Predicate<T> predicate) {
    ArgumentError.checkNotNull('predicate');

    return (T element) => this(element) && predicate(element);
  }
}
