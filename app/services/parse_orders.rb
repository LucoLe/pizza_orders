module ParseOrders
  extend self

  def execute
    JSON.parse(File.read('lib/config/orders.json'))
  end
end
