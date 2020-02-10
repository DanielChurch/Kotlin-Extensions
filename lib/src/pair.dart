class Pair<F, S> {
  final F first;
  final S second;

  const Pair(this.first, this.second);

  @override
  String toString() => 'Pair($first, $second)';
}
