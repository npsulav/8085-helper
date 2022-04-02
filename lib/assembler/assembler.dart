import 'dart:collection';

import 'dart:convert';

class Assembler {
  late String code;
  List<String> opcode = [];
  HashMap opcodeMap = HashMap();
  List a2ByteOpcode = [];
  List a3ByteOpcode = [];

  Assembler(){
   addOpcode();
   addByteInfo();
  }

  String assemble({code}) {
    this.code = code;
    return opcodeMap[code];
  }

  List<String> interpret({String code=""}) {

    List<String> returnString = [];
    if(a2ByteOpcode.contains(code.substring(0,3))){
      /// add the opcode of the first three letter opcode to the returning list
      returnString.add(assemble(code: code.substring(0,3)));
      /// add the remaining 1 bit data after opcode to list
      returnString.add(code.substring(4,6));
    }
    else if(a2ByteOpcode.contains(code.substring(0,5))){
      /// add the opcode of the first three letter opcode to the returning list
      returnString.add(assemble(code: code.substring(0,5)));
      /// add the remaining 1 bit data after opcode to list
      returnString.add(code.substring(6,8));
    }
    else if(a2ByteOpcode.contains(code.substring(0,2))){
      /// add the opcode of the first three letter opcode to the returning list
      returnString.add(assemble(code: code.substring(0,2)));
      /// add the remaining 1 bit data after opcode to list
      returnString.add(code.substring(3,5));
    }

    else if(a3ByteOpcode.contains(code.substring(0,2))){
      /// add the opcode of the first 2 letter opcode to the returning list
      returnString.add(assemble(code: code.substring(0,2)));
      /// add the remaining 2 bit data after opcode to list
      returnString.add(code.substring(5,7));
      returnString.add(code.substring(3,5));
    }
    else if(a3ByteOpcode.contains(code.substring(0,3))){
      /// add the opcode of the first three letter opcode to the returning list
      returnString.add(assemble(code: code.substring(0,3)));
      /// add the remaining 2 bit data after opcode to list
      returnString.add(code.substring(6,8));
      returnString.add(code.substring(4,6));
    }
    else if(a3ByteOpcode.contains(code.substring(0,4))){
      /// add the opcode of the first three letter opcode to the returning list
      returnString.add(assemble(code: code.substring(0,4)));
      /// add the remaining 2 bit data after opcode to list
      returnString.add(code.substring(7,9));
      returnString.add(code.substring(5,7));
    }
    else if(a3ByteOpcode.contains(code.substring(0,5))){
      /// add the opcode of the first three letter opcode to the returning list
      returnString.add(assemble(code: code.substring(0,5)));
      /// add the remaining 2 bit data after opcode to list
      returnString.add(code.substring(8,10));
      returnString.add(code.substring(6,8));
    }

    else {
      returnString.add(assemble(code: code));
    }


    return returnString;
  }

  List<String> multiLineInterpret({String code=""}) {
    List<String> finalOpcode = <String>[];

    LineSplitter ls = const LineSplitter();
    List<String> opcodeLines = ls.convert(code);

    for (var element in opcodeLines) {
      finalOpcode.addAll(interpret(code: element));
    }

    return finalOpcode;
  }

  void addByteInfo() {



    // 3b code, 4 letters
    a3ByteOpcode.add("call");
    a3ByteOpcode.add("lhld");
    a3ByteOpcode.add("shld");

    // 3b code, 5 letters
    a3ByteOpcode.add("lxi b"); // comma
    a3ByteOpcode.add("lxi d"); // comma
    a3ByteOpcode.add("lxi h"); // comma
    a3ByteOpcode.add("lxi sp"); // comma



    // two byte opcodes, 3 letters
    a2ByteOpcode.add("aci");
    a2ByteOpcode.add("adi");
    a2ByteOpcode.add("ani");
    a2ByteOpcode.add("out");
    a2ByteOpcode.add("sbi");
    a2ByteOpcode.add("sui");
    a2ByteOpcode.add("xri");
    a2ByteOpcode.add("ori");

    // 2b code, 2 letters
    a2ByteOpcode.add("in");

    // 2b code, 5 letters
    a2ByteOpcode.add("mvi a"); // comma
    a2ByteOpcode.add("mvi b"); // comma
    a2ByteOpcode.add("mvi c"); // comma
    a2ByteOpcode.add("mvi d"); // comma
    a2ByteOpcode.add("mvi e"); // comma
    a2ByteOpcode.add("mvi h"); // comma
    a2ByteOpcode.add("mvi l"); // comma
    a2ByteOpcode.add("mvi m"); // comma

    // 3b code, 2 letters
    a3ByteOpcode.add("cc");
    a3ByteOpcode.add("cp");
    a3ByteOpcode.add("cm");
    a3ByteOpcode.add("cz");
    a3ByteOpcode.add("jc");
    a3ByteOpcode.add("jm");
    a3ByteOpcode.add("jp");
    a3ByteOpcode.add("jz");

    // 3b code, 3 letters
    a3ByteOpcode.add("cnc");
    a3ByteOpcode.add("cnz");
    a3ByteOpcode.add("cpe");
    a3ByteOpcode.add("cpo");
    a3ByteOpcode.add("jnc");
    a3ByteOpcode.add("jnz");
    a3ByteOpcode.add("jmp");
    a3ByteOpcode.add("jpe");
    a3ByteOpcode.add("jpo");
    a3ByteOpcode.add("lda");
    a3ByteOpcode.add("sta");

  }

  void addOpcode(){
    /// all opcodes
    opcodeMap.putIfAbsent('aci', () => "CE");
    opcodeMap.putIfAbsent('adc a', () => "8F");
    opcodeMap.putIfAbsent('adc b', () => "88");
    opcodeMap.putIfAbsent('adc c', () => "89");
    opcodeMap.putIfAbsent('adc d', () => "8A");
    opcodeMap.putIfAbsent('adc e', () => "8B");
    opcodeMap.putIfAbsent('adc h', () => "8C");
    opcodeMap.putIfAbsent('adc l', () => "8D");
    opcodeMap.putIfAbsent('adc m', () => "8E");
    opcodeMap.putIfAbsent('add a', () => "87");
    opcodeMap.putIfAbsent('add b', () => "80");
    opcodeMap.putIfAbsent('add c', () => "81");
    opcodeMap.putIfAbsent('add d', () => "82");
    opcodeMap.putIfAbsent('add e', () => "83");
    opcodeMap.putIfAbsent('add h', () => "84");
    opcodeMap.putIfAbsent('add l', () => "85");
    opcodeMap.putIfAbsent('add m', () => "86");
    opcodeMap.putIfAbsent('adi', () => "C6");
    opcodeMap.putIfAbsent('ana a', () => "A7");
    opcodeMap.putIfAbsent('ana b', () => "A0");
    opcodeMap.putIfAbsent('ana c', () => "A1");
    opcodeMap.putIfAbsent('ana d', () => "A2");
    opcodeMap.putIfAbsent('ana e', () => "A3");
    opcodeMap.putIfAbsent('ana h', () => "A4");
    opcodeMap.putIfAbsent('ana l', () => "A5");
    opcodeMap.putIfAbsent('ana m', () => "A6");
    opcodeMap.putIfAbsent('ani', () => "E6");
    opcodeMap.putIfAbsent('call', () => "CD");
    opcodeMap.putIfAbsent('cc', () => "DC");
    opcodeMap.putIfAbsent('cm', () => "FC");
    opcodeMap.putIfAbsent('cma', () => "2F");
    opcodeMap.putIfAbsent('cmc', () => "3F");
    opcodeMap.putIfAbsent('cmp a', () => "BF");
    opcodeMap.putIfAbsent('cmp b', () => "B8");
    opcodeMap.putIfAbsent('cmp c', () => "B9");
    opcodeMap.putIfAbsent('cmp d', () => "BA");
    opcodeMap.putIfAbsent('cmp e', () => "BB");
    opcodeMap.putIfAbsent('cmp h', () => "BC");
    opcodeMap.putIfAbsent('cmp l', () => "BD");
    opcodeMap.putIfAbsent('cmp m', () => "BE");
    opcodeMap.putIfAbsent('cnc', () => "D4");
    opcodeMap.putIfAbsent('cnz', () => "C4");
    opcodeMap.putIfAbsent('cp', () => "F4");
    opcodeMap.putIfAbsent('cpe', () => "EC");
    opcodeMap.putIfAbsent('cpi', () => "FE");
    opcodeMap.putIfAbsent('cpo', () => "E4");
    opcodeMap.putIfAbsent('cz', () => "CC");
    opcodeMap.putIfAbsent('daa', () => "27");
    opcodeMap.putIfAbsent('dad b', () => "09");
    opcodeMap.putIfAbsent('dad d', () => "19");
    opcodeMap.putIfAbsent('dad h', () => "29");
    opcodeMap.putIfAbsent('dad sp', () => "39");
    opcodeMap.putIfAbsent('dcr a', () => "3D");
    opcodeMap.putIfAbsent('dcr b', () => "05");
    opcodeMap.putIfAbsent('dcr c', () => "0D");
    opcodeMap.putIfAbsent('dcr d', () => "15");
    opcodeMap.putIfAbsent('dcr e', () => "1D");
    opcodeMap.putIfAbsent('dcr h', () => "25");
    opcodeMap.putIfAbsent('dcr l', () => "2D");
    opcodeMap.putIfAbsent('dcr m', () => "35");
    opcodeMap.putIfAbsent('dcx b', () => "0B");
    opcodeMap.putIfAbsent('dcx d', () => "1B");
    opcodeMap.putIfAbsent('dcx h', () => "2B");
    opcodeMap.putIfAbsent('dcx sp', () => "3B");
    opcodeMap.putIfAbsent('di', () => "F3");
    opcodeMap.putIfAbsent('ei', () => "FB");
    opcodeMap.putIfAbsent('hlt', () => "76");
    opcodeMap.putIfAbsent('in', () => "DB");
    opcodeMap.putIfAbsent('inr a', () => "3C");
    opcodeMap.putIfAbsent('inr b', () => "04");
    opcodeMap.putIfAbsent('inr c', () => "0C");
    opcodeMap.putIfAbsent('inr d', () => "14");
    opcodeMap.putIfAbsent('inr e', () => "1C");
    opcodeMap.putIfAbsent('inr h', () => "24");
    opcodeMap.putIfAbsent('inr l', () => "2C");
    opcodeMap.putIfAbsent('inr m', () => "34");
    opcodeMap.putIfAbsent('inx b', () => "03");
    opcodeMap.putIfAbsent('inx d', () => "13");
    opcodeMap.putIfAbsent('inx h', () => "23");
    opcodeMap.putIfAbsent('inx sp', () => "33");
    opcodeMap.putIfAbsent('jc', () => "DA");
    opcodeMap.putIfAbsent('jm', () => "FA");
    opcodeMap.putIfAbsent('jmp', () => "C3");
    opcodeMap.putIfAbsent('jnc', () => "D2");
    opcodeMap.putIfAbsent('jnz', () => "C2");
    opcodeMap.putIfAbsent('jp', () => "F2");
    opcodeMap.putIfAbsent('jpe', () => "EA");
    opcodeMap.putIfAbsent('jpo', () => "E2");
    opcodeMap.putIfAbsent('jz', () => "CA");
    opcodeMap.putIfAbsent('lda', () => "3A");
    opcodeMap.putIfAbsent('ldax b', () => "0A");
    opcodeMap.putIfAbsent('ldax d', () => "1A");
    opcodeMap.putIfAbsent('lhld', () => "2A");
    opcodeMap.putIfAbsent('lxi b', () => "01");
    opcodeMap.putIfAbsent('lxi d', () => "11");
    opcodeMap.putIfAbsent('lxi h', () => "21");
    opcodeMap.putIfAbsent('lxi sp', () => "31");
    opcodeMap.putIfAbsent('mov a, a', () => "7F");
    opcodeMap.putIfAbsent('mov a, b', () => "78");
    opcodeMap.putIfAbsent('mov a, c', () => "79");
    opcodeMap.putIfAbsent('mov a, d', () => "7A");
    opcodeMap.putIfAbsent('mov a, e', () => "7B");
    opcodeMap.putIfAbsent('mov a, h', () => "7C");
    opcodeMap.putIfAbsent('mov a, l', () => "7D");
    opcodeMap.putIfAbsent('mov a, m', () => "7E");
    opcodeMap.putIfAbsent('mov b, a', () => "47");
    opcodeMap.putIfAbsent('mov b, b', () => "40");
    opcodeMap.putIfAbsent('mov b, c', () => "41");
    opcodeMap.putIfAbsent('mov b, d', () => "42");
    opcodeMap.putIfAbsent('mov b, e', () => "43");
    opcodeMap.putIfAbsent('mov b, h', () => "44");
    opcodeMap.putIfAbsent('mov b, l', () => "45");
    opcodeMap.putIfAbsent('mov b, m', () => "46");
    opcodeMap.putIfAbsent('mov c, a', () => "4F");
    opcodeMap.putIfAbsent('mov c, b', () => "48");
    opcodeMap.putIfAbsent('mov c, c', () => "49");
    opcodeMap.putIfAbsent('mov c, d', () => "4A");
    opcodeMap.putIfAbsent('mov c, e', () => "4B");
    opcodeMap.putIfAbsent('mov c, h', () => "4C");
    opcodeMap.putIfAbsent('mov c, l', () => "4D");
    opcodeMap.putIfAbsent('mov c, m', () => "4E");
    opcodeMap.putIfAbsent('mov d, a', () => "57");
    opcodeMap.putIfAbsent('mov d, b', () => "50");
    opcodeMap.putIfAbsent('mov d, c', () => "51");
    opcodeMap.putIfAbsent('mov d, d', () => "52");
    opcodeMap.putIfAbsent('mov d, e', () => "53");
    opcodeMap.putIfAbsent('mov d, h', () => "54");
    opcodeMap.putIfAbsent('mov d, l', () => "55");
    opcodeMap.putIfAbsent('mov d, m', () => "56");
    opcodeMap.putIfAbsent('mov e, a', () => "5F");
    opcodeMap.putIfAbsent('mov e, b', () => "58");
    opcodeMap.putIfAbsent('mov e, c', () => "59");
    opcodeMap.putIfAbsent('mov e, d', () => "5A");
    opcodeMap.putIfAbsent('mov e, e', () => "5B");
    opcodeMap.putIfAbsent('mov e, h', () => "5C");
    opcodeMap.putIfAbsent('mov e, l', () => "5D");
    opcodeMap.putIfAbsent('mov e, m', () => "5E");
    opcodeMap.putIfAbsent('mov h, a', () => "67");
    opcodeMap.putIfAbsent('mov h, b', () => "60");
    opcodeMap.putIfAbsent('mov h, c', () => "61");
    opcodeMap.putIfAbsent('mov h, d', () => "62");
    opcodeMap.putIfAbsent('mov h, e', () => "63");
    opcodeMap.putIfAbsent('mov h, h', () => "64");
    opcodeMap.putIfAbsent('mov h, l', () => "65");
    opcodeMap.putIfAbsent('mov h, m', () => "66");
    opcodeMap.putIfAbsent('mov l, a', () => "6F");
    opcodeMap.putIfAbsent('mov l, b', () => "68");
    opcodeMap.putIfAbsent('mov l, c', () => "69");
    opcodeMap.putIfAbsent('mov l, d', () => "6A");
    opcodeMap.putIfAbsent('mov l, e', () => "6B");
    opcodeMap.putIfAbsent('mov l, h', () => "6C");
    opcodeMap.putIfAbsent('mov l, l', () => "6D");
    opcodeMap.putIfAbsent('mov l, m', () => "6E");
    opcodeMap.putIfAbsent('mov m, a', () => "77");
    opcodeMap.putIfAbsent('mov m, b', () => "70");
    opcodeMap.putIfAbsent('mov m, c', () => "71");
    opcodeMap.putIfAbsent('mov m, d', () => "72");
    opcodeMap.putIfAbsent('mov m, e', () => "73");
    opcodeMap.putIfAbsent('mov m, h', () => "74");
    opcodeMap.putIfAbsent('mov m, l', () => "75");
    opcodeMap.putIfAbsent('mvi a', () => "3E");
    opcodeMap.putIfAbsent('mvi b', () => "06");
    opcodeMap.putIfAbsent('mvi c', () => "0E");
    opcodeMap.putIfAbsent('mvi d', () => "16");
    opcodeMap.putIfAbsent('mvi e', () => "1E");
    opcodeMap.putIfAbsent('mvi h', () => "26");
    opcodeMap.putIfAbsent('mvi l', () => "2E");
    opcodeMap.putIfAbsent('mvi m', () => "36");
    opcodeMap.putIfAbsent('nop', () => "00");
    opcodeMap.putIfAbsent('ora a', () => "B7");
    opcodeMap.putIfAbsent('ora b', () => "A0");
    opcodeMap.putIfAbsent('ora c', () => "A1");
    opcodeMap.putIfAbsent('ora d', () => "A2");
    opcodeMap.putIfAbsent('ora e', () => "A3");
    opcodeMap.putIfAbsent('ora h', () => "A4");
    opcodeMap.putIfAbsent('ora l', () => "A5");
    opcodeMap.putIfAbsent('ora m', () => "A6");
    opcodeMap.putIfAbsent('ori', () => "F6");
    opcodeMap.putIfAbsent('out', () => "D3");
    opcodeMap.putIfAbsent('pchl', () => "E9");
    opcodeMap.putIfAbsent('pop b', () => "C1");
    opcodeMap.putIfAbsent('pop d', () => "C5");
    opcodeMap.putIfAbsent('pop h', () => "E1");
    opcodeMap.putIfAbsent('pop psw', () => "F1");
    opcodeMap.putIfAbsent('push b', () => "C5");
    opcodeMap.putIfAbsent('push d', () => "D5");
    opcodeMap.putIfAbsent('push h', () => "E5");
    opcodeMap.putIfAbsent('push psw', () => "F5");
    opcodeMap.putIfAbsent('ral', () => "17");
    opcodeMap.putIfAbsent('rar', () => "1F");
    opcodeMap.putIfAbsent('rc', () => "D8");
    opcodeMap.putIfAbsent('ret', () => "C9");
    opcodeMap.putIfAbsent('rim', () => "20");
    opcodeMap.putIfAbsent('rlc', () => "07");
    opcodeMap.putIfAbsent('rm', () => "F0");
    opcodeMap.putIfAbsent('rnc', () => "D0");
    opcodeMap.putIfAbsent('rnz', () => "C0");
    opcodeMap.putIfAbsent('rp', () => "F8");
    opcodeMap.putIfAbsent('rpe', () => "E8");
    opcodeMap.putIfAbsent('rpo', () => "E0");
    opcodeMap.putIfAbsent('rrc', () => "0F");
    opcodeMap.putIfAbsent('rst 0', () => "C7");
    opcodeMap.putIfAbsent('rst 1', () => "CF");
    opcodeMap.putIfAbsent('rst 2', () => "D7");
    opcodeMap.putIfAbsent('rst 3', () => "DF");
    opcodeMap.putIfAbsent('rst 4', () => "E7");
    opcodeMap.putIfAbsent('rst 5', () => "EF");
    opcodeMap.putIfAbsent('rst 6', () => "F7");
    opcodeMap.putIfAbsent('rst 7', () => "FF");
    opcodeMap.putIfAbsent('rz', () => "C8");
    opcodeMap.putIfAbsent('sbb a', () => "9F");
    opcodeMap.putIfAbsent('sbb b', () => "98");
    opcodeMap.putIfAbsent('sbb c', () => "99");
    opcodeMap.putIfAbsent('sbb d', () => "9A");
    opcodeMap.putIfAbsent('sbb e', () => "9B");
    opcodeMap.putIfAbsent('sbb h', () => "9C");
    opcodeMap.putIfAbsent('sbb l', () => "9D");
    opcodeMap.putIfAbsent('sbb m', () => "9E");
    opcodeMap.putIfAbsent('sbi', () => "DE");
    opcodeMap.putIfAbsent('shld', () => "22");
    opcodeMap.putIfAbsent('sim', () => "30");
    opcodeMap.putIfAbsent('sphl', () => "F9");
    opcodeMap.putIfAbsent('sta', () => "32");
    opcodeMap.putIfAbsent('stax b', () => "02");
    opcodeMap.putIfAbsent('stax d', () => "12");
    opcodeMap.putIfAbsent('stc', () => "37");
    opcodeMap.putIfAbsent('sub a', () => "97");
    opcodeMap.putIfAbsent('sub b', () => "90");
    opcodeMap.putIfAbsent('sub c', () => "91");
    opcodeMap.putIfAbsent('sub d', () => "92");
    opcodeMap.putIfAbsent('sub e', () => "93");
    opcodeMap.putIfAbsent('sub h', () => "94");
    opcodeMap.putIfAbsent('sub l', () => "95");
    opcodeMap.putIfAbsent('sub m', () => "96");
    opcodeMap.putIfAbsent('sui', () => "D6");
    opcodeMap.putIfAbsent('xchg', () => "EB");
    opcodeMap.putIfAbsent('xra a', () => "AF");
    opcodeMap.putIfAbsent('xra b', () => "A8");
    opcodeMap.putIfAbsent('xra c', () => "A9");
    opcodeMap.putIfAbsent('xra d', () => "AA");
    opcodeMap.putIfAbsent('xra e', () => "AB");
    opcodeMap.putIfAbsent('xra h', () => "AC");
    opcodeMap.putIfAbsent('xra l', () => "AD");
    opcodeMap.putIfAbsent('xra m', () => "AE");
    opcodeMap.putIfAbsent('xri', () => "EE");
    opcodeMap.putIfAbsent('xthl', () => "E3");
  }
}