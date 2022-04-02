import 'package:a_8085_helper/assembler/assembler.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Assembler assembler = Assembler(code: "Hello");
  test('Assembler Test', () {
    expect(assembler.assemble(), "Hello");
  });
}