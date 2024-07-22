class Article < ApplicationRecord
    include Visible
    belongs_to :user, foreign_key: 'created_by'
    def as_json(options = {})
      super(options.merge(include: { user: { only: [:id, :name, :email] } }))
    end
  
    has_many :comments, dependent: :destroy
    
    validates :title, presence: true, length: { minimum: 5 }
    validates :body, presence: true, length: { minimum: 10 }
    has_and_belongs_to_many :tags
    accepts_nested_attributes_for :tags, allow_destroy: true, reject_if: :all_blank
    validate :must_have_at_least_one_tag

  private

  def must_have_at_least_one_tag
    errors.add(:tags, "must have at least one tag") if tags.empty?
  end
    
  
  end
  