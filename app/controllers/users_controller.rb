class UsersController < ApplicationController
  def index
    @users = [
      User.new(
            id: 1,
            name: 'Olga',
            username: 'ovin999',
            avatar_url: 'https://res.cloudinary.com/cloudolga/image/upload/v1521714435/3_min_ftaioz.jpg'
      ),
      User.new(
            id: 2,
            name: 'Abdullah',
            username: 'ordufatsa'
      )
    ]
  end

  def new
  end

  def edit
  end

  def show
    @user = User.new(
      name: 'Olga',
      username:'ovin999',
      avatar_url: 'https://res.cloudinary.com/cloudolga/image/upload/v1521714435/3_min_ftaioz.jpg'
    )

    @questions = [
      Question.new(text: 'Как дела?', created_at: Date.parse('27.03.2016')),
      Question.new(text: 'Как на счет поесть?', created_at: Date.parse('27.03.2016'))
    ]

    # Болванка для нового вопроса
    @new_question = Question.new
  end
end
