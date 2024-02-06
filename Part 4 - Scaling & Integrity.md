# Part 4 - Scaling & Data Integrity

---

## Scaling

Currently implemented to help with scaling:

1. Utilized pagination to breakdown records into smaller collections

2. Used grouping and ordering to sort records on the DB level instead of Active Records built in sort_by method which is less efficient

Some things we can do as our user & data record count contiues to grow:

1. Implement a cache layer using Redis to prevent strain from duplicate requests of the same data

2. Utilize load balancing to reduce application peformance degradation

3. Monitor performance using a tool like DataDog APM and setup alerts when certain performance thresholds are met

4. Pull only needed attributes by using `pluck` or `select` in order to avoid loading the entire Active Record object

5. Use Active Records `find_in_each` or `find_in_batch` methods to prevent loading all records in memory

6. Use a gem like `rack-attack` to rate limit by IP

---

## Data Integrity

1. To preserve data integrity I implented a `before_save` check on the Place model that upcases the `name` & `description` fields. This will allow more consistent responses by upcasing the search query coming in via the request.

2. Utilized Active Records built in `sanitize_sql_like` method to ensure clean LIKE querys are being sent to the DB