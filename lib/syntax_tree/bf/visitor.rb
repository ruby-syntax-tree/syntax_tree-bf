# frozen_string_literal: true

module SyntaxTree
  module Bf
    class Visitor
      def visit(node)
        node.accept(self)
      end

      def visit_all(nodes)
        nodes.map { |node| visit(node) }
      end

      def visit_child_nodes(node)
        visit_all(node.child_nodes)
      end

      # Visit a Root node.
      alias visit_root visit_child_nodes

      # Visit a Loop node.
      alias visit_loop visit_child_nodes

      # Visit an Increment node.
      alias visit_increment visit_child_nodes

      # Visit a Decrement node.
      alias visit_decrement visit_child_nodes

      # Visit a ShiftRight node.
      alias visit_shift_right visit_child_nodes

      # Visit a ShiftLeft node.
      alias visit_shift_left visit_child_nodes

      # Visit an Input node.
      alias visit_input visit_child_nodes

      # Visit an Output node.
      alias visit_output visit_child_nodes
    end
  end
end
