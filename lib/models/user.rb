class User < ActiveRecord::Base
  belongs_to :organization
  has_many   :assigned_tickets, class_name: "Ticket", foreign_key: "assignee_id"
  has_many   :submitted_tickets, class_name: "Ticket", foreign_key: "submitter_id"
end
