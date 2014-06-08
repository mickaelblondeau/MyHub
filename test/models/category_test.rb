require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  test 'should not save without icon' do
    category = Category.new
    assert_not category.save
  end

  test 'should not save with unvalid icon' do
    category = Category.new
    category.icon = File.new('test/fixtures/categories.yml')
    assert_not category.save
    category.icon = File.new('test/fixtures/bigfile.jpg')
    assert_not category.save
  end

  test 'should save' do
    category = Category.new
    category.icon = File.new('test/fixtures/test.gif')
    assert_not category.save
  end
end
