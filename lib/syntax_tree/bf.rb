# frozen_string_literal: true

require "prettier_print"
require "syntax_tree"

require_relative "bf/nodes"
require_relative "bf/parser"
require_relative "bf/visitor"

require_relative "bf/evaluate"
require_relative "bf/format"
require_relative "bf/pretty_print"

module SyntaxTree
  module Bf
    def self.format(source, maxwidth = 80)
      PrettierPrint.format(+"", maxwidth) { |q| parse(source).format(q) }
    end

    def self.parse(source)
      Parser.new(source).parse
    end

    def self.read(source)
      File.read(source)
    end
  end

  register_handler(".bf", Bf)
end
