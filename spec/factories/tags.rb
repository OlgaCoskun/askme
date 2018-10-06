FactoryBot.define do
  factory :tag do
    association :questions

    username {"hashtag_#{%[#exmpl #test #test2 ].sample}"}
  end
end