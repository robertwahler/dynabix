ActiveRecord::Schema.define(:version => 0) do

  create_table :things, :force => true do |t|
    t.string :description
    t.text :notes
    t.text :metadata

    t.timestamps
  end

  create_table :bars, :force => true do |t|
    t.string :description
    t.text :notes
    t.text :bardata

    t.timestamps
  end

  create_table :foos, :force => true do |t|
    t.string :description
    t.text :notes
    t.text :metadata

    t.timestamps
  end

end
