class RenameResumeInfoToResumeInfos < ActiveRecord::Migration[7.0]
  def change
    rename_table :resume_info, :resume_infos
  end
end
