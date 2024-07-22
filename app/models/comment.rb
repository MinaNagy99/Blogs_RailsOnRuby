class Comment < ApplicationRecord
  belongs_to :article
  belongs_to :user, foreign_key: :created_by, class_name: 'User'
  def as_json(options = {})
    super(options.merge(include: { user: { only: [:id, :name, :email] } }))
    end
  include Visible

end
