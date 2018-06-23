class TagsController < ApplicationController

  def show
    @all_hashtags = Tag.all

    @tag = Tag.find_by(name: params[:name])
    @questions_with_hashtags = @tag.question.to_a
  end
end
