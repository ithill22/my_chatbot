class RenameResumeIngoToResumeInfo < ActiveRecord::Migration[7.0]
  def change
    rename_table :resume_ingos, :resume_infos
  end
end
