class CreateJoinTableQuestionTag < ActiveRecord::Migration[5.1]
  def change
    create_join_table :questions, :tags do |t|
      t.index [:question_id, :tag_id]
    end
  end
end
