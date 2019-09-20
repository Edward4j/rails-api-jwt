class Task < ApplicationRecord
  belongs_to :user
  # has_many :subtasks

  # validates :type, presence: true, inclusion: { in: %w(task sub_task) }
end
