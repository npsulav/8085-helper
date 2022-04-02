import 'package:a_8085_helper/assembler/assembler.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Assembler assembler = Assembler();
  test('Convert Assembly to opcode present in Map', () {
    expect(assembler.assemble(code: "aci"), "CE");
    expect(assembler.assemble(code: "adc d"), "8A");
  });

  test('Convert One line Code containing data/address to opcode', () {
    expect(assembler.interpret(code: "aci 20h"), "CE 20");
  });
}