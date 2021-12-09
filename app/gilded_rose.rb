# frozen_string_literal: true

# class GildedRose
class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      item_name(item)
      item.sell_in = item.sell_in - 1 if item.name != 'Sulfuras, Hand of Ragnaros'
      aged_brie(item) if item.sell_in.negative?
      conjured(item)
      quality_rules(item)
    end
  end

  def item_name(item)
    if (item.name != 'Aged Brie') && (item.name != 'Backstage passes to a TAFKAL80ETC concert')
      item.quality = item.quality - 1 if item.quality.positive? && (item.name != 'Sulfuras, Hand of Ragnaros')
    elsif item.quality < 50
      item.quality = item.quality + 1
      backstage_passes(item)
    end
  end

  def backstage_passes(item)
    return unless item.name == 'Backstage passes to a TAFKAL80ETC concert'
    return unless item.sell_in < 11 && (item.quality < 50)
    item.quality = item.quality + 1
    return unless item.sell_in < 6 && (item.quality < 50)
    item.quality = item.quality + 1
  end

  def aged_brie(item)
    if item.name != 'Aged Brie'
      quality(item)
    elsif item.quality < 50
      item.quality = item.quality + 1
    end
  end

  def quality(item)
    if item.name != 'Backstage passes to a TAFKAL80ETC concert'
      item.quality = item.quality - 1 if item.quality.positive? && (item.name != 'Sulfuras, Hand of Ragnaros')
    else
      item.quality -= item.quality
    end
  end

  def conjured(item)
    return unless item.name == 'Conjured'
    item.quality = item.quality - 1
    return unless item.sell_in.negative?
    item.quality = item.quality - 1
  end

  def quality_rules(item)
    item.quality = 50 if item.quality > 50
    item.quality = 0 if item.quality.negative?
  end
end

# Class Item
class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end

items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 8, 10)]
GildedRose.new(items).update_quality
puts(items)
