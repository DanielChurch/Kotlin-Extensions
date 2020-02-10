// Represents a predicate (boolean-valued function) of one argument.
typedef Predicate<T> = bool Function(T);
typedef IndexedPredicate<T> = bool Function(int, T);

typedef Transform<T, R> = R Function(T);
typedef IndexedTransform<T, R> = R Function(int, T);

typedef Selector<T, R> = R Function(T);

typedef Action<T> = void Function(T);
typedef IndexedAction<T> = void Function(int, T);

typedef Block<T, R> = R Function(T);

typedef IndexedCombinator<T> = T Function(int, T, T);
