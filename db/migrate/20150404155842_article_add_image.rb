class ArticleAddImage < ActiveRecord::Migration
  def up
    remove_column :articles, :image
    remove_column :articles, :image_url

    add_attachment :articles, :image
  end

  def down
    add_column :articles, :image
    add_column :articles, :image_url

    remove_attachment :articles, :image
  end
end
