class CreateHooks < ActiveRecord::Migration[5.0]
  def change
    create_table :hooks do |t|
      t.references :service
      t.string :action_type
      t.string :url
      t.string :method, default: 'POST'
      t.string :content_type
      t.string :body

      t.timestamps
    end
  end
end
