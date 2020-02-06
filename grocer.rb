def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs
  collection.find {|el| el[:item] === name }
end

def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  consolidated = []
  cart.map do |old_el|
    consolidated_element = find_item_by_name_in_collection(old_el[:item], consolidated)
    if consolidated_element
      consolidated_element[:count] += 1
    else
      old_el[:count] = 1
      consolidated << old_el
    end
  end
  consolidated
end

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  coupons.each do |coupon|
    cart.each_with_index do |cart_el, i|
      if cart_el[:item] == coupon[:item] && cart_el[:count] >= coupon[:num]
        cart_el[:count] -= coupon[:num]
        cart[i] = cart_el
        cart << {item: "#{coupon[:item]} W/COUPON", price: coupon[:cost]/coupon[:num], clearance: cart_el[:clearance], count: coupon[:num] }
      end
    end
  end
  cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  cart.each_with_index do |el,i|
    if el[:clearance]
      el[:price] = el[:price]*0.8
      cart[i] = el
    end
  end
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  consolidated = consolidate_cart(cart)
  # * apply_coupons
  coupon_cart = apply_coupons(consolidated, coupons)
  # * apply_clearance
  clearance_cart = apply_clearance(coupon_cart)
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers

  total = 0
  clearance_cart.each {|el| total += el[:price]*el[:count]}
  total.round(1)
  if total > 100
    total.round(1) * 0.9
  else
    total.round(1)
  end
end
