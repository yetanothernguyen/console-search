class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string    :url
      t.string    :external_id
      t.string    :name
      t.string    :alias
      t.boolean   :active
      t.boolean   :verified
      t.boolean   :shared
      t.string    :locale
      t.string    :timezone
      t.string    :email
      t.string    :phone
      t.string    :signature
      t.text      :tags
      t.boolean   :suspended
      t.string    :role
      t.datetime  :created_at
      t.datetime  :last_login_at

      t.references :organization, index: true
    end
  end
end
