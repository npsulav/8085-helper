import 'package:a_8085_helper/assembler/assembler.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Assembler assembler = Assembler();

  test('Convert Assembly to opcode present in Map', () {
    expect(assembler.assemble(code: "aci"), "CE");
    expect(assembler.assemble(code: "adc d"), "8A");
  });

  test('Convert 2 bit opcode with 2 letters in it, containing comma', () {
    expect(assembler.interpret(code: "in 20h"), ["DB","20"]);
  });

  test('Convert 2 bit opcode with 3 letters in it', () {
    expect(assembler.interpret(code: "aci 20h"), ["CE","20"]);
  });

  test('Convert 2 bit opcode with 5 letters in it, containing comma', () {
    expect(assembler.interpret(code: "mvi a,20h"), ["3E","20"]);
  });

  test('Convert 3 bit opcode with 2 letters in it', () {
    expect(assembler.interpret(code: "cc 2000h"), ["DC","00","20"]);
  });

  test('Convert 3 bit opcode with 3 letters in it', () {
    expect(assembler.interpret(code: "cnc 2000h"), ["D4","00","20"]);
  });

  test('Convert 3 bit opcode with 4 letters in it', () {
    expect(assembler.interpret(code: "call 2000h"), ["CD","00","20"]);
  });

  test('Convert 3 bit opcode with 5 letters in it', () {
    expect(assembler.interpret(code: "lxi b,2000h"), ["01","00","20"]);
  });

  test('Convert normal assembly to opcode', () {
    expect(assembler.interpret(code: "adc a"), ["8F"]);
  });


}