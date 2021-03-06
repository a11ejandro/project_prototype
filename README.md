# Project Prototype #

This is a state of development, that is common for majority of RoR backend APIs.
Also, see admin panel client at https://github.com/a11ejandro/project_prototype_admin_ng2

Special thanks to [Plotist](https://github.com/Plotist) for partial code-base contributions.

**It has the following suggestions about project technologies:**

* Ruby version 2.3.1
* Rails version 5.0.1
* Postgres DB
* API documentation is implemented via swagger_docs
* Token-Auth is implemented via sorcery
* Deployment is set up via Capistrano 3
* Deployment uses templates, based on capistrano_nginx_unicorn
* Basic filtering is implemented via scoped_search
* Pagination is implemented using will_paginate
* Attachment uploading is implemented via Carrierwave.

**The following features are pre-implemented:**
* User sign in/sign up/reset password
* Admin sign in/sign up/user management
* Admin panel is supposed as detached SPA
* Unit tests for User model
* API tests for sessions and users controllers
* API documentation

## Installation ##

1. *clone* this repo
2. *cd*
3. ./install.sh
4. Answer questions
5. Fill in database.yml and secrets.yml with sensitivity data. Secrets should include *current_base_url* to make swagger
work properly.
6. Don't forget to re-invoke *rails swagger:docs* after documentation-sensitive data is changed.

## Possible improvements: ##
1. ~~Implement multiple-token auth~~ Done.
2. Use Capistrano template engine without bugs

Feel free to send pull request on any other reason.