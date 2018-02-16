require "csv"
require "awesome_print"

FILE_NAME = "support/orders.csv"

module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def self.all
      all_orders = []
      CSV.read(FILE_NAME, 'r').each do |order|
        id = order[0].to_i
        product_hash = {}
        order[1].split(";").each do |product|
          product_array = product.split(":")
          product_hash[product_array[0]] = product_array[1].to_f
        end
        order_instance = Order.new(id, product_hash)
        all_orders << order_instance
      end
      all_orders
    end



    # def self.find(product)
    #   all_orders.each do |product|
    #
    # end

    def total
      result = 0
      @products.each_value do |value|
        result += value
      end
      result = result + (result * 0.075)
      return result.round(2)
    end

    def add_product(product_name, product_price)
      if @products.key?(product_name)
        return false
      else
        @products[product_name] = product_price
        return true
      end
    end

    def remove_product(product_name)
      if @products.key?(product_name)
        @products.delete(product_name)
        return true
      else
        return false
      end
    end
  end
end

firstOrder = Grocery::Order.new(1, {"Almonds": 22.8, "Wholewheat flour": 1.93, "Grape Seed Oil": 74.9})
print firstOrder
ap Grocery::Order.all
