require "pry"

def find_item_by_name_in_collection(name, collection)
  collection.find {|item_hash| item_hash.values.first == name}
  # Implement me first!
  #
  # Consult README for inputs and outputs
end

def consolidate_cart(cart)
  consolidated_cart = []
  cart.each do |coupon_item|
    item_name = coupon_item.values.first
    item = find_item_by_name_in_collection(item_name, consolidated_cart)

    if item
      item[:count] += 1
    else
      new_item = coupon_item
      new_item[:count] = 1
      consolidated_cart << new_item
    end
  end
  consolidated_cart

  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    item_name = coupon.values.first
    item = find_item_by_name_in_collection(item_name, cart)

    if item && item[:count] >= coupon[:num]
      coupon_item_name = "#{item_name} W/COUPON"
      couponed_item = find_item_by_name_in_collection(coupon_item_name, cart)

      if couponed_item
        couponed_item[:count] += coupon[:num]
      else
        couponed_item = {
          item: coupon_item_name,
          price: coupon[:cost] / coupon[:num],
          clearance: item[:clearance],
          count: coupon[:num]
        }
        cart << couponed_item
      end

      item[:count] -= coupon[:num]
    end
  end
  cart
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
end

def apply_clearance(cart)
  cart.each do |item|
    if item[:clearance]
      item[:price] = (item[:price] * 0.8).round(2)
    end
  end
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
end

def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  couponed_cart = apply_coupons(consolidated_cart, coupons)
  final_cart = apply_clearance(couponed_cart)

  total = 0
  final_cart.each do |item|
    total += item[:price] * item[:count]
  end
  total > 100 ? total * 0.9 : total

  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
end
