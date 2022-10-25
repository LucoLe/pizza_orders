require 'test_helper'

class OrdersHelperTest < ActionView::TestCase
  test "format_array returns '-' if array is empty" do
    assert_equal '-', format_array([])
  end

  test "format_array joins array values" do
    assert_equal '1, 2, 3', format_array([1, 2, 3])
  end

  test "formats pric" do
    assert_equal '9.50€', format_price(9.5)
  end

  test "format date" do
    assert_equal 'April 14, 2021 13:17', format_datetime('2021-04-14T13:17:25Z')
  end
end
