# frozen_string_literal: true

module SyntaxTree
  module Bf
    class Node
      def format(q)
        Format.new(q).visit(self)
      end

      def pretty_print(q)
        PrettyPrint.new(q).visit(self)
      end
    end

    # The root node of the syntax tree.
    class Root < Node
      attr_reader :nodes, :location

      def initialize(nodes:, location:)
        @nodes = nodes
        @location = location
      end

      def accept(visitor)
        visitor.visit_root(self)
      end

      def child_nodes
        nodes
      end

      alias deconstruct child_nodes

      def deconstruct_keys(keys)
        { nodes: nodes, location: location }
      end
    end

    # [ ... ]
    class Loop < Node
      attr_reader :nodes, :location

      def initialize(nodes:, location:)
        @nodes = nodes
        @location = location
      end

      def accept(visitor)
        visitor.visit_loop(self)
      end

      def child_nodes
        nodes
      end

      alias deconstruct child_nodes

      def deconstruct_keys(keys)
        { nodes: nodes, location: location }
      end
    end

    # +
    class Increment < Node
      attr_reader :location

      def initialize(location:)
        @location = location
      end

      def accept(visitor)
        visitor.visit_increment(self)
      end

      def child_nodes
        []
      end

      alias deconstruct child_nodes

      def deconstruct_keys(keys)
        { value: "+", location: location }
      end
    end

    # -
    class Decrement < Node
      attr_reader :location

      def initialize(location:)
        @location = location
      end

      def accept(visitor)
        visitor.visit_decrement(self)
      end

      def child_nodes
        []
      end

      alias deconstruct child_nodes

      def deconstruct_keys(keys)
        { value: "-", location: location }
      end
    end

    # >
    class ShiftRight < Node
      attr_reader :location

      def initialize(location:)
        @location = location
      end

      def accept(visitor)
        visitor.visit_shift_right(self)
      end

      def child_nodes
        []
      end

      alias deconstruct child_nodes

      def deconstruct_keys(keys)
        { value: ">", location: location }
      end
    end

    # <
    class ShiftLeft < Node
      attr_reader :location

      def initialize(location:)
        @location = location
      end

      def accept(visitor)
        visitor.visit_shift_left(self)
      end

      def child_nodes
        []
      end

      alias deconstruct child_nodes

      def deconstruct_keys(keys)
        { value: "<", location: location }
      end
    end

    # ,
    class Input < Node
      attr_reader :location

      def initialize(location:)
        @location = location
      end

      def accept(visitor)
        visitor.visit_input(self)
      end

      def child_nodes
        []
      end

      alias deconstruct child_nodes

      def deconstruct_keys(keys)
        { value: ",", location: location }
      end
    end

    # .
    class Output < Node
      attr_reader :location

      def initialize(location:)
        @location = location
      end

      def accept(visitor)
        visitor.visit_output(self)
      end

      def child_nodes
        []
      end

      alias deconstruct child_nodes

      def deconstruct_keys(keys)
        { value: ".", location: location }
      end
    end
  end
end
