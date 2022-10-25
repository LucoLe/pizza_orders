module CompleteOrder
  extend self

  def execute(id)
    orders = ParseOrders.execute
    order = orders.find { |element| element['id'] == id }
    order['state'] = 'COMPLETE'

    File.write('lib/config/orders.json', orders.to_json)
  end
end
