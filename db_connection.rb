# frozen_string_literal: true

DB = Sequel.connect('sqlite:/') # memory database, requires sqlite3

DB.create_table :visits do
  primary_key :id
  String :path
  # Numerical labels provided in the webserver log are not valid IP addresses,
  # thus the column name :ip might be misleading
  String :visitor_identifier
end
