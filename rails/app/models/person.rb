class Person < ApplicationRecord
  # after_commit :update_index

  def update_index
    Search::Person.update(self)
  end
end
