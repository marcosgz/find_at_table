require 'test/unit'
require 'find_at_table'
include FindAtTableHelper

class FindAtTableTest < Test::Unit::TestCase
  # Replace this with your real tests.
  def test_should_return_find_at_table_field
    assert_equal "teste", find_at_table_field
  end
end
