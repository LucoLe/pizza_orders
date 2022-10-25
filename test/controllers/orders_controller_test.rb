require "test_helper"

class OrdersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @parse_orders_mock = Minitest::Mock.new
    @parse_orders_mock.expect(:call, [])

    @complete_order_mock = Minitest::Mock.new
    @complete_order_mock.expect(:call, true, ['1'])
  end

  test "should get index" do
    ParseOrders.stub(:execute, @parse_orders_mock) do
      get orders_url

      assert_response :success
    end

    @parse_orders_mock.verify
  end

  test "should update an order" do
    CompleteOrder.stub(:execute, @complete_order_mock) do
      patch order_url(1)

      assert_redirected_to orders_url
    end

    @complete_order_mock.verify
  end
end
