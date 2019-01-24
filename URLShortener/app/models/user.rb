# == Schema Information
#
# Table name: users
#
#  id    :bigint(8)        not null, primary key
#  email :string           not null
#

class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true

  has_many :submitted_urls,
    class_name: 'ShortenedUrl',
    primary_key: :id,
    foreign_key: :user_id

  has_many :views,
    class_name: 'Visit',
    primary_key: :id,
    foreign_key: :user_id

  has_many :visited_urls,
    through: :views,
    source: :shortened_url

end
