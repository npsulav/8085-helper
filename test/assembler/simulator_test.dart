import 'package:a_8085_helper/assembler/simulator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Simulator8085 simulator8085 = Simulator8085();
  test("Simulator basic test", () {
    simulator8085.setMemory(2000, "15");
    expect(simulator8085.getMemory(2000), "15");
    expect(simulator8085.getMemory(6000), "00");
    expect(simulator8085.getMemory(6500000), "");
  });

  test("Simulator Memory test", () {
    simulator8085.setAccumulator(50);
    expect(simulator8085.getAccumulator(), 32);
  });

}