extension AsIterable on String {
  /// Creates an [Iterable] instance that wraps the original char
  /// sequence returning its characters when being iterated.
  ///
  /// Examples:
  /// ```Dart
  /// print('Hello'.asIterable()); // (H, e, l, l, o)
  /// print('\u{1D11E}test'.asIterable()); // (𝄞, t, e, s, t)
  /// print('𝄞test'.asIterable()); // (𝄞, t, e, s, t)
  /// ```
  Iterable<String> asIterable() {
    return runes.map((rune) => String.fromCharCode(rune));
  }
}

// TODO: Documentation below

extension Capitalize on String {
  ///
  ///
  /// Related: [decapitalize]
  ///
  /// Examples:
  /// ```Dart
  /// ```
  String capitalize() {
    if (isEmpty) return this;

    return '${first.toUpperCase()}${substring(1, length)}';
  }
}

extension Decapitalize on String {
  ///
  ///
  /// Related: [capitalize]
  ///
  /// Examples:
  /// ```Dart
  /// ```
  String decapitalize() {
    if (isEmpty) return this;

    return '${first.toLowerCase()}${substring(1, length)}';
  }
}

extension First on String {
  ///
  ///
  /// Related:
  ///
  /// Examples:
  /// ```Dart
  /// ```
  String get first => take(1);
}

extension Lines on String {
  ///
  ///
  /// Related:
  ///
  /// Examples:
  /// ```Dart
  /// ```
  Iterable<String> lines() => split('\n');
}

extension Take on String {
  ///
  ///
  /// Related:
  ///
  /// Examples:
  /// ```Dart
  /// ```
  String take(int count) {
    ArgumentError.checkNotNull(count, 'count');

    return asIterable().take(count).join();
  }
}
