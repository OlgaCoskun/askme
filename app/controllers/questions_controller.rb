class QuestionsController < ApplicationController
  before_action :load_question, only: [:edit, :update, :destroy]
  before_action :authorize_user, except: [:create]

  def edit
  end

  def create
    @question = Question.new(question_params)

    @question[:author_id] = current_user.id if current_user.present?

    # Проверяем капчу вместе с сохранением вопроса. Если в капче была допущена
    # ошибка, она будет добавлена в ошибки @question.errors.
    if check_captcha(@question) && check_hashtags && @question.save

      redirect_to user_path(@question.user), notice: 'Вопрос задан'
    else
      render :edit
    end
  end

  def update
    if @question.update(question_params) && check_hashtags
      redirect_to user_path(@question.user), notice: 'Вопрос сохранен'
    else
      render :edit
    end
  end

  def destroy
    user = @question.user
    @question.destroy
    redirect_to user_path(user), notice: 'Вопрос удален :('
  end

  private

  # Если загруженный из базы вопрос не пренадлежит и текущему залогиненному
  # пользователю — посылаем его с помощью описанного в контроллере
  # ApplicationController метода reject_user.
  def authorize_user
    reject_user unless @question.user == current_user
  end

  # Загружаем из базы запрошенный вопрос, находя его по params[:id].
  def load_question
    @question = Question.find(params[:id])
  end

  # Явно задаем список разрешенных параметров для модели Question. Мы говорим,
  # что у хэша params должен быть ключ :question. Значением этого ключа может
  # быть хэш с ключами: :user_id и :text. Другие ключи будут отброшены.
  def question_params
    # Защита от уязвимости: если текущий пользователь — адресат вопроса,
    # он может менять ответы на вопрос, ему доступно также поле :answer.
    if current_user.present? &&
      params[:question][:user_id].to_i == current_user.id
      params.require(:question).permit(:user_id, :text, :answer)
    else
      params.require(:question).permit(:user_id, :text)
    end
  end

  def check_captcha(model)
    current_user.present? || verify_recaptcha(model: model)
  end

  def check_hashtags
    reg = /#[\p{L}0-9_]{1,30}/
    hashtag_names = (@question.text + @question.answer.to_s).scan(reg)

    hashtag_names.each do |hashtag|
      tag = Tag.new
      if tag.nil?
        tag = Tag.save(name: hashtag)
        @question.tags << tag
      else
        tag.update(name: hashtag)
      end
    end
  end
end


# hashtag_names.each do |hashtag|
#   tag = Tag.new
#   if hashtag.nil?
#     tag = Tag.save(name: hashtag)
#     @question.tags << tag
#   else
#     tag.update(name: hashtag)
#   end
# end