class Person < ApplicationRecord
  # after_commit :update_index

  def update_index
    Search::Person.new(self).update
  end
end
