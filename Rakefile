# frozen_string_literal: true

require 'json'

task default: [:run]

desc 'load the prices, order, payments, and execute it all!'
task 'run' do
  $LOAD_PATH.unshift(File.dirname(__FILE__), 'lib')
  require 'coffee_app'

  # load the data files into strings for you
  prices_json = File.read('data/prices.json')
  orders_json = File.read('data/orders.json')
  payments_json = File.read('data/payments.json')

  # call the app, passing the data as strings containing JSON
  result_json = CoffeeApp.call(prices_json, orders_json, payments_json)

  # turn the JSON back into a Ruby structure
  user_balances = JSON.parse(result_json)

  # pretty print the output
  puts 'Total:'
  puts 'user      orders     payments   balance'
  puts '---------------------------------------'
  user_balances.each do |user_balance|
    puts format(
      '%-10<user>s$%-10.2<orders>f$%-10.2<payments>f$%-10.2<balance>f',
      {
        user: user_balance['user'],
        orders: user_balance['order_total'],
        payments: user_balance['payment_total'],
        balance: user_balance['balance']
      }
    )
  end
end
