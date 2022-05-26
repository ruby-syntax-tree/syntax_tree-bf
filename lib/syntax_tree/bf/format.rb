# frozen_string_literal: true

module SyntaxTree
  module Bf
    class Format < Visitor
      attr_reader :q

      def initialize(q)
        @q = q
      end

      def visit_root(node)
        super
        q.breakable(force: true)
      end

      def visit_loop(node)
        q.group do
          q.text("[")
          q.nest(2) do
            q.breakable("")
            super
          end
          q.breakable("")
          q.text("]")
        end
      end

      def visit_increment(node)
        q.text("+")
      end

      def visit_decrement(node)
        q.text("-")
      end

      def visit_shift_right(node)
        q.text(">")
      end

      def visit_shift_left(node)
        q.text("<")
      end

      def visit_input(node)
        q.text(",")
      end

      def visit_output(node)
        q.text(".")
      end
    end
  end
end
