class OrdersController < ApplicationController
  def index
    @orders = ParseOrders.execute.filter { |order| order['state'] == 'OPEN' }
  end

  def update
    CompleteOrder.execute(params[:id])

    redirect_to orders_path
  end
end
