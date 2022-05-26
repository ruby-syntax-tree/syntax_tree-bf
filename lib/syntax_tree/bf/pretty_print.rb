# frozen_string_literal: true

module SyntaxTree
  module Bf
    class PrettyPrint < Visitor
      attr_reader :q

      def initialize(q)
        @q = q
      end

      def visit_root(node)
        visit_node("root", node)
      end

      def visit_loop(node)
        visit_node("loop", node)
      end

      def visit_increment(node)
        visit_node("increment", node)
      end

      def visit_decrement(node)
        visit_node("decrement", node)
      end

      def visit_shift_right(node)
        visit_node("shift_right", node)
      end

      def visit_shift_left(node)
        visit_node("shift_left", node)
      end

      def visit_input(node)
        visit_node("input", node)
      end

      def visit_output(node)
        visit_node("output", node)
      end

      private

      def visit_node(name, node)
        q.group do
          q.text("(")
          q.text(name)

          if node.child_nodes.any?
            q.nest(2) do
              q.breakable
              q.seplist(node.child_nodes) { |child_node| visit(child_node) }
            end

            q.breakable("")
          end

          q.text(")")
        end
      end
    end
  end
end
