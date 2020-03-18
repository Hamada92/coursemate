class ModifyAnswersQuestionId < ActiveRecord::Migration[5.0][5.0]
  def up
    execute <<-SQL
      begin;
        alter table answers drop constraint fk_rails_3d5ed4418f;

        alter table answers add constraint question_id_fkey
          foreign key (question_id) references questions(id) on delete restrict;
    SQL
  end
end
