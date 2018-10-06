require 'openssl'

class User < ApplicationRecord

  before_validation :downcase_username  # запускаем метод перевода username в нижний регистр перед валидацией

  # параметры работы модуля шифрования паролей
  ITERATIONS = 20000
  DIGEST = OpenSSL::Digest::SHA256.new

  has_many :questions, dependent: :destroy

  validates :email, :username, presence: true
  validates :email, :username, uniqueness: true

  # Проверка для поля color
  validates :color, format: {with: /\A#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})\z/}

  # Проверка формата электронной почты пользователя
  validates_format_of :email, :with => /@/

  # Проверка максимальной длины юзернейма пользователя (не больше 40 символов)
  # Проверка формата юзернейма пользователя (только латинские буквы, цифры, и знак _)
  validates_format_of :username, with: /^[a-z0-9_]+/
  validates :username, length: { maximum: 40 }

  # before_save { username.downcase! }

  def downcase_username
    self.username = self.username.try(:downcase)
  end


  attr_accessor :password

  validates_presence_of :password, on: :create
  validates_confirmation_of :password

  before_save :encrypt_password

  def encrypt_password
    if self.password.present?
      # создаем т.н. "соль" - рандомная строка усложняющая задачу хакерам
      self.password_salt = User.hash_to_string(OpenSSL::Random.random_bytes(16))

      # создаем хеш пароля - длинная уникальная строка, из которой невозможно восстановить
      # исходный пароль
      self.password_hash = User.hash_to_string(
        OpenSSL::PKCS5.pbkdf2_hmac(self.password, self.password_salt, ITERATIONS, DIGEST.length, DIGEST)
      )
    end
  end

  # служебный метод, преобразующий бинарную строку в 16-ричный формат, для удобства хранения
  def self.hash_to_string(password_hash)
    password_hash.unpack('H*')[0]
  end

  def self.authenticate(email, password)
    user = find_by(email: email) # сперва находим кандидатов по email

    # ОБРАТИТЕ внимание: сравнивается password_hash, а оригинальный пароль так никогда
    # и не сохраняется нигде!
    if user.present? && user.password_hash == User.hash_to_string(OpenSSL::PKCS5.pbkdf2_hmac(password, user.password_salt, ITERATIONS, DIGEST.length, DIGEST))
      user
    else
      nil
    end
  end
end
