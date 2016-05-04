class User < ActiveRecord::Base
  has_many :comments

  def self.from_omniauth(auth_hash)
    user = find_or_create_by(uid: auth_hash['uid'], provider: auth_hash['provider'])
    user.update(
      name: auth_hash['info']['name'],
      img_url: auth_hash['info']['image'],
      url: auth_hash['info']['urls']['Twitter']
    )
    return user
  end
end
