ActiveRecord::Schema.define(:version => 0) do

  create_table :things, :force => true do |t|
    t.string :description
    t.text :notes

    t.timestamps
  end

end

class Thing < ActiveRecord::Base
  #metadata

  #metadata_accessor :rf_doors, :rf_windows
end
