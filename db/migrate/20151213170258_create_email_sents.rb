class CreateEmailSents < ActiveRecord::Migration
  def change
    create_table :email_sents do |t|
      t.datetime :sent_at

      t.timestamps null: false
    end
    send = EmailSent.create({sent_at: Time.now})
  end
end
