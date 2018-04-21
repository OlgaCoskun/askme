class UsersController < ApplicationController

  before_action :load_user, except: [:index, :create, :new, :destroy]
  before_action :authorize_user, except: [:index, :new, :create, :show, :destroy]

  def index
    @users = User.all
  end

  def new
    # Если пользователь уже авторизован, ему не нужна новая учетная запись,
    # отправляем его на главную с сообщением.
    redirect_to root_url, alert: 'Вы уже залогинены' if current_user.present?

    # Иначе, создаем болванку нового пользователя.
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      # session[:user_id] = @user.id
      redirect_to user_path(@user), notice: 'Пользователь успешно зарегистрирован'
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'Данные обновлены'
    else
      render 'edit'
    end
  end

  def show
    @questions = @user.questions.order(created_at: :desc)

    @new_question = @user.questions.build

    # Создаем три переменные с количеством вопросов, отвеченных вопросов и
    # неотвеченных вопросов
    @questions_count = @questions.count
    @answers_count = @questions.where.not(answer: nil).count
    @unanswered_count = @questions_count - @answers_count
  end

  def destroy
    session[:user_id] = nil
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
  end

  private
  # Если загруженный из базы юзер и текущий залогиненный не совпадают — посылаем
  # его с помощью описанного в контроллере ApplicationController метода
  # reject_user.
  def authorize_user
    reject_user unless @user == current_user
  end

  def load_user
    @user ||= User.find params[:id]
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :username, :avatar_url, :color)
  end
end
