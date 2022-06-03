class AddTeamToPitcher < ActiveRecord::Migration[5.2]
  def change
    add_reference :pitchers, :team, foreign_key: true
  end
end
