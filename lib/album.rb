class Album
  attr_accessor :id, :name, :artist, :year, :genre

  @@albums      = {}
  @@total_rows  = 0
  @@sold_albums = {}

  def self.all
    @@albums.values
  end

  def self.clear
    @@albums = {}
    @@total_rows = 0
  end

  def self.find(id)
    @@albums[id]
  end

  def self.search(album_name)
    regex = Regexp.new(album_name)
    @@albums.values.each do |albums|
      if regex =~ albums.name
        return albums
      end
    end
    false
  end

  def self.sort
    array_of_hash = @@albums.sort_by { |key, values| values.name}
    @@albums = Hash[array_of_hash.map { |key, values| [key, values]}]
  end

  def initialize(name, artist, year, genre, id)
    @name = name.capitalize
    @artist = artist
    @year = year
    @genre = genre
    @sold = true
    @id = id || @@total_rows += 1
  end

  def delete
    @@albums.delete(self.id)
  end

  def save
    @@albums[self.id] = Album.new(self.name, self.artist, self.year, self.genre, self.id)
    Album.sort
  end

  def sold
    @@sold_albums = @@albums[self.id]
  end

  def except!(*keys)
    keys.each { |key| delete(key) }
    self
  end

  def buy
    self.sold
    p "temp contains: #{self.id}"
    @@albums.except!(self.id)
  end

  # def ==(album_to_compare)
  #   self.name == album_to_compare.name()
  # end

  def update(name, artist, year, genre)
    self.name = name.length > 0 ? name : self.name
    self.artist = artist.length > 0 ? artist : self.artist
    self.year = year.length > 0 ? year : self.year
    self.genre = genre.length > 0 ? genre : self.genre
    @@albums[self.id] = Album.new(self.name, self.artist, self.year, self.genre, self.id)
  end
end

thing2 = Album.new("bacon", "ZZ Top", "1985", "Rock", nil)
thing2.save
thing3 = Album.new("taco", "ZZ Top", "1985", "Rock", nil)
thing3.save
thing = Album.new("afterburner", "ZZ Top", "1985", "Rock", nil)
thing.save
p Album.all
p "bacon spaces"
thing2.buy
p Album.all
