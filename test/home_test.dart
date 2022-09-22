import 'package:flutter_test/flutter_test.dart';
import 'package:parallel_37/src/presentation/views/home.dart';

void main() {
  // basic single test
  test("Counter value should be incremented", () {
    final counter = Counter();

    counter.increment();

    expect(counter.value, 1);
  });

  // group multiple tests
  group("Counter", () {
    test("value should start at 0", () {
      expect(Counter().value, 0);
    });

    test("Counter value should be incremented", () {
      final counter = Counter();

      counter.increment();

      expect(counter.value, 1);
    });

    test("Counter value should be decremented", () {
      final counter = Counter();

      counter.decrement();

      expect(counter.value, -1);
    });
  });
}
