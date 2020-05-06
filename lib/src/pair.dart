class Pair<F, S> {
  final F first;
  final S second;

  const Pair(this.first, this.second);

  @override
  String toString() => 'Pair($first, $second)';

  static F getFirst<F, S>(Pair<F, S> pair) => pair.first;
  static S getSecond<F, S>(Pair<F, S> pair) => pair.second;
}
