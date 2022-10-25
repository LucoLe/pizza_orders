class CalculateOrderPriceTest < ActiveSupport::TestCase
  def setup
    @orders = JSON.parse(File.read('test/fixtures/files/orders.json'))
  end

  test "calculates the price of an order item" do
    assert_equal 5.0, CalculateOrderPrice.execute(@orders['margherita'])
  end

  test "calculates the price of extra ingredients" do
    assert_equal 7.5, CalculateOrderPrice.execute(@orders['margheritaWithExtraIngredients'])
  end

  test "omitted ingredients don't change the price" do
    assert_equal 5.0, CalculateOrderPrice.execute(@orders['margheritaWithHoldIngredients'])
  end

  test "calculates the price of an order with many items" do
    assert_equal 28.75, CalculateOrderPrice.execute(@orders['orderWithManyItems'])
  end

  test "applies promotion" do
    assert_equal 17.15, CalculateOrderPrice.execute(@orders['orderWithPromoCode'])
  end

  test "applies discount" do
    assert_equal 10.45, CalculateOrderPrice.execute(@orders['orderWithDiscount'])
  end

  test "calculates the price of an order with many items, promotion code and discount code" do
    assert_equal 16.29, CalculateOrderPrice.execute(@orders['orderWithManyItemsPromoCodeAndDiscount'])
  end
end
