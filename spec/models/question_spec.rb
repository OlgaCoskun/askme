require 'rails_helper'

RSpec.describe Question, type: :model do

  # проверяем наличие валидаций в модели Question
  context 'validations check' do
    it { should validate_presence_of :text }
    it { should validate_presence_of :user }
  end

  # Создаем юзера через фабрику
  let(:user) {FactoryBot.create(:user)}

  # Создаем вопрос с юзером

end
