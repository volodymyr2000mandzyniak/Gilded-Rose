#!/usr/bin/ruby -w
# frozen_string_literal: true

require_relative 'lib/gilded_rose'
require_relative 'lib/item'

puts 'OMGHAI!'
items = [
  Item.new('+5 Dexterity Vest', 10, 20),
  Item.new('Aged Brie', 2, 0),
  Item.new('Elixir of the Mongoose', 5, 7),
  Item.new('Sulfuras, Hand of Ragnaros', 0, 80),
  Item.new('Sulfuras, Hand of Ragnaros', -1, 80),

  Item.new('Backstage passes to a TAFKAL80ETC concert', 15, 20),
  Item.new('Backstage passes to a TAFKAL80ETC concert', 10, 49),
  Item.new('Backstage passes to a TAFKAL80ETC concert', 5, 49),

  Item.new('Conjured Mana Cake', 3, 6)
]

days = 2
days = ARGV[0].to_i + 1 if ARGV.size.positive?

gilded_rose = GildedRose.new items
(0...days).each do |day|
  puts "======== Day #{day} ========"
  puts 'Name'.ljust(42) + 'SellIn'.ljust(10) + 'Quality'.ljust(10)
  puts '-' * 60
  items.each do |item|
    puts item.name.ljust(42) + item.sell_in.to_s.ljust(10) + item.quality.to_s.ljust(10)
  end
  puts '-' * 60
  puts ''
  gilded_rose.update_quality
end





