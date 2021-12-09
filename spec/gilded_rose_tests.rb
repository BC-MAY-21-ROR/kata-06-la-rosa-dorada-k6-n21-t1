# frozen_string_literal: true

require File.join(File.dirname(__FILE__), 'gilded_rose')
require 'test/unit'

# Class TestUnitled
class TestUntitled < Test::Unit::TestCase
  @items = [
    Item.new('+5 Dexterity Vest', 10, 20),
    Item.new('Aged Brie', 2, 0),
    Item.new('Elixir of the Mongoose', 5, 7),
    Item.new('Sulfuras, Hand of Ragnaros', 0, 80),
    Item.new('Sulfuras, Hand of Ragnaros', -1, 80),
    Item.new('Backstage passes to a TAFKAL80ETC concert', 15, 20),
    Item.new('Backstage passes to a TAFKAL80ETC concert', 10, 49),
    Item.new('Backstage passes to a TAFKAL80ETC concert', 5, 49),
    # This Conjured item does not work properly yet
    Item.new('Conjured Mana Cake', 3, 6) # <-- :O
  ]
  @item_test = GildedRose.new(@items)

  def test_foo
    items = [Item.new('foo', 0, 0)]
    GildedRose.new(items).update_quality
    assert_equal items[0].name, 'fixme'
  end
end
