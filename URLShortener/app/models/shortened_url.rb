# == Schema Information
#
# Table name: shortened_urls
#
#  id         :bigint(8)        not null, primary key
#  long_url   :string           not null
#  short_url  :string           not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ShortenedUrl < ApplicationRecord
  validates :long_url, uniqueness: true, presence: true 

  def self.random_code
    new_code = SecureRandom.urlsafe_base64
    while ShortenedUrl.exists?(short_url: new_code)
      new_code =SecureRandom.urlsafe_base64
    end
    new_code
  end

  def self.create!(user,long_url)
    short_url = "app.aca/#{ShortenedUrl.random_code}"
    ShortenedUrl.new(short_url: short_url, long_url: long_url, user_id: user.id)
  end

  belongs_to :submitter,
    class_name: 'User',
    primary_key: :id,
    foreign_key: :user_id

  has_many :clicks,
    class_name: 'Visit',
    primary_key: :id,
    foreign_key: :shortened_url_id

  has_many :users,
    through: :clicks,
    source: :visitor

end
