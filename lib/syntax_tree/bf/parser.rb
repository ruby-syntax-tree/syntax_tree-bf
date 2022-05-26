# frozen_string_literal: true

module SyntaxTree
  module Bf
    # Parses the given source code into a syntax tree.
    class Parser
      class Error < StandardError
      end

      attr_reader :source

      def initialize(source)
        @source = source
      end

      def parse
        Root.new(nodes: parse_segment(source, 0), location: 0...source.length)
      end

      private

      def parse_segment(segment, offset)
        index = 0
        nodes = []

        while index < segment.length
          location = offset + index

          case segment[index]
          when "+"
            nodes << Increment.new(location: location...(location + 1))
            index += 1
          when "-"
            nodes << Decrement.new(location: location...(location + 1))
            index += 1
          when ">"
            nodes << ShiftRight.new(location: location...(location + 1))
            index += 1
          when "<"
            nodes << ShiftLeft.new(location: location...(location + 1))
            index += 1
          when "."
            nodes << Output.new(location: location...(location + 1))
            index += 1
          when ","
            nodes << Input.new(location: location...(location + 1))
            index += 1
          when "["
            matched = 1
            end_index = index + 1

            while matched != 0 && end_index < segment.length
              case segment[end_index]
              when "["
                matched += 1
              when "]"
                matched -= 1
              end

              end_index += 1
            end

            raise Error, "Unmatched start loop" if matched != 0

            content = segment[(index + 1)...(end_index - 1)]
            nodes << Loop.new(
              nodes: parse_segment(content, offset + index + 1),
              location: location...(offset + end_index)
            )

            index = end_index
          when "]"
            raise Error, "Unmatched end loop"
          else
            index += 1
          end
        end

        nodes
      end
    end
  end
end
