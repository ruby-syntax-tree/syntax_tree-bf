# SyntaxTree::Bf

[![Build Status](https://github.com/ruby-syntax-tree/syntax_tree-bf/actions/workflows/main.yml/badge.svg)](https://github.com/ruby-syntax-tree/syntax_tree-bf/actions/workflows/main.yml)
[![Gem Version](https://img.shields.io/gem/v/syntax_tree-bf.svg)](https://rubygems.org/gems/syntax_tree-bf)

[Syntax Tree](https://github.com/ruby-syntax-tree/syntax_tree) support for Brainf***.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "syntax_tree-bf"
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install syntax_tree-bf

## Usage

From code:

```ruby
require "syntax_tree/bf"

pp SyntaxTree::Bf.parse(source) # print out the AST
puts SyntaxTree::Bf.format(source) # format the AST
```

From the CLI:

```sh
$ stree ast --plugins=bf file.bf
(root
  (increment),
  ...
  (increment),
  (loop
    (shift_right),
    ...
    (decrement)
  ),
  (shift_right),
  ...
  (output)
)
```

or

```sh
$ stree format --plugins=bf file.bf
++++++++[
  >++++[>++>+++>+++>+<<<<-]>+>+>->>+[<]<-
]>>.>---.+++++++..+++.>>.<-.<.+++.------.--------.>>+.>++.
```

or

```sh
$ stree write --plugins=bf file.bf
file.bf 1ms
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ruby-syntax-tree/syntax_tree-bf.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
