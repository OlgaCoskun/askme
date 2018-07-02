class Question < ApplicationRecord

  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true
  has_and_belongs_to_many :tags, dependent: :destroy # при удалении вопроса, удалять хештег

  validates :user, :text, presence: true
  # Проверка максимальной длины текста вопроса (максимум 255 символов)
  validates :text, length: {maximum: 255}

  def update_hashtags
    def update_hashtags
      self.tags.destroy_all

      (text + ' ' + answer.to_s).scan(/#[[:word:]]+/).uniq.each do |hashtag|
        self.tags << Tag.first_or_create_by!(name: hashtag.delete('#'))
      end
    end
  end
end
