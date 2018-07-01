class Question < ApplicationRecord

  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true
  has_and_belongs_to_many :tags, dependent: :destroy # при удалении вопроса, удалять хештег

  validates :user, :text, presence: true
  # Проверка максимальной длины текста вопроса (максимум 255 символов)
  validates :text, length: {maximum: 255}

  def update_hashtags
    self.tags.destroy_all #удаляем связи вопросов и хештегов

    reg = /#[\p{L}0-9_]{1,30}/

    hashtag_names = (self.text + ' ' + self.answer.to_s).scan(reg)
    hashtag_names.uniq!
    hashtag_names.map! {|hashtag| hashtag.delete('#')}

    hashtag_names.each do |hashtag|
      tag = Tag.where(name: hashtag).first
      tag = Tag.create(name: hashtag) if tag.nil?
      self.tags << tag
    end
  end
end
