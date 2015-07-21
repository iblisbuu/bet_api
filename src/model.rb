# encoding: utf-8

require 'sequel'

DB = Sequel.connect('sqlite://db.db')

Sequel::Model.plugin(:schema)

class Events < Sequel::Model
  plugin :serialization, :json
  unless DB.table_exists?(:event)
    DB.create_table :event do
      primary_key :id
      text :name
    end
  end
  set_database DB[:event]
end

class Bet < Sequel::Model
  plugin :serialization, :json
  unless DB.table_exists?(:bet)
    DB.create_table :bet do
      primary_key :id
      text :email
      integer :fk_event
    end
  end
  set_database DB[:bet]
end

class Match < Sequel::Model
  plugin :serialization, :json
  unless DB.table_exists?(:match)
    DB.create_table :match do
      text :team_a
      text :team_b
      event :fk_event
    end
  end
  set_database DB[:match]
end

class Match_Bet < Sequel::Model
  plugin :serialization, :json
  unless DB.table_exists?(:match_bet)
    DB.create_table :match_bet do
      integer :fk_match
      integer :fk_bet
      text :result
    end
  end
  set_database DB[:match_bet]
end
