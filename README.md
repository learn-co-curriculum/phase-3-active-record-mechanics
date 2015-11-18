# Active Record Mechanics (CRUD)

## Objectives
1. Understand the connection between an ORM and Active Record
2. Understand why Active Record is useful
3. Develop a basic understanding of how to get started with Active Record

## Why is this useful?
Up until now, we've built our own ORM. We even worked up to creating a dynamic ORM that could give us lots of functionality via inheritance. Active Record is like the dynamic ORM we built. It maps database tables to Ruby classes. Imagine our dynamic ORM on steroids. We don't have to write much code -- as long as we follow conventions. And as a result, Active Record gives you enormous functionality (Think our ORM with a lot more methods).

## ORM vs Active Record
By now you should already be familiar with the concept of an [ORM](http://en.wikipedia.org/wiki/Object-relational_mapping), and have written something of your own via the Ruby Student Class.

Building your own little ORM for a single Class is a great way to learn about how object oriented programming languages commonly interface with a database, but imagine you had two, or three, or ten classes in your application that all corresponded to different tables in the database. Building those same kinds of methods into each of them would be a lot of work! Ok, maybe you're thinking: I bet I could just write one Class that would have methods that could work with any table, and use that instead. Go for it! Don't really though, that will become a lot of code really quick, and as your demands grow, maintenance and stability will quickly become an issue as well! The best ORMs develop over time and require a lot of testing. 

So, chances are, you just don't know enough about Ruby or databases yet to make something flexible or efficient enough to meet your needs as a professional web application developer. Not to worry, you're not the first person to have this problem, and there are already plenty of great libraries out there that will make your life easier. Meet [ActiveRecord](http://guides.rubyonrails.org/active_record_basics.html), the database toolkit for Ruby!

Still confused? Let's take a quick look at what ActiveRecord can do.

## ActiveRecord ORM
Active Record is a Ruby gem, meaning we get an entire library of code just by running `gem install activerecord` or by including it in our `Gemfile`. As a result, we can get an enormous amount of functionality simply by following a few conventions. 

####Connect to DB
This is how we would connect to a database:

```ruby
connection = ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/songs.sqlite"
)


```
####Create a table
Let's create our table using SQL:

```ruby
sql = <<-SQL
  CREATE TABLE IF NOT EXISTS songs (
  id INTEGER PRIMARY KEY, 
  title TEXT, 
  length INTEGER
  )
SQL

ActiveRecord::Base.connection.execute(sql)
```

It starts to get interesting when you make use of ActiveRecord's built-in ORM utilities to extend your Ruby classes with ActiveRecord's `Model` class.

With ActiveRecord, and other ORMs the way this is managed is through [Class Inheritance](http://rubylearning.com/satishtalim/ruby_inheritance.html).


####Active Record Methods
To add `ActiveRecord::Base`'s methods to your class you'd do:

```ruby
class Student < ActiveRecord::Base
end
```

Now your `Student` class has a whole bunch of [new methods](http://guides.rubyonrails.org/active_record_basics.html#creating-active-record-models) available to it, that are already built in to ActiveRecord.

######`.column_names`
Retrieve a list of all the columns in the table:

```ruby
Student.column_names
#=> [:id, :name]
```

######`.create`
Create a new student:

```ruby
Student.create(name: 'Jon')
# INSERT INTO students (name) VALUES ('Jon')
```

######`.find`
Retrieve a Student from the database by id:

```ruby
Student.find(1)
```

######`.find_by`
Find by name, or any attribute:

```ruby
Student.find_by(name: 'Jon')
# SELECT * FROM artists WHERE (name = 'Jon') LIMIT 1
```

######`attr_accessors`
You can get or set attributes of instances of a Student once you have retrieved it:

```ruby
student = Student.find_by(name: 'Jon')
student.name
#=> 'Jon'

student.name = 'Steve'

student.name
#=> 'Steve'
```

######`#save`
And then save those changes to the database:

```ruby
student = Student.find_by(name: 'Jon')
student.name = 'Steve'
student.save
```

Note that our `Student` class doesn't have any methods defined for `#name` either. Nor does it make use of Ruby's built-in `attr_accessor` method. 

```ruby
class Student < ActiveRecord::Base
end
```