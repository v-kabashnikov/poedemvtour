class EmailTemplate < ActiveRecord::Base
  rails_admin do
    edit do
      field :title
      field :subject

      field :content, :ck_editor
    end

    list do
      field :title
    end
  end
end
