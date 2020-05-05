<h1 align="center">
KotlinExtensions.dart
</h1>

<p align="center">
  A library of <a href='https://dart.dev/guides/language/extension-methods'> extension methods </a> inspired by <a href="https://kotlinlang.org/"> Kotlin </a>.
</p>

<p align="center">
  <a href="#introduction">Introduction</a> •
  <a href="#added-extensions">Added Extensions</a> •
  <a href="#requirements">Requirements</a> •
  <a href="#using-it-in-your-project">Using it in your project</a>
</p>

<p align="center">
  <a href="https://travis-ci.org/DanielChurch/Kotlin-Extensions">
    <img src="https://travis-ci.org/DanielChurch/Kotlin-Extensions.svg?branch=master">
  </a>
  <a href="https://codecov.io/gh/DanielChurch/Kotlin-Extensions">
    <img src="https://codecov.io/gh/DanielChurch/Kotlin-Extensions/branch/master/graph/badge.svg">
  </a>
</p>

## Introduction

`KotlinExtensions` is a package that adds implementations of extensions from [Kotlin](https://kotlinlang.org/) to [Dart](https://dart.dev/).

The extensions are:
  - Built on Dart's existing types
    - Familiar to existing Dart functionality
    - Easy to adopt
    - Follows Dart's methodology (eg. `Iterable` -> `Iterable` methods are lazy)
  - Fully tested with meaningful coverage
  - Well documentented
  - Built to be compatable with other similar libraries
    - `show`/`hide` anything extension you would like on an individual basis

## Added Extensions

On `T`: [also](doc/object.md#also), [let](doc/object.md#let), [to](doc/object.md#to)

On `Iterable<T>`: [associate](doc/iterable.md#associate), [associateBy](doc/iterable.md#associateBy), [associateWith](doc/iterable.md#associateWith), [containsAll](doc/iterable.md#containsAll), [firstOrNull](doc/iterable.md#firstOrNull), [flatMap](doc/iterable.md#flatMap), [forEachIndexed](doc/iterable.md#forEachIndexed), [groupBy](doc/iterable.md#groupBy), [isNullOrEmpty](doc/iterable.md#isNullOrEmpty), [lastOrNull](doc/iterable.md#lastOrNull), [mapIndexed](doc/iterable.md#mapIndexed), [mapIndexedNotNull](doc/iterable.md#mapIndexedNotNull), [mapNotNull](doc/iterable.md#mapNotNull), [maxBy](doc/iterable.md#maxBy), [maxWith](doc/iterable.md#maxWith), [minBy](doc/iterable.md#minBy), [minWith](doc/iterable.md#minWith), [partition](doc/iterable.md#partition), [reduceIndexed](doc/iterable.md#reduceIndexed), [reduceIndexedOrNull](doc/iterable.md#reduceIndexedOrNull-not-from-kotlin), [reduceOrNull](doc/iterable.md#reduceOrNull-not-from-kotlin), [whereIndexed](doc/iterable.md#whereIndexed-kotlin-filterIndexed), [whereIsNotNull](doc/iterable.md#whereIsNotNull-not-from-kotlin), [whereNot (Kotlin filterNot)](doc/iterable.md#whereNot-kotlin-filterNot), [whereNotNull](doc/iterable.md#whereNotNull-kotlin-filterNotNull)

On `Iterable<Iterable<T>>`: [flatten](doc/iterable.md#flatten)

On `Iterable<Map<K, V>>`: [toMap](doc/iterable.md#toMap)

On `Iterable<num>`: [average](doc/iterable.md#average), [sum](doc/iterable.md#sum)

On `Iterable<T extends Comparable>`: [max](doc/iterable.md#max), [min](doc/iterable.md#min)

On `List<T>`: [distinct](doc/list.md#distinct), [distinctBy](doc/list.md#distinctBy), [sortedBy](doc/list.md#sortedBy), [sortedByDescending](doc/list.md#sortedByDescending), [sortedWith](doc/list.md#sortedWith)

On `List<T extends Comparable>`: [sorted](doc/list.md#sorted), [sortedDescending](doc/list.md#sortedDescending)

On `Map<K, V>`: [any](doc/map.md#any), [asIterable](doc/map.md#asIterable), [copy](doc/map.md#copy), [every](doc/map.md#every), [flatMap](doc/map.md#flatMap), [getOrDefault](doc/map.md#getOrDefault), [getOrElse](doc/map.md#getOrElse), [getOrNull](doc/map.md#getOrNull), [getValue](doc/map.md#getValue), [isNullOrEmpty](doc/map.md#isNullOrEmpty), [mapKeys](doc/map.md#mapKeys), [mapNotNull](doc/map.md#mapNotNull), [mapToIterable](doc/map.md#mapToIterable), [mapValues](doc/map.md#mapValues), [maxBy](doc/map.md#maxBy), [maxWith](doc/map.md#maxWith), [minBy](doc/map.md#minBy), [minWith](doc/map.md#minWith), [none](doc/map.md#none), [onEach](doc/map.md#onEach), [orEmpty](doc/map.md#orEmpty), [plus](doc/map.md#plus), [toList](doc/map.md#toList), [where](doc/map.md#where), [whereKeys](doc/map.md#whereKeys), [whereNot](doc/map.md#whereNot), [whereValues](doc/map.md#whereValues)

On `bool Function(T)` & `bool Function(K, V)`: [and](doc/function.md#and), [negate](doc/function.md#negate), [or](doc/function.md#or)

## Requirements

This project adds extension methods, an addition from Dart SDK `2.7.0`. Your project must have a lower sdk bound of at least `^2.7.0`.

## Using it in your project

1. Add the `kotlin_extensions` package as a dependency in your `pubspec.yaml`.

```yaml
dependencies:
  kotlin_extensions: ^1.0.0
```

2. Import the extensions where you would like to use them.

The extensions are split up into separate libraries, so you can import only what you need. The packages are separated by what object the extensions are on:

```Dart
import 'package:kotlin_extensions/iterable.dart';
```

```Dart
import 'package:kotlin_extensions/list.dart';
```

```Dart
import 'package:kotlin_extensions/map.dart';
```

```Dart
import 'package:kotlin_extensions/set.dart';
```

```Dart
import 'package:kotlin_extensions/object.dart';
```

```Dart
import 'package:kotlin_extensions/function.dart';
```
