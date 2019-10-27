require 'pry'
def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  collection.select { |item| item[:item] == name}[0]
  # Consult README for inputs and outputs
end

def consolidate_cart(cart)
  # Consult README for inputs and outputs
  c_cart = []
  i = 0
  while i < cart.length
    found = find_item_by_name_in_collection(cart[i][:item], c_cart)
    if !found
      c_cart << cart[i]
      cart[i][:count] = 1
    else
      found[:count] += 1
    end
    i += 1
  end
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  c_cart
end

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  i = 0
  while i < coupons.length
    coupon_item = find_item_by_name_in_collection(coupons[i][:item], cart)
    new_item = {}
    if coupon_item && coupon_item[:count] >= coupons[i][:num]
      new_item[:item] = "#{coupon_item[:item]} W/COUPON"
      new_item[:price] = coupons[i][:cost]/coupons[i][:num]
      new_item[:clearance] = coupon_item[:clearance]
      new_item[:count] = coupons[i][:num] * (coupon_item[:count]/coupons[i][:num]).truncate
      coupon_item[:count] -= new_item[:count]
      cart << new_item
    end
    i += 1
  end
  cart
  # REMEMBER: This method **should** update cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  cart.each { |item| item[:price] = (item[:price] * 0.8).round(2) if item[:clearance] }
  # REMEMBER: This method **should** update cart
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  consolidated_cart = consolidate_cart(cart)
  apply_coupons(consolidated_cart, coupons)
  apply_clearance(consolidated_cart)
  total = 0
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
  consolidated_cart.each { |item| total += item[:price] * item[:count] }
  total > 100 ? total * 0.9 : total
end
