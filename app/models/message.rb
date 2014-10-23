class Message
  include ActiveAttr::Model
  include ActiveAttr::TypecastedAttributes

  attribute :name
  attribute :email
  attribute :content

  validates_presence_of :name, :email, :content
  validates_length_of :content, :maximum => 1500
end