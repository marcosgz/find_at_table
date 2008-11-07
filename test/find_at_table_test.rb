require 'test/unit'

require 'find_at_table'
include FindAtTableHelper

class FindAtTableTest < Test::Unit::TestCase
  def test_should_invalid_value_at_format_columns
    assert_equal "'all'", format_columns("all")
    assert_equal "'all'", format_columns(["a","b"])
    assert_equal "'all'", format_columns([0..1])
    assert_equal "'all'", format_columns(:all)
  end
end
