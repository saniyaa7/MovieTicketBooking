# frozen_string_literal: true

class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :age, :phone_no, :role

  def role
    object.role.role_name if object.role
  end
end
