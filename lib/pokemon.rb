class Pokemon
  attr_accessor :id, :name, :type, :db

  def initialize(name:, type:, db:, id: nil)
    @id = id
    @name = name
    @type = type
    @db = db
  end

  def self.save(name, type, db)
    sql = <<-SQL
      INSERT INTO pokemon (name, type) VALUES (?, ?)
    SQL
    db.execute(sql, [name, type])
  end

  def self.find(pokemon_id, db)
    sql = <<-SQL
      SELECT * FROM pokemon where id = ?
    SQL
    pokemon_from_db(db.execute(sql, [pokemon_id]).first, db)
  end

  def self.pokemon_from_db(attribute_array, db)
    Pokemon.new(id: attribute_array[0], name: attribute_array[1], type: attribute_array[2], db: db)
  end

  private_class_method :pokemon_from_db
end
