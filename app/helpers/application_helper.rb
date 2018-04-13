module ApplicationHelper
  def user_avatar(user)
    if user.avatar_url.present?
      user.avatar_url
    else
      asset_path 'avatar.png'
    end
  end

  def questions_count(question)
    number = question.count
    if number == nil || !number.is_a?(Numeric)
      number = 0
    end

    ostatok1 = number % 100  # вот сюда строку перенесла

    if ostatok1.between?(11, 14) # этот блок добавила)
      return "#{number} вопросов"
    end

    ostatok = number % 10

    # Для 1 — именительный падеж (Кто?/Что? — крокодил)
    if ostatok == 1
      return "#{number} вопрос"
    end

    # Для 2-4 — родительный падеж (2 Кого?/Чего? — крокодилов)
    if ostatok.between?(2, 4)
      return "#{number} вопроса"
    end

    # 5-9 или ноль — родительный падеж и множественное число (8 Кого?/Чего? —
    # крокодилов)

    if ostatok.between?(5, 9) || ostatok == 0
      return "#{number} вопросов"
    end
  end
end
