require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  test 'should not save missing title' do
	article = Article.new
	article.content = 'content'
	assert_not article.save
  end
  
  test 'should not save missing content' do
	article = Article.new
	article.title = 'title'
	assert_not article.save
  end
  
  test 'should save correct article' do
	article = Article.new
	article.title = 'title'
	article.content = 'content'
	assert article.save
  end
end
