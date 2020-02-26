// TODO: Okay to make my own `Pair`? Should I use the Dart tuple package instead (from Dart team)?
class Pair<F, S> {
  final F first;
  final S second;

  const Pair(this.first, this.second);

  @override
  String toString() => 'Pair($first, $second)';
}
