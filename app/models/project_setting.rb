class ProjectSetting < ActiveRecord::Base
  validates :val, presence: true

  rails_admin do
    list do
      field :name
      field :val
    end

    edit do
      field :val
    end
  end
end
