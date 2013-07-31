class CreateGrams < ActiveRecord::Migration
  def change
    create_table :grams do |i|
      i.string :text
      i.datetime :created_at
      i.string :filter
      i.belongs_to :username
      i.string :tags
      i.string :url
    end    
  end
end
