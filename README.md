# Active Record Mechanics

## Learning Goals

- Understand the connection between an ORM and Active Record
- Understand why Active Record is useful
- Learn what "convention over configuration" means
- Develop a basic understanding of how to get started with Active Record

## ORM vs Active Record

By now you are familiar with the concept of an [ORM][orm], an Object-Relational
Mapper. While building your own ORM for a single class is a great way to learn
about how object-oriented programming languages commonly interact with a
database, imagine you had _many_ more classes. Having to test and maintain
custom code to build database connectivity for each project we work on would
divert our attention from what we really want to be focusing on: making cool
stuff.

To save themselves and others this headache, a team of developers built the
[Active Record][ar] Ruby gem.

In this lesson, we'll read about how to have Active Record link our Ruby models with
rows in a database table. There's code in the `active_record.rb` file set up so
you can follow along with the examples below. Fork and clone this lesson if
you'd like to code along.

> **Note**: You'll never write all the code for your Active Record applications
> in one file like we're doing here — the setup here is kept intentionally as
> simple as possible so you can see everything in one place. Soon, we'll cover a
> more realistic Active Record file structure.

As you work through this section, it's highly recommended that you also take
some time to read through the [Active Record guides][ar]. There's a lot more
that Active Record can do than we'll be able to cover, so you're sure to
discover a lot of fun new things by checking out the documentation!

## Active Record ORM

Active Record is a Ruby gem, meaning we get an entire library of code just by
running `gem install activerecord` or by including it in our `Gemfile`. In
this lesson, we've included it in the `Gemfile` along with the `sqlite3` gem.

### Connect to DB

Once our Gem environment knows what to put into the picture, we need to tell
Active Record where the database is located that it will be working with.

We do this by running `ActiveRecord::Base.establish_connection`. Once
`establish_connection` is run, `ActiveRecord::Base` keeps it stored as a class
variable at `ActiveRecord::Base.connection`. We can do this by including the
following code in the `active_record.rb` file:

```ruby
ActiveRecord::Base.establish_connection(
  adapter: "sqlite3",
  database: "db/students.sqlite"
)
```

#### Create a table

But our database is empty! Let's create a table to hold students.

This code in the `active_record.rb` file will create a `students` table:

```ruby
sql = <<-SQL
  CREATE TABLE IF NOT EXISTS students (
    id INTEGER PRIMARY KEY,
    name TEXT
  )
SQL

ActiveRecord::Base.connection.execute(sql)
```

### Link a `Student` "model" to the `students` Database Table

The last step is to tell your Ruby class to make use of Active Record's built-in
ORM methods. With Active Record and other ORMs, this is managed through
[Class Inheritance][ci]. We simply make _our_ class (`Student`) a subclass of
`ActiveRecord::Base`.

```ruby
class Student < ActiveRecord::Base
end
```

Our `Student` class is now our gateway for talking to the `students` table in
the database.

By simply following one _very important_ naming convention — **class names are
singular** and **table names are plural** — we've done enough to establish a
relationship between our `Student` class and the `students` table! Active Record
"knows" that when we're using the `Student` class, the SQL code it writes for us
should target the `students` table.

How does Active Record "know" about this relationship? Active Record follows the
paradigm of [**convention over configuration**][convention], which means that as
developers, _as long as we follow the conventions_ that Active Record expects,
we don't have to spend as much time writing out the configuration explicitly.
That also means it is **very** important to understand the conventions Active
Record expects. So, to repeat:

When using Active Record, our **class names are singular** and **table names are
plural**.

### Running the Example

To code along with these examples, first, run `bundle install` to set up the
necessary gems. Then, run:

```console
$ ruby active_record.rb
```

This will enter you into a Pry session where you can try out the methods listed
below.

> **Note**: If you run into an error with the `sqlite3` gem, try using
> `gem pristine sqlite3` to restore the gem.

The `Student` class is inheriting a whole bunch of [new methods][ar-methods]
from the `ActiveRecord::Base` class. Let's look at a few of them and try them
out!

#### `.column_names`

Retrieve a list of all the columns in the table:

```ruby
Student.column_names
#=> [:id, :name]
```

#### `.create`

Create a new `Student` entry in the database:

```ruby
Student.create(name: 'Jon')
# INSERT INTO students (name) VALUES ('Jon')
# => #<Student:0x00007f985d0638b0 id: 1, name: "Jon">
```

You'll also see a log of the SQL that Active Record is writing for us, just like
we did in our own ORMs!

#### `.all`

Return all the records from the `students` table as instances of the `Student`
class:

```ruby
Student.all
# SELECT "students".* FROM "students"
# => [#<Student:0x00007f985d0638b0 id: 1, name: "Jon">]
```

#### `.find`

Retrieve a `Student` from the database by `id`:

```ruby
Student.find(1)
# SELECT "students".* FROM "students" WHERE "students"."id" = 1 LIMIT 1
# => #<Student:0x00007f985d0638b0 id: 1, name: "Jon">
```

#### `.find_by`

Find by any attribute, such as `name`:

```ruby
Student.find_by(name: 'Jon')
# SELECT "students".* FROM "students" WHERE "students"."name" = 'Jon' LIMIT 1
# => #<Student:0x00007f985d0638b0 id: 1, name: "Jon">
```

#### `attr_accessors`

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

#### `#save`

And then save those changes to the database:

```ruby
student = Student.find_by(name: 'Jon')
student.name = 'Steve'
student.save
# UPDATE "students" SET "name" = "Steve" WHERE "students"."id" = 1
```

Note that our `Student` class doesn't have any methods defined for `#name`
either. Nor does it make use of Ruby's built-in `attr_accessor` method:

```ruby
class Student < ActiveRecord::Base
end
```

All of the methods we've seen are coming from `ActiveRecord::Base`; we have
access to them because we're following the convention of **singular class
names** and **plural table names**.

## Conclusion

You've now seen how Active Record creates a link between Ruby and databases. In
the coming lessons, we'll explore how to build more realistic applications using
Active Record, and some of the other methods we have access to in our classes.

## Resources

- [Active Record Basics][ar]

[orm]: http://en.wikipedia.org/wiki/Object-relational_mapping
[ar]: http://guides.rubyonrails.org/active_record_basics.html
[ci]: https://github.com/learn-co-curriculum/phase-3-ruby-oo-inheritance-defining-inheritance
[ar-methods]: http://guides.rubyonrails.org/active_record_basics.html#creating-active-record-models
[convention]: https://guides.rubyonrails.org/active_record_basics.html#convention-over-configuration-in-active-record
