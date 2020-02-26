extension RangeTo on int {
  Iterable<int> rangeTo(int that) {
    ArgumentError.checkNotNull(that, 'that');

    return until(that + 1);
  }
}

extension Until on int {
  Iterable<int> until(int that) {
    ArgumentError.checkNotNull(that, 'that');

    return Iterable.generate(that - this, (index) => index + this);
  }
}

extension DownTo on int {
  Iterable<int> downTo(int that) {
    ArgumentError.checkNotNull(that, 'that');

    return Iterable.generate(this - that + 1, (index) => this - index);
  }
}

extension Days on int {
  Duration get days => Duration(days: this);
}

extension Hours on int {
  Duration get hours => Duration(hours: this);
}

extension Minutes on int {
  Duration get minutes => Duration(minutes: this);
}

extension Microseconds on int {
  Duration get microseconds => Duration(microseconds: this);
}

extension Milliseconds on int {
  Duration get milliseconds => Duration(milliseconds: this);
}
