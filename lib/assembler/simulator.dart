class Simulator8085 {
  static const int memorySize = 65536; // 64 kb memory size
  static const int stackSize = 256; // 256 bytes stack size
  List<String> memory = List.filled(memorySize, '00');
  bool _carryFlag = false;
  bool _zeroFlag = false;
  bool _signFlag = false;

  String getMemory(int address) {
    if (address < 0 || address >= memorySize) {
      return "";
    }
    return memory[address];
  }

  void setMemory(int address, String value) {
    if (address < 0 || address >= memorySize) {
      return;
    }
    memory[address] = value;
  }

  int getStackPointer() {
    return int.parse(getMemory(0xffff));
  }

  void setStackPointer(int value) {
    setMemory(0xffff, value.toRadixString(16).padLeft(2, '0'));
  }

  int getProgramCounter() {
    return int.parse(getMemory(0xfffe));
  }

  void setProgramCounter(int value) {
    setMemory(0xfffe, value.toRadixString(16).padLeft(2, '0'));
  }

  int getAccumulator() {
    return int.parse(getMemory(0xfffd));
  }

  void setAccumulator(int value) {
    setMemory(0xfffd, value.toRadixString(16).padLeft(2, '0'));
  }

  int getRegister(int register) {
    return int.parse(getMemory(0xfffc + register));
  }

  void setRegister(int register, int value) {
    setMemory(0xfffc + register, value.toRadixString(16).padLeft(2, '0'));
  }

  int getFlag(int flag) {
    return int.parse(getMemory(0xfffa + flag));
  }

  void setFlag(int flag, int value) {
    setMemory(0xfffa + flag, value.toRadixString(16).padLeft(2, '0'));
  }

  int getPort(int port) {
    return int.parse(getMemory(0xfff8 + port));
  }

  void setPort(int port, int value) {
    setMemory(0xfff8 + port, value.toRadixString(16).padLeft(2, '0'));
  }

  void reset() {
    setMemory(0xfffe, '00');
    setMemory(0xffff, '00');
    setMemory(0xfffd, '00');
    for (int i = 0; i < 8; i++) {
      setMemory(0xfffc + i, '00');
    }
    for (int i = 0; i < 8; i++) {
      setMemory(0xfffa + i, '00');
    }
    for (int i = 0; i < 8; i++) {
      setMemory(0xfff8 + i, '00');
    }
  }

  void loadProgram(List<String> program) {
    int address = 0xfffc;
    for (String line in program) {
      setMemory(address, line);
      address++;
    }
  }

  void run() {
    int programCounter = getProgramCounter();
    while (programCounter < memorySize) {
      String instruction = getMemory(programCounter);
      programCounter++;
      switch (instruction) {
        case '00':
        // NOP
          break;
        case '01':
        // LXI B,d16
          setRegister(1, int.parse(getMemory(programCounter)));
          programCounter++;
          setRegister(1, int.parse(getMemory(programCounter)));
          programCounter++;
          break;
        case '02':
        // STAX B
          setMemory(getRegister(1),
              getAccumulator().toRadixString(16).padLeft(2, '0'));
          break;
        case '03':
        // INX B
          setRegister(1, getRegister(1) + 1);
          break;
        case '04':
        // INR B
          setAccumulator(getAccumulator() + 1);
          break;
        case '05':
        // DCR B
          setAccumulator(getAccumulator() - 1);
          break;
        case '06':
        // MVI B,d8
          setRegister(1, int.parse(getMemory(programCounter)));
          programCounter++;
          break;
        case '07':
        // RLC
          setFlag(0, getAccumulator() >> 7);
          setAccumulator(getAccumulator() << 1);
          setFlag(1, getAccumulator() >> 7);
          break;
        case '08':
        // NOP
          break;
        case '09':
        // DAD B
          setAccumulator(getAccumulator() + getRegister(1));
          setFlag(0, getAccumulator() >> 8);
          setFlag(1, getAccumulator() >> 15);
          break;
        case '0a':
        // LDAX B
          setAccumulator(int.parse(getMemory(getRegister(1))));
          break;
        case '0b':
        // DCX B
          setRegister(1, getRegister(1) -
              1);
          break;
        case '0c':
        // INR C
          setAccumulator(getAccumulator() + 1);
          break;
        case '0d':
        // DCR C
          setAccumulator(getAccumulator() - 1);
          break;
        case '0e':
        // MVI C,d8
          setRegister(2, int.parse(getMemory(programCounter)));
          programCounter++;
          break;
        case '0f':
        // RRC
          setFlag(0, getAccumulator() & 1);
          setAccumulator(getAccumulator() >> 1);
          setFlag(1, getAccumulator() >> 7);
          break;
        case '10':
        // NOP
          break;
        case '11':
        // LXI D,d16
          setRegister(3, int.parse(getMemory(programCounter)));
          programCounter++;
          setRegister(3, int.parse(getMemory(programCounter)));
          programCounter++;
          break;
        case '12':
        // STAX D
          setMemory(getRegister(3),
              getAccumulator().toRadixString(16).padLeft(2, '0'));
          break;
        case '13':
        // INX D
          setRegister(3, getRegister(3) + 1);
          break;

        case '14':
        // INR D
          setAccumulator(getAccumulator() + 1);
          break;
        case '15':
        // DCR D
          setAccumulator(getAccumulator() - 1);
          break;
        case '16':
        // MVI D,d8
          setRegister(3, int.parse(getMemory(programCounter)));
          programCounter++;
          break;
        case '17':
        // RAL
          int carry = getFlag(0);
          setFlag(0, getAccumulator() >> 7);
          setAccumulator(getAccumulator() << 1);
          setAccumulator(getAccumulator() | carry);
          setFlag(1, getAccumulator() >> 7);
          break;
        case '18':
        // NOP
          break;
        case '19':
        // DAD D
          setAccumulator(getAccumulator() + getRegister(3));
          setFlag(0, getAccumulator() >> 8);
          setFlag(1, getAccumulator() >> 15);
          break;
        case '1a':
        // LDAX D
          setAccumulator(int.parse(getMemory(getRegister(3))));
          break;
        case '1b':
        // DCX D
          setRegister(3, getRegister(3) -
              1);
          break;
        case '1c':
        // INR E
          setAccumulator(getAccumulator() + 1);
          break;
        case '1d':
        // DCR E
          setAccumulator(getAccumulator() - 1);
          break;
        case '1e':
        // MVI E,d8
          setRegister(4, int.parse(getMemory(programCounter)));
          programCounter++;
          break;
        case '1f':
        // RAR
          int carry = getFlag(0);
          setFlag(0, getAccumulator() & 1);
          setAccumulator(getAccumulator() >> 1);
          setAccumulator(getAccumulator() | (carry << 7));
          setFlag(1, getAccumulator() >> 7);
          break;
        case '20':
        // NOP
          break;
        case '21':
        // LXI H,d16
          setRegister(5, int.parse(getMemory(programCounter)));
          programCounter++;
          setRegister(5, int.parse(getMemory(programCounter)));
          programCounter++;
          break;
        case '22':
        // SHLD adr
          setMemory(int.parse(getMemory(programCounter), radix: 16),
              getRegister(5).toRadixString(16).padLeft(2, '0'));
          programCounter++;
          setMemory(int.parse(getMemory(programCounter), radix: 16),
              getRegister(5).toRadixString(16).padLeft(2, '0'));
          programCounter++;
          break;
        case '23':
        // INX H
          setRegister(5, getRegister(5) + 1);
          break;
        case '24':
        // INR H
          setAccumulator(getAccumulator() + 1);
          break;
        case '25':
        // DCR H
          setAccumulator(getAccumulator() - 1);
          break;
        case '26':
        // MVI H,d8
          setRegister(5, int.parse(getMemory(programCounter)));
          programCounter++;
          break;
        case '27':
        // DAA
          int a = getAccumulator();
          if (getFlag(1) == 0) {
            if (getFlag(0) == 1 || (a & 0x0f) > 9) {
              a += 6;
            }
            if (getFlag(1) == 1 || a > 0x9f) {
              a += 0x60;
            }
          } else {
            if (getFlag(0) == 1) {
              a = (a - 6) & 0xff;
            }
            if (getFlag(1) == 1) {
              a -= 0x60;
            }
          }
          setFlag(0, a & 0x100);
          setFlag(1, a & 0x200);
          setAccumulator(a & 0xff);
          break;
        case '28':
        // NOP
          break;
        case '29':
        // DAD H
          setAccumulator(getAccumulator() + getRegister(5));
          setFlag(0, getAccumulator() >> 8);
          setFlag(1, getAccumulator() >> 15);
          break;
        case '2a':
        // LHLD adr
          setRegister(6, int.parse(getMemory(programCounter), radix: 16));
          programCounter++;
          setRegister(7, int.parse(getMemory(programCounter), radix: 16));
          programCounter++;
          break;
        case '2b':
        // DCX H
          setRegister(5, getRegister(5) -
              1);
          break;
        case '2c':
        // INR L
          setAccumulator(getAccumulator() + 1);
          break;
        case '2d':
        // DCR L
          setAccumulator(getAccumulator() - 1);
          break;
        case '2e':
        // MVI L,d8
          setRegister(6, int.parse(getMemory(programCounter)));
          programCounter++;
          break;
        case '2f':
        // CMA
          setAccumulator(getAccumulator() ^ 0xff);
          break;
        case '30':
        // NOP
          break;
        case '31':
        // LXI SP,d16
          setRegister(6, int.parse(getMemory(programCounter)));
          programCounter++;
          setRegister(6, int.parse(getMemory(programCounter)));
          programCounter++;
          break;
        case '32':
        // STA adr
          setMemory(int.parse(getMemory(programCounter), radix: 16),
              getAccumulator().toRadixString(16).padLeft(2, '0'));
          programCounter++;
          setMemory(int.parse(getMemory(programCounter), radix: 16),
              getAccumulator().toRadixString(16).padLeft(2, '0'));
          programCounter++;
          break;
        case '33':
        // INX SP
          setRegister(6, getRegister(6) + 1);
          break;
        case '34':
        // INR M
          setMemory(getRegister(6), (int.parse(getMemory(getRegister(6))) + 1)
              .toRadixString(16)
              .padLeft(2, '0'));
          break;
        case '35':
        // DCR M
          setMemory(getRegister(6), (int.parse(getMemory(getRegister(6))) - 1)
              .toRadixString(16)
              .padLeft(2, '0'));
          break;
        case '36':
        // MVI M,d8
          setMemory(getRegister(6), getMemory(programCounter));
          programCounter++;
          break;
        case '37':
        // STC
          setFlag(0, 1);
          break;
        case '38':
        // NOP
          break;
        case '39':
        // DAD SP
          setAccumulator(getAccumulator() + getRegister(6));
          setFlag(0, getAccumulator() >> 8);
          setFlag(1, getAccumulator() >> 15);
          break;
        case '3a':
        // LDA adr
          setAccumulator(int.parse(getMemory(programCounter), radix: 16));
          programCounter++;
          break;
        case '3b':
        // DCX SP
          setRegister(6, getRegister(6) - 1);
          break;
        case '3c':
        // INR A
          setAccumulator(getAccumulator() + 1);
          break;
        case '3d':
        // DCR A
          setAccumulator(getAccumulator() - 1);
          break;
        case '3e':
        // MVI A,d8
          setAccumulator(int.parse(getMemory(programCounter)));
          programCounter++;
          break;
        case '3f':
        // CMC
          setFlag(0, getFlag(0) ^ 1);
          break;
        case '40':
        // MOV B,B
          setRegister(1, getRegister(1));
          break;
        case '41':
        // MOV B,C
          setRegister(1, getRegister(2));
          break;
        case '42':
        // MOV B,D
          setRegister(1, getRegister(3));
          break;
        case '43':
        // MOV B,E
          setRegister(1, getRegister(4));
          break;
        case '44':
        // MOV B,H
          setRegister(1, getRegister(5));
          break;
        case '45':
        // MOV B,L
          setRegister(1, getRegister(6));
          break;
        case '46':
        // MOV B,M
          setRegister(1, int.parse(getMemory(getRegister(6)), radix: 16));
          break;
        case '47':
        // MOV B,A
          setRegister(1, getAccumulator());
          break;
        case '48':
        // MOV C,B
          setRegister(2, getRegister(1));
          break;
        case '49':
        // MOV C,C
          setRegister(2, getRegister(2));
          break;
        case '4a':
        // MOV C,D
          setRegister(2, getRegister(3));
          break;
        case '4b':
        // MOV C,E
          setRegister(2, getRegister(4));
          break;
        case '4c':
        // MOV C,H
          setRegister(2, getRegister(5));
          break;
        case '4d':
        // MOV C,L
          setRegister(2, getRegister(6));
          break;
        case '4e':
        // MOV C,M
          setRegister(2, int.parse(getMemory(getRegister(6)), radix: 16));
          break;

        case '4f':
        // MOV C,A
          setRegister(2, getAccumulator());
          break;

        case '50':
        // MOV D,B
          setRegister(3, getRegister(1));
          break;
        case '51':
        // MOV D,C
          setRegister(3, getRegister(2));
          break;
        case '52':
        // MOV D,D
          setRegister(3, getRegister(3));
          break;
        case '53':
        // MOV D,E
          setRegister(3, getRegister(4));
          break;
        case '54':
        // MOV D,H
          setRegister(3, getRegister(5));
          break;
        case '55':
        // MOV D,L
          setRegister(3, getRegister(6));
          break;
        case '56':
        // MOV D,M
          setRegister(3, int.parse(getMemory(getRegister(6)), radix: 16));
          break;
        case '57':
        // MOV D,A
          setRegister(3, getAccumulator());
          break;
        case '58':
        // MOV E,B
          setRegister(4, getRegister(1));
          break;
        case '59':
        // MOV E,C
          setRegister(4, getRegister(2));
          break;
        case '5a':
        // MOV E,D
          setRegister(4, getRegister(3));
          break;
        case '5b':
        // MOV E,E
          setRegister(4, getRegister(4));
          break;
        case '5c':
        // MOV E,H
          setRegister(4, getRegister(5));
          break;
        case '5d':
        // MOV E,L
          setRegister(4, getRegister(6));
          break;
        case '5e':
        // MOV E,M
          setRegister(4, int.parse(getMemory(getRegister(6)), radix: 16));
          break;
        case '5f':
        // MOV E,A
          setRegister(4, getAccumulator());
          break;
        case '60':
        // MOV H,B
          setRegister(5, getRegister(1));
          break;
        case '61':
        // MOV H,C
          setRegister(5, getRegister(2));
          break;
        case '62':
        // MOV H,D
          setRegister(5, getRegister(3));
          break;
        case '63':
        // MOV H,E
          setRegister(5, getRegister(4));
          break;  
        case '64':
        // MOV H,H
          setRegister(5, getRegister(5));
          break;
        case '65':
        // MOV H,L
          setRegister(5, getRegister(6));
          break;
        case '66':
        // MOV H,M
          setRegister(5, int.parse(getMemory(getRegister(6)), radix: 16));
          break;
        case '67':
        // MOV H,A
          setRegister(5, getAccumulator());
          break;
        case '68':
        // MOV L,B
          setRegister(6, getRegister(1));
          break;
        case '69':
        // MOV L,C
          setRegister(6, getRegister(2));
          break;
        case '6a':
        // MOV L,D
          setRegister(6, getRegister(3));
          break;
        case '6b':
        // MOV L,E
          setRegister(6, getRegister(4));
          break;
        case '6c':
        // MOV L,H
          setRegister(6, getRegister(5));
          break;
        case '6d':
        // MOV L,L
          setRegister(6, getRegister(6));
          break;
        case '6e':
        // MOV L,M
          setRegister(6, int.parse(getMemory(getRegister(6)), radix: 16));
          break;
        case '6f':
        // MOV L,A
          setRegister(6, getAccumulator());
          break;
        case '70':
        // MOV M,B
          setMemory(getRegister(6), getRegister(1).toRadixString(16));
          break;
        case '71':
        // MOV M,C
          setMemory(getRegister(6), getRegister(2).toRadixString(16));
          break;
        case '72':
        // MOV M,D
          setMemory(getRegister(6), getRegister(3).toRadixString(16));
          break;
        case '73':
        // MOV M,E
          setMemory(getRegister(6), getRegister(4).toRadixString(16));
          break;
        case '74':
        // MOV M,H
          setMemory(getRegister(6), getRegister(5).toRadixString(16));
          break;
        case '75':
        // MOV M,L
          setMemory(getRegister(6), getRegister(6).toRadixString(16));
          break;
        case '76':
        // HLT
          break;
        case '77':
        // MOV M,A
          setMemory(getRegister(6), getAccumulator().toRadixString(16));
          break;
        case '78':
        // MOV A,B
          setAccumulator(getRegister(1));
          break;
        case '79':
        // MOV A,C
          setAccumulator(getRegister(2));
          break;
        case '7a':
        // MOV A,D
          setAccumulator(getRegister(3));
          break;
        case '7b':
        // MOV A,E
          setAccumulator(getRegister(4));
          break;
        case '7c':
        // MOV A,H
          setAccumulator(getRegister(5));
          break;
        case '7d':
        // MOV A,L
          setAccumulator(getRegister(6));
          break;
        case '7e':
        // MOV A,M
          setAccumulator(int.parse(getMemory(getRegister(6)), radix: 16));
          break;
        case '7f':
        // MOV A,A
          setAccumulator(getAccumulator());
          break;
        case '80':
        // ADD B
          add(getRegister(1));
          break;
        case '81':
        // ADD C
          add(getRegister(2));
          break;
        case '82':
        // ADD D
          add(getRegister(3));
          break;
        case '83':
        // ADD E
          add(getRegister(4));
          break;
        case '84':
        // ADD H
          add(getRegister(5));
          break;
        case '85':
        // ADD L
          add(getRegister(6));
          break;
        case '86':
        // ADD M
          add(int.parse(getMemory(getRegister(6)), radix: 16));
          break;
        case '87':
        // ADD A
          add(getAccumulator());
          break;
        case '88':
        // ADC B
          addWithCarry(getRegister(1));
          break;
        case '89':
        // ADC C
          addWithCarry(getRegister(2));
          break;
        case '8a':
        // ADC D
          addWithCarry(getRegister(3));
          break;
        case '8b':
        // ADC E
          addWithCarry(getRegister(4));
          break;
        case '8c':
        // ADC H
          addWithCarry(getRegister(5));
          break;
        case '8d':
        // ADC L
          addWithCarry(getRegister(6));
          break;
        case '8e':
        // ADC M
          addWithCarry(int.parse(getMemory(getRegister(6)), radix: 16));
          break;
        case '8f':
        // ADC A
          addWithCarry(getAccumulator());
          break;
        case '90':
        // SUB B
          subtract(getRegister(1));
          break;
        case '91':
        // SUB C
          subtract(getRegister(2));
          break;
        case '92':
        // SUB D
          subtract(getRegister(3));
          break;
        case '93':
        // SUB E
          subtract(getRegister(4));
          break;
        case '94':
        // SUB H
          subtract(getRegister(5));
          break;
        case '95':
        // SUB L
          subtract(getRegister(6));
          break;
        case '96':
        // SUB M
          subtract(int.parse(getMemory(getRegister(6)), radix: 16));
          break;
        case '97':
        // SUB A
          subtract(getAccumulator());
          break;
        case '98':
        // SBB B
          subtractWithBorrow(getRegister(1));
          break;
        case '99':
        // SBB C
          subtractWithBorrow(getRegister(2));
          break;
        case '9a':
        // SBB D
          subtractWithBorrow(getRegister(3));
          break;
        case '9b':
        // SBB E
          subtractWithBorrow(getRegister(4));
          break;
        case '9c':
        // SBB H
          subtractWithBorrow(getRegister(5));
          break;
        case '9d':
        // SBB L
          subtractWithBorrow(getRegister(6));
          break;
        case '9e':
        // SBB M
          subtractWithBorrow(int.parse(getMemory(getRegister(6)), radix: 16));
          break;
        case '9f':
        // SBB A
          subtractWithBorrow(getAccumulator());
          break;
        case 'a0':
        // ANA B
          and(getRegister(1));
          break;
        case 'a1':
        // ANA C
          and(getRegister(2));
          break;
        case 'a2':
        // ANA D
          and(getRegister(3));
          break;
        case 'a3':
        // ANA E
          and(getRegister(4));
          break;
        case 'a4':
        // ANA H
          and(getRegister(5));
          break;
        case 'a5':
        // ANA L
          and(getRegister(6));
          break;
        case 'a6':
        // ANA M
          and(int.parse(getMemory(getRegister(6)), radix: 16));
          break;
        case 'a7':
        // ANA A
          and(getAccumulator());
          break;
        case 'a8':
        // XRA B
          xor(getRegister(1));
          break;
        case 'a9':
        // XRA C
          xor(getRegister(2));
          break;
        case 'aa':
        // XRA D
          xor(getRegister(3));
          break;
        case 'ab':
        // XRA E
          xor(getRegister(4));
          break;
        case 'ac':
        // XRA H
          xor(getRegister(5));
          break;
        case 'ad':
        // XRA L
          xor(getRegister(6));
          break;
        case 'ae':
        // XRA M
          xor(int.parse(getMemory(getRegister(6)), radix: 16));
          break;
        case 'af':
        // XRA A
          xor(getAccumulator());
          break;
        case 'b0':
        // ORA B
          or(getRegister(1));
          break;
        case 'b1':
        // ORA C
          or(getRegister(2));
          break;
        case 'b2':
        // ORA D
          or(getRegister(3));
          break;
        case 'b3':
        // ORA E
          or(getRegister(4));
          break;
        case 'b4':
        // ORA H
          or(getRegister(5));
          break;
        case 'b5':
        // ORA L
          or(getRegister(6));
          break;
        case 'b6':
        // ORA M
          or(int.parse(getMemory(getRegister(6)), radix: 16));
          break;
        case 'b7':
        // ORA A
          or(getAccumulator());
          break;
        case 'b8':
        // CMP B
          compare(getRegister(1));
          break;
        case 'b9':
        // CMP C
          compare(getRegister(2));
          break;
        case 'ba':
        // CMP D
          compare(getRegister(3));
          break;
        case 'bb':
        // CMP E
          compare(getRegister(4));
          break;
        case 'bc':
        // CMP H
          compare(getRegister(5));
          break;
        case 'bd':
        // CMP L
          compare(getRegister(6));
          break;
        case 'be':
        // CMP M
          compare(int.parse(getMemory(getRegister(6)), radix: 16));
          break;
        case 'bf':
        // CMP A
          compare(getAccumulator());
          break;
        case 'c0':
        // RNZ
          if (getZeroFlag() == false) {
            jump(getRegister(7));
          }
          break;
        case 'c1':
        // POP B
          pop(1);
          break;
        case 'c2':
        // JNZ
          if (getZeroFlag() == false) {
            jump(int.parse(getMemory(getRegister(7)), radix: 16));
          }
          break;
        case 'c3':
        // JMP
          jump(int.parse(getMemory(getRegister(7)), radix: 16));
          break;
        case 'c4':
        // CNZ
          if (getZeroFlag() == false) {
            call(int.parse(getMemory(getRegister(7)), radix: 16));
          }
          break;
        case 'c5':
        // PUSH B
          push(1);
          break;
        case 'c6':
        // ADI
          add(int.parse(getMemory(getRegister(7)), radix: 16));
          break;
        case 'c7':
        // RST 0
          reset();
          break;
        case 'c8':
        // RZ
          if (getZeroFlag() == true) {
            jump(getRegister(7));
          }
          break;
        case 'c9':
        // RET
          return;
          break;
        case 'ca':
        // JZ
          if (getZeroFlag() == true) {
            jump(int.parse(getMemory(getRegister(7)), radix: 16));
          }
          break;
        case 'cb':
        // NOP
          break;
        case 'cc':
        // CZ
          if (getZeroFlag() == true) {
            call(int.parse(getMemory(getRegister(7)), radix: 16));
          }
          break;
        case 'cd':
        // CALL
          call(int.parse(getMemory(getRegister(7)), radix: 16));
          break;
        case 'ce':
        // ACI
          addWithCarry(int.parse(getMemory(getRegister(7)), radix: 16));
          break;
        case 'cf':
        // RST 1
          reset();
          break;
        case 'd0':
        // RNC
          if (getCarryFlag() == false) {
            jump(getRegister(7));
          }
          break;
        case 'd1':
        // POP D
          pop(3);
          break;
        case 'd2':
        // JNC
          if (getCarryFlag() == false) {
            jump(int.parse(getMemory(getRegister(7)), radix: 16));
          }
          break;
        case 'd3':
        // OUT
          output(int.parse(getMemory(getRegister(7)), radix: 16));
          break;
        case 'd4':
        // CNC
          if (getCarryFlag() == false) {
            call(int.parse(getMemory(getRegister(7)), radix: 16));
          }
          break;
        case 'd5':
        // PUSH D
          push(3);
          break;
        case 'd6':
        // SUI
          subtract(int.parse(getMemory(getRegister(7)), radix: 16));
          break;
        case 'd7':
        // RST 2
          reset();
          break;
        case 'd8':
        // RC
          if (getCarryFlag() == true) {
            jump(getRegister(7));
          }
          break;
        case 'd9':
        // NOP
          break;
        case 'da':
        // JC
          if (getCarryFlag() == true) {
            jump(int.parse(getMemory(getRegister(7)), radix: 16));
          }
          break;
        case 'db':
        // IN
          input(int.parse(getMemory(getRegister(7)), radix: 16));
          break;
        case 'dc':
        // CC
          if (getCarryFlag() == true) {
            call(int.parse(getMemory(getRegister(7)), radix: 16));
          }
          break;
        case 'dd':
        // NOP
          break;
        case 'df':
        // RST 3
          reset();
          break;
      }
    }
  }

  void add(int value) {
    int result = getAccumulator() + value;
    setAccumulator(result);
    setFlags(result);
  }

  void addWithCarry(int value) {
    int result = (getAccumulator() + value + int.parse(getCarryFlag().toString())).toInt();
    setAccumulator(result);
    setFlags(result);
  }

  void subtract(int value) {
    int result = getAccumulator() - value;
    setAccumulator(result);
    setFlags(result);
  }

  void subtractWithBorrow(int value) {
    int result = (getAccumulator() - value - int.parse(getCarryFlag().toString())).toInt();
    setAccumulator(result);
    setFlags(result);
  }

  void and(int value) {
    int result = getAccumulator() & value;
    setAccumulator(result);
    setFlags(result);
  }

  void xor(int value) {
    int result = getAccumulator() ^ value;
    setAccumulator(result);
    setFlags(result);
  }



  void or(int value) {
    int result = getAccumulator() | value;
    setAccumulator(result);
    setFlags(result);
  }

  void compare(int value) {
    int result = getAccumulator() - value;
    setFlags(result);
  }

  void jump(int value) {
    setRegister(7, value);
  }

  void call(int value) {
    push(getRegister(7));
    jump(value);
  }

  void pop(int register) {
    setRegister(register, int.parse(getMemory(getRegister(7)), radix: 16));
    setRegister(7, int.parse(getMemory(getRegister(7)), radix: 16) + 2);
  }

  void push(int value) {
    setRegister(7, int.parse(getMemory(getRegister(7)), radix: 16) - 2);
    setMemory(getRegister(7), value.toRadixString(16));
  }

  void output(int value) {
    //print(value);
  }

  void input(int value) {
    //print('Input: ');
   // String input = stdin.readLineSync();
    //setMemory(value, input);
  }









  void setFlags(int value) {
    if (value > 255) {
      setCarryFlag(true);
      setZeroFlag(false);
      setSignFlag(true);
    } else if (value == 0) {
      setCarryFlag(false);
      setZeroFlag(true);
      setSignFlag(false);
    } else {
      setCarryFlag(false);
      setZeroFlag(false);
      setSignFlag(false);
    }
  }

  void setCarryFlag(bool value) {
    _carryFlag = value;
  }

  void setZeroFlag(bool value) {
    _zeroFlag = value;
  }

  void setSignFlag(bool value) {
    _signFlag = value;
  }

  bool getCarryFlag() {
    return _carryFlag;
  }

  bool getZeroFlag() {
    return _zeroFlag;
  }

  bool getSignFlag() {
    return _signFlag;
  }



}