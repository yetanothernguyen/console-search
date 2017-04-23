class Ticket < ActiveRecord::Base
  Ticket.inheritance_column = "_type"

  belongs_to :organization
  belongs_to :submitter, class_name: "User"
  belongs_to :assignee, class_name: "User"
end
