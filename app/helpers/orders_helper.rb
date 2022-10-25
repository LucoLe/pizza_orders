module OrdersHelper
  def format_array(values)
    if values.blank?
      '-'
    else
      values.join(', ')
    end
  end

  def format_price(price)
    "#{format('%.2f', price)}€"
  end

  def format_datetime(datetime)
    DateTime.parse(datetime).to_fs(:long)
  end
end
