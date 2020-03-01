import 'dart:collection';

import '../list/list_object.dart';
import '../object/object.dart';
import 'map_object.dart';

extension ToSortedMap<K extends Comparable, V> on Map<K, V> {
  LinkedHashMap<K, V> toSortedMap([Comparator<K> compare]) {
    return keys.toList().sortedWith(compare).let((sortedKeys) {
      return LinkedHashMap.fromIterables(sortedKeys, sortedKeys.map(getOrNull));
    });
  }
}
