require "pry"
require "active_record"

# Setup a database connection
ActiveRecord::Base.establish_connection(
  adapter: "sqlite3",
  database: "db/students.sqlite"
)

# Create a Students table
sql = <<-SQL
  CREATE TABLE IF NOT EXISTS students (
    id INTEGER PRIMARY KEY,
    name TEXT
  )
SQL
ActiveRecord::Base.connection.execute(sql)

# Log SQL output to the terminal
ActiveRecord::Base.logger = Logger.new(STDOUT)

# Have the Student class inherit from ActiveRecord::Base
class Student < ActiveRecord::Base
end

binding.pry
""
