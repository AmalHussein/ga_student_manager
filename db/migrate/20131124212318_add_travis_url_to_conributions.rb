class AddTravisUrlToConributions < ActiveRecord::Migration
  def change
  	add_column :contributions, :travis_url, :string
  end
end
