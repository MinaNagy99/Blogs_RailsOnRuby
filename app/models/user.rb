class User < ApplicationRecord
    has_secure_password
    has_one_attached :image

    before_save :downcase_email
  
    validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: /@/ }
    validates :password, presence: true, length: { minimum: 6 }, on: :create
    validates :password_confirmation, presence: true, on: :create


  
    private
  
    def downcase_email
      self.email = self.email.delete(' ').downcase
    end
  
 


 

  
end