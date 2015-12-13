class EmailSent < ActiveRecord::Base

  def self.default_scope
    EmailSent.all.order('sent_at DESC')
  end

end
