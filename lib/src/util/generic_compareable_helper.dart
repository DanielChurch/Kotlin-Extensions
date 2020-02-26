T genericMax<T extends Comparable>(T first, T second) {
  return first.compareTo(second) > 0 ? first : second;
}

T genericMin<T extends Comparable>(T first, T second) {
  return first.compareTo(second) < 0 ? first : second;
}
