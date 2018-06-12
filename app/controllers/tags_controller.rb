class TagsController < ApplicationController
  # before_action :set_question, only: [:create, :destroy]
  # before_action :set_tag, only: [:destroy]
  #
  # def create
  #   @new_tag = @question.tags.build(tag_params)
  #
  #   if @new_tag.save
  #     redirect_to @question, notice: ('tag was saved')
  #   else
  #     render 'question/show', alert: ('something is wrong')
  #   end
  # end
  #
  # def destroy
  # end
  #
  # private
  # def set_question
  #   @question = Question.find(params[:question_id])
  # end
  #
  # def set_tag
  #   @tag = @question.tags.find(params[:id])
  # end
  #
  # def tag_params
  #   params.require(:tag).permit(:name)
  # end
end
