# City Slicker - Full Stack Interview Project

### Getting Started ✅ 

At Popular Pays by Lightricks, our core API is a Rails app which integrates Rspec (for testing), and a PostgreSQL database. The following commands should help you quickly get started:
```
rails new app-name -T -d postgresql
rails generate rspec:install
```
Please reach out with questions on the exercise - clarifications will of course never be counted against your submission.

----------------------

### Part 1 - Modeling ✅ 

We all call somewhere home. We're proud of where we live and we want to share with the world all the things that make our home special to us. We have an API that allows us to showcase things about a `Place` when you query against it. 

A `Place` has information about its geolocation - `latitude` and `longitude` - as well as a `name` and `description` which should both support free text. A `Place` also has a `rating` instance method which is an aggregate average of all `Rating` records that have an association with the `Place`.

A `Rating` has a float attribute that stores the `value` and a relationship to a particular `Place`. The presence of these attributes and relationships between models should be mandatory and validated.

Instructions: Build your modeling based on the information above. This should include DB tables and Rails models with methods.

-----------------------

### Part 2 - API Exposure 

A `Place` needs to be discoverable by searching. We need to expose the data before we can build the UI.

We want to be able to fuzzy search a `Place` against it's `name` and `description` attributes.  

> BONUS: We also want to be able to search a `Place` against proximity - or distance. For this, we would use a geolocation mapping library and compare distance from the current location of the user. This is not in scope for the exercise (it's a decent amount of work), but if you finish everything else in the exercise and want to tackle it, go for it!

The endpoint should sort by the most popular - meaning the first object in the collection should have the highest aggregate `rating`.

Instructions:
1.) Build a collection (i.e., index) endpoint that supports fuzzy search by `name`. Make sure to consider the sanitization/normalization of the search query for case differences and trailing/leading whitespace. ✅

2.) Ensure the response implements pagination parameter support (feel free to roll your own or use a gem) as well as the sort requirements listed above. ✅

3.) Ensure the endpoint returns JSON with all attributes. ✅

4.) Make sure the endpoint is well tested for all branching logic and handlers.

5.) Keep in mind errors you might want to rescue. ✅

6.) Further considerations of rate limiting and error handling. ✅

------------------------

### Part 3 - UI/UX ✅

We want to connect the API to a web browser UI for people to enjoy and search `places`. For this exercise, it is recommended that you use either React.js or Ember.js. However, if you are more comfortable with Rails MVC, please feel free to take that route.

Instructions:
1.) Build a UI that allows you to search based on the requirements of the API.

2.) We can have a search bar as a header component and a table view as the main content of the page that displays the information about the `place`, including `name`, `description` and `rating`, in table cells. Please feel free to use whatever elements you wish to render a table style view of the `places`.

3.) Style the UI as you wish. We're not expecting you to be a design pro as well, but since this is a full stack exercise we are interested in how you layout the UI and your ability to create basic styles. Feel free to use this as an area to flex your muscles.

------------------------

### Part 4 - Scaling & Data Integrity ✅

This is a new web app and idea so we don't expect much traffic in the beginning, but we're hoping to scale it and make sure it can handle the throughput and user growth.

Imagine the amount of records on the `places` table is large - At least 1 million records.  The index endpoint for the `places` resource returns a paginated collection but the majority of load on the DB is happening in the search query (see Part 2).

If you had to design a scalable search on this endpoint, how would you go about doing so? This is a critical thinking question that we want you to include as part of the exercise, but do not expect you to implement. Think about issues of scalability and how you would solve them as well as the tech design of the search feature. How would you create a system to handle that quantity of records to query assuming it's only going to grow larger and larger? This could include a plan to implement monitoring, solutions at the DB layer, as well as controller layer.

What are some problems you might end up having to solve in terms of data integrity? For example, an attribute on a `places` record could easily result in duplicate records if not properly validated and sanitized before persisting.

ie. Place 1 has name `Chicago`, Place 2 has name `chicago`, Place 3 has name `CHICAGO`. Tell us / show us the best way to solve this and other considerations we may want to take into account.

To submit your proposal for this part, simply create a markdown file at the top level of your Rails project titled `Part 4 - Scaling & Integrity`.

-----------------------

### Part 5 - Testing

At Popular Pays by Lightricks, we place a high emphasis on testing. Not only does it give us security in the features we ship but also piece of mind. Write tests to include coverage of all controller actions, success and error request/response cycle, and unit testing for all model layer logic.

We use Rspec, Capybara, FactoryBot, and shoulda-matchers as utilities and frameworks for testing. Those are not mandatory for this assignment, but would allow you to have coverage from the acceptance level down to the unit level.

Make sure to include a `seeds.rb` file to populate the database.  This will allow us to fire up the app locally and fill the development database with data to manually QA your submission.

-----------------------

### Part 6 - Delivery

To submit your exercise, you have two options:

1.) Please archive the project folder in a ZIP and email it to `alan@lightricks.com` with the subject `Interview Practice Submission - <your name>`.

2.) Please create a public repo and pass the link to `alan@lightricks.com` to be cloned and reviewed.