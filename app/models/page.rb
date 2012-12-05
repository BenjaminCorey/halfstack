class Page < ActiveRecord::Base
  attr_accessible :body, :slug, :title
  
  def to_param
    self.slug
  end
end
