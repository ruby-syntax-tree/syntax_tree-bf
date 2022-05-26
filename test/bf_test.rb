# frozen_string_literal: true

require "test_helper"

module SyntaxTree
  class BfTest < Minitest::Test
    def test_formatting
      assert_equal(
        Bf.read(fixture("formatted.bf")),
        Bf.format(Bf.read(fixture("unformatted.bf")))
      )
    end

    def test_pretty_print
      result =
        PrettierPrint.format(+"", 80) do |q|
          Bf.parse(Bf.read(fixture("unformatted.bf"))).pretty_print(q)
        end

      refute_includes(result, "#<")
    end

    def test_evaluate
      %w[unformatted.bf formatted.bf].each do |name|
        stdout = StringIO.new
        Bf::Evaluate.run(Bf.read(fixture(name)), stdout: stdout)

        assert_equal("Hello World!\n", stdout.string)
      end
    end

    private

    def fixture(name)
      File.join(File.expand_path("fixture", __dir__), name)
    end
  end
end
