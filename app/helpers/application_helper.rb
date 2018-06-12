module ApplicationHelper
  def user_avatar(user)
    if user.avatar_url.present?
      user.avatar_url
    else
      asset_path 'avatar.png'
    end
  end

  def questions_count(question, krokodil, krokodila, krokodilov)
    number = question.count
    if number == nil || !number.is_a?(Numeric)
      number = 0
    end

    ostatok1 = number % 100  # вот сюда строку перенесла

    if ostatok1.between?(11, 14) # этот блок добавила)
      return "#{number} " + krokodilov
    end

    ostatok = number % 10

    # Для 1 — именительный падеж (Кто?/Что? — крокодил)
    if ostatok == 1
      return "#{number} " + krokodil
    end

    # Для 2-4 — родительный падеж (2 Кого?/Чего? — крокодилов)
    if ostatok.between?(2, 4)
      return "#{number} " + krokodila
    end

    # 5-9 или ноль — родительный падеж и множественное число (8 Кого?/Чего? —
    # крокодилов)

    if ostatok.between?(5, 9) || ostatok == 0
      return "#{number} " + krokodilov
    end
  end

  # Хелпер, рисующий span тэг с иконкой из font-awesome
  def fa_icon(icon_class)
    content_tag 'span', '', class: "fa fa-#{icon_class}"
  end

  # def word_with_tag(word)
  #   reg = /#[\p{L}0-9_]{1,55}/
  #   tag = @question.scan(reg)
  # end
end
