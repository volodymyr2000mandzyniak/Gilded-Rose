# frozen_string_literal: true

class GildedRose
  MAX_QUALITY = 50
  MIN_QUALITY = 0
  LEGENDARY_ITEM_QUALITY = 80

  def initialize(items)
    @items = items
  end

  # Оновлення якості та терміну продажу для кожного предмета
  def update_quality
    @items.each do |item|
      update_item_quality(item)
      update_item_sell_in(item)
      handle_expired_item(item) if item.sell_in.negative?
    end
  end

  private

  # Оновлення якості для конкретного предмета залежно від його типу
  def update_item_quality(item)
    case item.name
    when 'Aged Brie'
      increase_quality(item)
    when 'Backstage passes to a TAFKAL80ETC concert'
      update_backstage_pass(item)
    when 'Sulfuras, Hand of Ragnaros'
      item.quality = LEGENDARY_ITEM_QUALITY
    when item.name.start_with?('Conjured')
      update_conjured_item(item)
    else
      decrease_quality(item)
    end
  end

  # Зменшення терміну продажу для всіх предметів, крім "Sulfuras"
  def update_item_sell_in(item)
    item.sell_in -= 1 unless item.name == 'Sulfuras, Hand of Ragnaros'
  end

  # Обробка предметів, термін продажу яких минув
  def handle_expired_item(item)
    case item.name
    when 'Aged Brie'
      increase_quality(item)
    when 'Backstage passes to a TAFKAL80ETC concert'
      item.quality = MIN_QUALITY
    else
      decrease_quality(item)
    end
  end

  # Збільшення якості предмета, якщо це можливо
  def increase_quality(item)
    item.quality += 1 if item.quality < MAX_QUALITY
  end

  # Зменшення якості предмета, якщо це можливо
  def decrease_quality(item)
    item.quality -= 1 if item.quality > MIN_QUALITY
  end

  # Оновлення якості для квитків на концерт, враховуючи спеціальні правила
  def update_backstage_pass(item)
    increase_quality(item)
    increase_quality(item) if item.sell_in < 11
    increase_quality(item) if item.sell_in < 6
  end

  # Оновлення якості для "Conjured" товарів
  def update_conjured_item(item)
    decrease_quality(item)
    decrease_quality(item) # Conjured items degrade twice as fast
  end
end
