# frozen_string_literal: true

require_relative 'transpiler'

def execute_and_print(program)
  eval(program)
  puts("\n#{'=' * 80}")
  puts program
end

def main
  code, outfile = ARGV
  ARGV.clear
  code ||= gets.chomp
  program = Transpiler.new.generate_program(code)

  if outfile.nil?
    execute_and_print(program)
  else
    File.open(outfile, 'w') { |file| file.write(program) }
  end
end

main if $PROGRAM_NAME == __FILE__
