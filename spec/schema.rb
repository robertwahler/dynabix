ActiveRecord::Schema.define(:version => 0) do

  create_table :things, :force => true do |t|
    t.string :description
    t.text :notes
    t.text :metadata

    t.timestamps
  end

end
