# frozen_string_literal: true

module Commands
  StartProgramCommand = Struct.new(:tape_size) do
    def to_code
      "tape = [0]*#{tape_size}; ip = 0;"
    end
  end

  IncrementCommand = Struct.new(:target, :sign, :amount) do
    def to_code
      "#{target} #{sign}= #{amount}"
    end
  end

  PrintCommand = Struct.new(nil) do
    def to_code
      'print tape[ip].chr'
    end
  end

  ReadCommand = Struct.new(nil) do
    def to_code
      'tape[ip] = $stdin.gets.ord'
    end
  end

  WhileCommand = Struct.new(nil) do
    def to_code
      'while(tape[ip] != 0) do'
    end
  end

  EndWhileCommand = Struct.new(nil) do
    def to_code
      'end'
    end
  end
end
