class WantAdChangePriceType < ActiveRecord::Migration
  def up
    connection.execute(%q{
        alter table want_ads
        alter column price
        type float using price::float
    })
  end

  def down
    change_column :want_ads, :price, :string
  end
end
