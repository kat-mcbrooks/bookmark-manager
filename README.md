#### Bookmark Manager

### Bookmark manager website will have the following specification:

- Show a list of bookmarks
- Add new bookmarks
- Delete bookmarks
- Update bookmarks
- Comment on bookmarks
- Tag bookmarks into categories
- Filter bookmarks by tag
- Users are restricted to manage only their own bookmarks

User Stories relating to each of the above: 
As a user, 
so that I can easily see my bookmarks, 
I would like my bookmark manager to display a list of bookmarks.

As a user, 
so that I can store the bookmark for later retrieval 
I want to add a bookmark to Bookmark Manager.

![bookmark_manager_diagram](/images/Domain_Model_Diagram.png)

- When the user visits the '/bookmarks' path, their browser sends a request to a controller we built.
- When the controller gets the request, it asks the Bookmark class to give it all the bookmarks, i.e. the controller asks for Bookmark.all.
- The Bookmark class goes and gets the bookmarks, and gives back all the bookmarks in an array to the controller.
- The controller renders the array of bookmarks to a webpage, which it sends as a response to the user

So, it feels like the first things we need are:

a Controller
a Bookmark class
A bookmark view

#### Setting up the database

1. Connect to psql
2. Create the database using the psql command CREATE DATABASE bookmark_manager;
3. Connect to the database using the pqsl command \c bookmark_manager;
4. Run the query we have saved in the file 01_create_bookmarks_table.sql

#### Setting up the test database
1. Create the database to be used when running rspec using the psql command CREATE DATABASE bookmark_manager_test;
2. Connect to the database using the pqsl command \c bookmark_manager_test;
3. Run the query we have saved in the file 01_create_bookmarks_table.sql
