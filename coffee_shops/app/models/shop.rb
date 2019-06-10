class Shop

DB = PG.connect({:host => "localhost", :port => 5432, :dbname => 'coffee_shops_development'})

  def self.all
    results = DB.exec("SELECT * FROM shops;")
    return results.map do |result|
        {
            "id" => result["id"].to_i,
            "name" => result["name"],
            "location" => result["location"],
            "drink" => result["drink"]
        }
      end
  end

  def self.find(id)
    results = DB.exec("SELECT * FROM shops WHERE id=#{id};")
    return {
      "id" => results.first["id"].to_i,
      "name" => results.first["name"],
      "location" => results.first["location"],
      "drink" => results.first["drink"]
    }
  end

  def self.create(opts)
    results = DB.exec(
      <<-SQL
        INSERT INTO shops (name, location, drink)
        VALUES ( '#{opts["name"]}', '#{opts["location"]}', '#{opts["drink"]}')
        RETURNING id, name, location, drink;
      SQL
    )
    return {
      "id" => results.first["id"].to_i,
      "name" => results.first["name"],
      "location" => results.first["location"],
      "drink" => results.first["drink"]
    }
  end

  def self.delete(id)
    results = DB.exec("DELETE FROM shops WHERE id=#{id};")
    return { "delete" => true}
  end

  def self.update(id, opts)
    results = DB.exec(
      <<-SQL
        UPDATE shops
        SET name='#{opts["name"]}', location='#{opts["location"]}', drink='#{opts["drink"]}'
        WHERE id=#{id}
        RETURNING id, name, location, drink;
      SQL
    )
    return {
      "id" => results.first["id"].to_i,
      "name" => results.first["name"],
      "location" => results.first["location"],
      "drink" => results.first["drink"]
    }

  end

end
