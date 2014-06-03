require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  test 'should not save missing title' do
	article = Article.new
	article.content = 'content'
	article.playlist_id = 1
	assert_not article.save
  end
  
  test 'should not save missing content' do
	article = Article.new
	article.title = 'title'
	article.playlist_id = 1
	assert_not article.save
  end
  
  test 'should not save without playlist id' do
	article = Article.new
	article.title = 'title'
	article.content = 'content'
	assert_not article.save
  end
  
  test 'should save correct article' do
	article = Article.new
	article.title = 'title'
	article.content = 'content'
	article.playlist_id = 1
	assert article.save
  end
end
