class CreateAdmin < ActiveRecord::Migration[7.0]
  def change
    create_table :admin do |t|

    end

    create_table :lovers do |t|
      t.string :name
      t.string :crushName
      t.string :result
    end
  end
end
