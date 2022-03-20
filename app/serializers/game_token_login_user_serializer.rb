# frozen_string_literal: true

class GameTokenLoginUserSerializer < ApplicationSerializer
  attributes 	:id,
              :username,
              :name,
              :avatar_template,
              :admin,
              :moderator,
              :email
  def name
    Hash === user ? user[:name] : user.try(:name)
  end

  def avatar_template
    if Hash === object
      User.avatar_template(user[:username], user[:uploaded_avatar_id])
    else
      user&.avatar_template
    end
  end

  def user
    object[:user] || object.try(:user) || object
  end
end
