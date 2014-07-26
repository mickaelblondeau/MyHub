class Message < ActiveRecord::Base
  validates_presence_of :owner_id
  validates_presence_of :user_id
  validates_presence_of :message
  belongs_to :owner, foreign_key: :owner_id, class_name: :User
  belongs_to :user

  def to_param
    Encoder::encode_id(id)
  end

  before_create do
    if user == nil
      false
    end
  end
end