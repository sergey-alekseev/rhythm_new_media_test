require 'active_record'
require 'yaml'
require File.expand_path("../../app/models/reservation.rb", __FILE__)

connection_details = YAML::load(File.open('config/database.yml'))
ActiveRecord::Base.establish_connection(connection_details)
