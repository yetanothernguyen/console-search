class CreateTickets < ActiveRecord::Migration[5.0]
  def change
    create_table :tickets do |t|
      t.string    :_id, index: true
      t.string    :url
      t.string    :external_id
      t.string    :type
      t.string    :subject
      t.text      :description
      t.string    :priority
      t.string    :status
      t.text      :tags
      t.boolean   :has_incidents
      t.string    :via
      t.datetime  :created_at
      t.datetime  :due_at

      t.references :submitter, index: true
      t.references :assignee, index: true
      t.references :organization, index: true
    end
  end
end
