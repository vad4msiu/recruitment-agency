class EnableIntarrayExt < ActiveRecord::Migration
  def change
    execute(%q(CREATE EXTENSION intarray))
  end
end
