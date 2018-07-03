require 'sqlite3'
require 'singleton'

class PlayDBConnection < SQLite3::Database
  include Singleton

  def initialize
    super('plays.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end

class Play
  attr_accessor :title, :year, :playwright_id

  def self.all
    data = PlayDBConnection.instance.execute("SELECT * FROM plays")
    data.map { |datum| Play.new(datum) }
  end

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @year = options['year']
    @playwright_id = options['playwright_id']
  end

  def create
    raise "#{self} already in database" if @id
    PlayDBConnection.instance.execute(<<-SQL, @title, @year, @playwright_id)
      INSERT INTO
        plays (title, year, playwright_id)
      VALUES
        (?, ?, ?)
    SQL
    @id = PlayDBConnection.instance.last_insert_row_id
  end

  def update
    raise "#{self} not in database" unless @id
    PlayDBConnection.instance.execute(<<-SQL, @title, @year, @playwright_id, @id)
      UPDATE
        plays
      SET
        title = ?, year = ?, playwright_id = ?
      WHERE
        id = ?
    SQL
  end

  def self.find_by_title(name)
    value = PlayDBConnection.instance.execute(<<-SQL,name)
    SELECT *
    FROM plays
    WHERE title = ?
    SQL

    return false if value.length <= 0
    Play.new(value.first)
  end

  def self.find_by_playwright(play_id)
    data =PlayDBConnection.instance.execute(<<-SQL, play_id)
    SELECT *
    FROM plays
    WHERE playwright_id = ?
    SQL

    result = []
    data.each do |x|
      result << Play.new(x)
    end
    return result
  end

end

class Playwright
  def self.all
    data = PlayDBConnection.instance.execute("SELECT * FROM playwrights")
    result = []
    data.each do |x|
      result << Playwright.new(x)
    end
    return result
  end
end
