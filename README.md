This is a dummy application to demonstrate an apparent concurrency issue
with ActiveSupport::Notifications.

To get up and running and reproduce the issue:

1. Install and switch to JRuby 1.7.4
2. `bundle`
3. `bundle exec rake db:create` (you'll need to have MySQL running locally, and may need to edit `config/database.yml`)
4. `bundle exec rake db:migrate`
5. `bundle exec puma`
6. Drive some concurrent load to the application. I did this with `siege`, which is available via Homebrew on a Mac. Something like: `siege -c 16 http://localhost:9292/`.

You should start seeing a small fraction of your requests ending with 500 errors. This is due to the start time on the payload attached to the `sql.active_record` event being `nil`, and thus the `raise` in `config/initializers/sql_subscriber.rb` being hit.

