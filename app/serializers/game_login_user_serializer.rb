# frozen_string_literal: true

class GameLoginUserSerializer < ApplicationSerializer
  attributes 	:id,
              :username,
              :name,
              :avatar_template,
              :admin,
              :moderator,
              :email,
              :login_auth_token
  def name
    Hash === user ? user[:name] : user.try(:name)
  end

  def include_name?
    SiteSetting.enable_names?
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

  def user_is_current_user
    object.id == scope.user&.id
  end

  def categories_with_notification_level(lookup_level)
    category_user_notification_levels.select do |id, level|
      level == CategoryUser.notification_levels[lookup_level]
    end.keys
  end

  def category_user_notification_levels
    @category_user_notification_levels ||= CategoryUser.notification_levels_for(user)
  end

  def tags_with_notification_level(lookup_level)
    tag_user_notification_levels.select do |id, level|
      level == TagUser.notification_levels[lookup_level]
    end.keys
  end

  def tag_user_notification_levels
    @tag_user_notification_levels ||= TagUser.notification_levels_for(user)
  end
  
  def login_auth_token
    last_token = {id:0}
    object.user_auth_tokens.each do |n|
      if n[:id] > last_token[:id]
        last_token = n
      end
    end
    last_token
  end
end
