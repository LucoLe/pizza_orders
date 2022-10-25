module CalculateOrderPrice
  CONFIG = YAML.safe_load(File.read('lib/config/config.yml'))

  extend self

  def execute(order)
    items_price =
      items_price(order['items'], order['promotionCodes'])

    extra_ingredients_price = extra_ingredients_price(order['items'])

    total = apply_discount(items_price + extra_ingredients_price, order['discountCode'])
    total.round(2)
  end

  private

  def items_price(items, promotion_codes)
    grouped_items =
      items.group_by { |item| "#{item['name']}_#{item['size']}" }

    grouped_items.transform_values! do |value|
      item = value.first
      size_miltiplier = CONFIG.dig('size_multipliers', item['size'])
      item_base_price = CONFIG.dig('pizzas', item['name'])

      { quantity: value.size,
        unit_price: item_base_price * size_miltiplier }
    end

    apply_promotions(grouped_items, promotion_codes)

    grouped_items.reduce(0) { |total, (_, value)| total + value[:quantity] * value[:unit_price] }
  end

  def apply_promotions(items, promotion_codes)
    promotion_codes.each do |code|
      promotion = CONFIG.dig('promotions', code)
      target_item = "#{promotion['target']}_#{promotion['target_size']}"

      next unless items.key?(target_item)

      quantity = items[target_item][:quantity]
      items[target_item][:quantity] =
        quantity / promotion['from'] * promotion['to'] +
        quantity % promotion['from']
    end
  end

  def extra_ingredients_price(items)
    items.reduce(0) do |total, item|
      size_miltiplier = CONFIG.dig('size_multipliers', item['size'])

      total + item['add'].reduce(0) do |sub_total, ingredient|
        ingredient_base_price = CONFIG.dig('ingredients', ingredient)

        sub_total + ingredient_base_price * size_miltiplier
      end
    end
  end

  def apply_discount(total, discount_code)
    deduction_in_percent = CONFIG.dig('discounts', discount_code, 'deduction_in_percent') || 0
    discount_multiplier = (100.0 - deduction_in_percent) / 100

    total * discount_multiplier
  end
end
