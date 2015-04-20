class AddMediaToElectionarticles < ActiveRecord::Migration
  def change
    remove_column :election_articles, :image_urls
    add_attachment :election_articles, :image
  end
end
