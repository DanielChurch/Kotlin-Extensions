import 'dart:collection' show LinkedHashMap;

import 'package:kotlin_extensions/src/extensions/list/list_object.dart'
    show SortedWith;
import 'package:kotlin_extensions/src/extensions/map/map_object.dart'
    show GetOrNull;
import 'package:kotlin_extensions/src/extensions/object/object.dart' show Let;

extension ToSortedMap<K extends Comparable, V> on Map<K, V> {
  // TODO
  LinkedHashMap<K, V> toSortedMap([Comparator<K> compare]) {
    return keys.toList().sortedWith(compare).let((sortedKeys) {
      return LinkedHashMap.fromIterables(sortedKeys, sortedKeys.map(getOrNull));
    });
  }
}
