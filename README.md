# Active Record Mechanics (CRUD)

## Objectives

1.  Understand the connection between an ORM and Active Record
2.  Understand why Active Record is useful
3.  Develop a basic understanding of how to get started with Active Record

## ORM vs Active Record

By now you are familiar with the concept of an [ORM][], an Object-Relation
Mapper, and should have written something of your own in the `Student` and
`InteractiveRecord` classes. Our latest iteration was our most powerful yet,
it could give us lots of functionality via inheritance.

While building your own ORM for a single `Class` is a great way to learn about
how object-oriented programming languages commonly interact with a database,
imagine you had _many_ more classes. To test and maintain custom code for each
project we work on would distract our attention from making cool stuff to
building database connectivity. To save themselves and other developers this
headache, the [ActiveRecord][ar] Ruby gem team built the [ActiveRecord][ar]
gem.

In this lesson we'll read about how to to have `ActiveRecord` link our Ruby
models with rows in a database table. We won't write the code yet, but we'll
familiarize ourself with common code blocs used in `ActiveRecord`-using
projects.

## Active Record ORM

Active Record is a Ruby gem, meaning we get an entire library of code just by
running `gem install activerecord` or by including it in our `Gemfile`.

#### Connect to DB

Once our Gem environment knows to put `ActiveRecord` into the picture, we need
to tell `ActiveRecord` where the database is located that it will be working
with.

We do this by running `ActiveRecord::Base.establish_connection`. Once
`establish_connection` is run, `ActiveRecord::Base` keeps it stored as a class
variable at `ActiveRecord::Base.connection`.

> **NOTE**: If you'd like to type along in an IDE environment, you can experiment by using
> IRB with: `irb -r active_record` provided you've installed `ActiveRecord` and `sqlite3` with
> `gem install activerecord sqlite3`

```ruby
ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/students.sqlite"
)
```

#### Create a table

But our database is empty. Let's create a table to hold students.

Let's create our table using SQL:

```ruby
sql = <<-SQL
  CREATE TABLE IF NOT EXISTS students (
  id INTEGER PRIMARY KEY,
  name TEXT
  )
SQL

# Remember, the previous step has to run first so that `connection` is set!
ActiveRecord::Base.connection.execute(sql)
```

#### Link a Student "model" to the database table `students`

The last step is to tell your Ruby class to make use of `ActiveRecord`'s
built-in ORM methods. With Active Record and other ORMs, this is managed
through [Class Inheritance][ci]. We simply make _our_ class (`Student`) a
subclass of `ActiveRecord::Base`.

```ruby
class Student < ActiveRecord::Base
end
```

Our `Student` class is now our gateway for talking to the `students` table in
the database. The `Student` class has gained a whole bunch of [new
methods][ar-methods] via its inheritance relationship to `ActiveRecord`. Let's
look at a few of them

###### `.column_names`

Retrieve a list of all the columns in the table:

```ruby
Student.column_names
#=> [:id, :name]
```

###### `.create`

Create a new `Student` entry in the database:

```ruby
Student.create(name: 'Jon')
# INSERT INTO students (name) VALUES ('Jon')
```

###### `.find`

Retrieve a `Student` from the database by `id`:

```ruby
Student.find(1)
```

###### `.find_by`

Find by any attribute, such as `name`:

```ruby
Student.find_by(name: 'Jon')
# SELECT * FROM students WHERE (name = 'Jon') LIMIT 1
```

###### `attr_accessors`

You can get or set attributes of an instance of `Student` once you've retrieved
it:

```ruby
student = Student.find_by(name: 'Jon')
student.name
#=> 'Jon'

student.name = 'Steve'

student.name
#=> 'Steve'
```

###### `#save`

And then save those changes to the database:

```ruby
student = Student.find_by(name: 'Jon')
student.name = 'Steve'
student.save
```

Note that our `Student` class doesn't have any methods defined for `#name`
either. Nor does it make use of Ruby's built-in `attr_accessor` method.

```ruby
class Student < ActiveRecord::Base
end
```

## Conclusion

You've now seen how `ActiveRecord` creates a link between Ruby and databases.

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/active-record-mechanics-crud' title='Active Record Mechanics (CRUD)'>Active Record Mechanics (CRUD)</a> on Learn.co and start learning to code for free.</p>

[orm]: http://en.wikipedia.org/wiki/Object-relational_mapping
[ar]: http://guides.rubyonrails.org/active_record_basics.html
[ci]: http://rubylearning.com/satishtalim/ruby_inheritance.html
[ar-methods]: http://guides.rubyonrails.org/active_record_basics.html#creating-active-record-models
