# frozen_string_literal: true

require "bundler/gem_tasks"
require "rake/testtask"
require "syntax_tree/rake_tasks"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/*_test.rb"]
end

source_files = FileList["{lib,test}/**/*.rb"]
SyntaxTree::Rake::CheckTask.new { |t| t.source_files = source_files }
SyntaxTree::Rake::WriteTask.new { |t| t.source_files = source_files }

task default: :test
