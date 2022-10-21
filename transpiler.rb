# frozen_string_literal: true

require_relative 'commands'

class Transpiler
  include Commands
  COMMANDS = {
    '>' => IncrementCommand.new('ip', :+, 1),
    '<' => IncrementCommand.new('ip', :-, 1),
    '+' => IncrementCommand.new('tape[ip]', :+, 1),
    '-' => IncrementCommand.new('tape[ip]', :-, 1),
    '.' => PrintCommand.new,
    ',' => ReadCommand.new,
    '[' => WhileCommand.new,
    ']' => EndWhileCommand.new
  }.freeze

  def initialize(tape_size = 30_000)
    @start_cmd = StartProgramCommand.new(tape_size)
  end

  def generate_program(code)
    lines = generate_lines(code)
    condense_lines(lines).map(&:to_code).join(";\n")
  end

  private

  def generate_lines(code)
    cmds = code.chars.filter_map { |c| COMMANDS.fetch(c, nil) }
    [@start_cmd] + cmds
  end

  def condense_lines(lines)
    lines.chunk_while(&:==).map(&method(:reduce)).flatten
  end

 def reduce(chunk)
    return chunk unless can_be_reduced?(chunk)

    chunk[0].amount = chunk.length
    chunk[0]
  end

  def can_be_reduced?(chunk)
    chunk.length > 1 and chunk[0].is_a? IncrementCommand
  end
end
