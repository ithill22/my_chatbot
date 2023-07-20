class CreateResumeInfos < ActiveRecord::Migration[7.0]
  def change
    create_table :resume_ingos do |t|
      t.string :question
      t.text :answer

      t.timestamps
    end
  end
end
