import 'package:a_8085_helper/assembler/assembler.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Assembler assembler = Assembler();
  test('Convert Assembly to opcode', () {
    expect(assembler.assemble(code: "aci"), "CE");
    expect(assembler.assemble(code: "adc d"), "8A");
  });
}