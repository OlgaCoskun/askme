class Tag < ApplicationRecord
  has_and_belongs_to_many :questions, dependent: :destroy

  validates :name, format: {with: /#[\p{L}0-9_]{1,55}/}
  validates :name, uniqueness: true
  validates :name, presence: true,
            uniqueness: {case_sensitive: false}

  before_validation :tag_name_downcase

  def tag_name_downcase
    self.name = name.downcase if name.present?
  end
end
