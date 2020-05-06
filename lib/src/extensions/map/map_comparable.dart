import 'dart:collection' show LinkedHashMap;

import 'package:kotlin_extensions/src/extensions/list/list_object.dart'
    show SortedWith;
import 'package:kotlin_extensions/src/extensions/map/map_object.dart'
    show GetOrNull;

extension ToSortedMap<K extends Comparable, V> on Map<K, V> {
  // TODO
  LinkedHashMap<K, V> toSortedMap([Comparator<K> compare]) {
    final sortedKeys = keys.toList().sortedWith(compare);

    return LinkedHashMap.fromIterables(sortedKeys, sortedKeys.map(getOrNull));
  }
}
