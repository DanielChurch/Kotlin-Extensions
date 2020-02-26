import 'dart:collection';

import '../list/list_object.dart';

// TODO: why not Comparable<T>?
extension ToSortedSet<T extends Comparable> on Set<T> {
  // TODO
  LinkedHashSet<T> toSortedSet([Comparator<T> compare]) {
    return LinkedHashSet.from(toList().sortedWith(compare));
  }
}
