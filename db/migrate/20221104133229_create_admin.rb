class CreateAdmin < ActiveRecord::Migration[7.0]
    def up
        unless table_exists?(:admins)
            create_table :admins do |t|
                t.string :password_hash
            end
        end

        unless table_exists?(:lovers)
            create_table :lovers do |t|
                t.string :name
                t.string :crush_name
                t.string :result
            end
        end
    end

    def down
        drop_table :admins
        drop_table :lovers
    end
end
