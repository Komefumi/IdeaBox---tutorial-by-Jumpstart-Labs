# frozen_string_literal: true

require 'yaml/store'

require_relative 'idea'

# The class that models the main data type
class IdeaStore
  def self.all
    raw_ideas.map do |data|
      Idea.new(data)
    end
  end

  def self.find(position)
    Idea.new(find_raw_idea(position))
  end

  def self.update(position, data)
    database.transaction do
      database['ideas'][position.to_i] =
        { title: data[:title] || data['title'], description: data[:description] || data['description'] }
    end
  end

  def self.delete(position)
    database.transaction do
      database['ideas'].delete_at(position)
    end
  end

  # Section Two - Internals
  ## Retrieving raw data
  def self.raw_ideas
    database.transaction do |db|
      db['ideas'] || []
    end
  end

  def self.find_raw_idea(position)
    database.transaction do
      database['ideas'].at(position)
    end
  end

  def self.create(attributes)
    database.transaction do
      database['ideas'] ||= []
      database['ideas'] << attributes
    end
  end

  ## Database Access
  def self.database
    @database ||= YAML::Store.new 'ideabox'
  end

  def database
    IdeaStore.database
  end
end
