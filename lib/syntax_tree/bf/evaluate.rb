# frozen_string_literal: true

module SyntaxTree
  module Bf
    module Evaluate
      # Takes a bf syntax tree and compiles it down to a simple bytecode. The
      # instructions almost entirely map to the tree nodes except:
      #
      # * Root - replaced by its contents
      # * Loop - replaced by a jmz (jump if zero) and a jmp (unconditional jump)
      #
      class Compiler < Visitor
        attr_reader :insns

        def initialize
          @insns = []
        end

        def visit_root(node)
          super
        end

        def visit_loop(node)
          index = insns.length
          insns << [:jmz, -1]

          super

          insns << [:jmp, index]
          insns[index][1] = insns.length
        end

        def visit_increment(node)
          insns << [:inc]
        end

        def visit_decrement(node)
          insns << [:dec]
        end

        def visit_shift_right(node)
          insns << [:shr]
        end

        def visit_shift_left(node)
          insns << [:shl]
        end

        def visit_input(node)
          insns << [:inp]
        end

        def visit_output(node)
          insns << [:out]
        end
      end

      # This is the virtual machine that runs the set of instructions that the
      # compiler outputs. Its state is kept on an infinite tape of memory, which
      # is paired with a cursor.
      class Machine
        attr_reader :insns, :stdin, :stdout

        def initialize(insns, stdin: STDIN, stdout: STDOUT)
          @insns = insns
          @stdin = stdin
          @stdout = stdout
        end

        def run
          pc = 0

          tape = Hash.new { 0 }
          cursor = 0

          while pc < insns.length
            insn = insns[pc]
            pc += 1

            case insn
            in [:inc]
              tape[cursor] += 1
            in [:dec]
              tape[cursor] -= 1
            in [:shr]
              cursor += 1
            in [:shl]
              cursor -= 1
            in [:inp]
              tape[cursor] = stdin.getc.ord
            in [:out]
              stdout.putc(tape[cursor].chr)
            in [:jmz, offset]
              pc = offset if tape[cursor] == 0
            in [:jmp, offset]
              pc = offset
            end
          end

          tape
        end
      end

      def self.run(source, stdin: STDIN, stdout: STDOUT)
        compiler = Compiler.new
        Parser.new(source).parse.accept(compiler)
        Machine.new(compiler.insns, stdin: stdin, stdout: stdout).run
      end
    end
  end
end
