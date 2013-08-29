ActiveSupport::Notifications.subscribe('sql.active_record') do |name, start, finish, id, payload|
  raise "uh-oh, start was nil" if start == nil
  puts "SQL time: #{finish - start}"
end