class Link < ActiveRecord::Base
  validates :url, presence: true

  before_create :create_local_slug

  def create_local_slug
    self.visits = 0
    until local_slug && !Link.exists?(local_slug: local_slug)
      generate_random_slug
    end
    true
  end

  def generate_random_slug
    all_letters = ("a".."z").to_a
    self.local_slug = 8.times.map { all_letters.sample }.join
  end

  def local_path
    "/links/#{local_slug}"
  end
end
