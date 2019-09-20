class User < ApplicationRecord
  has_secure_password

  has_many :tasks #, -> { includes :subtasks }
  has_many :sub_tasks, class_name: 'Task'
end
