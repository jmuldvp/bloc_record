> 1. What's a RubyGem and why would you use one?

My understanding is a RubyGem is to Ruby as ReactJS is to JavaScript. I believe they are library's of different code meant for different purposes that give a Ruby developer more functionality.

> 2. What's the difference between lazy and eager loading?

In lazy loading, no work is done until you access an element. In eager loading, I would think of this as performing every function on a page so that it's ready to view. In lazy loading and given the same example, you load information on a page only when it needs to be loaded. [Examples](https://stackoverflow.com/questions/1299374/what-is-eager-loading/1299381#1299381).

> 3. What's the difference between the `CREATE TABLE` and `INSERT INTO` SQL statements?

`CREATE TABLE` actually creates a table in a SQL database. The command `INSERT INTO` actually inserts data into tables.

> 4. What's the difference between `extend` and `include`? When would you use one or the other?

`include` makes a modules methods available to class instances. `extend` is where the methods are available to the class itself.  You use `include` when you want to give instance functionality and you use `extend` when you want to give class functionality.

> 5. In `persistence.rb`, why do the save methods need to be instance (vs. class) methods?

Class methods only work with other class methods. When you save something (or perform any CRUD operations), each operation needs to be an instance method.

> 6. Given the Jar-Jar Binks example earlier, what is the final SQL query in `persistence.rb`'s `save!` method?

Given the below example found earlier in the checkpoint...
```
INSERT INTO character (character_name,star_rating)
VALUES ('Jar-Jar Binks',1);
```

..using a save example, the sql would look like this..
```
UPDATE character
SET character_name = 'Jar-Jar Binks', star_rating = 1;
```

> 7. `AddressBook`'s `entries` instance variable no longer returns anything. We'll fix this in a later checkpoint. What changes will we need to make?

We'll need to make database modifications. There is no relation from `AddressBook` to an `Entry`.
