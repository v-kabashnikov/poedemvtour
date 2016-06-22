class About < ActiveRecord::Base
  rails_admin do
    edit do
      field :about, :ck_editor
    end
  end
end
