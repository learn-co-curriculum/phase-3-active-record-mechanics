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

## Useful Active Record methods
### `.all`
### `.find` 
### `.find_by`
### `#save` 
### `#create`