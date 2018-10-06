FactoryBot.define do
  factory :question do
    # связь с юзером и автором
    association :author, factory: :user
    association :tags

    # создаем вопрос
    text "test #test1 #test1 #test2"
    answer "example #example1 #example1 #example2"
  end
end