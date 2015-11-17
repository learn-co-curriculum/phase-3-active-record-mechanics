# Active Record Mechanics (CRUD)

## Objectives
1. Understand the connection between an ORM and Active Record
2. Understand why Active Record is useful
3. Use some common Active Record methods

## Why is this useful?


## ORM vs Active Record
By now you should already be familiar with the concept of an [ORM](http://en.wikipedia.org/wiki/Object-relational_mapping), and have written something of your own via the Ruby Student Class.

Building your own little ORM for a single Class is a great way to learn about how object oriented programming languages commonly interface with a database, but imagine you had two, or three, or ten classes in your application that all corresponded to different tables in the database. Building those same kinds of methods into each of them would be a lot of work! Ok, maybe you're thinking: I bet I could just write one Class that would have methods that could work with any table, and use that instead. Go for it! Don't really though, that will become a lot of code really quick, and as your demands grow, maintenance and stability will quickly become an issue as well! The best ORMs develop over time and require a lot of testing. 

So, chances are, you just don't know enough about Ruby or databases yet to make something flexible or efficient enough to meet your needs as a professional web application developer. Not to worry, you're not the first person to have this problem, and there are already plenty of great libraries out there that will make your life easier. Meet [ActiveRecord](http://guides.rubyonrails.org/active_record_basics.html), the database toolkit for Ruby!

Still confused? Let's take a quick look at what ActiveRecord can do.

## ActiveRecord ORM

This is how we would connect to a database:

```ruby
ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/students.sqlite"
)
```

This is how we would create a table:

```ruby
class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :name
    end
  end
end
```

That's cool. But where it starts to get interesting is when you make use of ActiveRecord's built-in ORM utilities to extend your Ruby classes with ActiveRecord's `Model` class.

With ActiveRecord, and other ORMs the way this is managed is through [Class Inheritance](http://rubylearning.com/satishtalim/ruby_inheritance.html).

So to add `ActiveRecord::Base`'s methods to your class you'd do:

```ruby
class Student < ActiveRecord::Base
end
```

Now your `Student` class has a whole bunch of [new methods](http://guides.rubyonrails.org/active_record_basics.html#creating-active-record-models) available to it, that are already built in to ActiveRecord.

Retrieve a list of all the columns in the table:

```ruby
Student.column_names
#=> [:id, :name]
```

Create a new student:

```ruby
Student.create(name: 'Jon')
# INSERT INTO students (name) VALUES ('Jon')
```

Retrieve a Student from the database by id:

```ruby
Student.find(1)
```

Find by name, or any attribute:

```ruby
Student.find_by(name: 'Jon')
# SELECT * FROM artists WHERE (name = 'Jon') LIMIT 1
```

You can get or set attributes of instances of a Student once you have retrieved it:

```ruby
student = Student.find_by(name: 'Jon')
student.name
#=> 'Jon'

student.name = 'Steve'

student.name
#=> 'Steve'
```

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

So where do the methods for getting and setting 'name' get added? Where is the only place thus far you can think of that we've added something called name?

If you answered 'in the database' then you're on the right track. An ORM's job is to be the glue between our database and our objects. In this case, ActiveRecord is really smart and has made some assumptions for us. ActiveRecord assumes its job is to make it so that you can interact with the rows in your database as Ruby objects. So if you want to read attributes of an object, or make changes to them, it assumes your goal is to reflect those changes in the database.

Basically, ActiveRecord is saying "Ok, I've got this class Student, it must map to a table called 'students.'" Then it's looking in the students table and for each column in that table, and adding methods for both getting and setting that attribute.

Without ever even needing to define the methods on your class, ActiveRecord has given you the ability to get and set them just through a couple of clever assumptions/conventions. This technique is common of most Ruby ORMs.


## Useful Active Record methods
### `.all`
### `.find` 
### `.find_by`
### `#save` 
### `#create`