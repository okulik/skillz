A rails-pundit-bootstrap scaffolding app
========================================

Use this as a scaffolding for a simple web application made from devise gem for authentication, pundit for authorization and bootstrap. It also contains a worker-customer data model where each worker posesses a set of skills on which customers can easily search for workers with the desired skills.

Database
--------

User model has polymorphic association to worker and customer models i.e. to any other user sub-type (e.g. admins) via the rolable attribute. From an instance of the Worker model, you can retrieve a user with @worker.user and from an instance of the User model, you can retrieve an instance of polymorphic type with @user.rolable. Database stores this association by having rolable_id and rolable_type in the users table. See user, worker and customer models for details.

For storing worker skills we use PostgreSQL array type where skill are matched using ANY and ALL operators. PostgreSQL has GIN index that is inverted index type and that can handle values containing more than one key, well suited for our skills array application (http://www.postgresql.org/docs/9.4/static/indexes-types.html).

TL;DR
