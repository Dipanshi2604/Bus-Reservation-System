class ChangeTypeToStringToBus < ActiveRecord::Migration[7.1]
  def change
    change_column :buses, :registration_no, :string
  end
end
