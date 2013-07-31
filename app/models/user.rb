class User < ActiveRecord::Base
  has_many :instagrams
  accepts_nested_attributes_for :instagrams

  def fetch_instagrams!
    new_grams = Instagram.media_search("37.79221","-122.406141", count: 1)
    new_grams.each do |gram|
      p gram
      self.grams << Gram.create(
        text: gram.caption.text,
        created_at: gram.created_time,
        name: grams.caption.from.full_name,
        username: grams.caption.from.username,
        url: grams.images.standard_resolution,
        location: grams.location.latitude + grams.location.longitude,
        filter: grams.filter
        )
    end
  end
