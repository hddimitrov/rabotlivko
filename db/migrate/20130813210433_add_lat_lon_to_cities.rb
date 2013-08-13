class AddLatLonToCities < ActiveRecord::Migration
  def change
    add_column :states, :lat, :float
    add_column :states, :lon, :float

    add_column :cities, :lat, :float
    add_column :cities, :lon, :float
    add_column :cities, :q_state_center, :boolean, default: false
  end
end
