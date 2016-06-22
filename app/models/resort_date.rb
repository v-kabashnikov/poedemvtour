class ResortDate < ActiveRecord::Base
  validates :season_start, :season_end, presence: true

  after_save :make_name

  rails_admin do
    list do
      field :name
    end

    edit do
      field :season_start
      field :season_end

      configure :season_start, :date do
        date_format :default
      end

      configure :season_end, :date do
        date_format :default
      end
    end
  end

  private

  def make_name
    m = {
      '01' => 'январь',
      '02' => 'февраль',
      '03' => 'март',
      '04' => 'апрель',
      '05' => 'май',
      '06' => 'июнь',
      '07' => 'июль',
      '08' => 'август',
      '09' => 'сентябрь',
      '10' => 'октябрь',
      '11' => 'ноябрь',
      '12' => 'декабрь'
    }

    season_1 = String.new
    season_2 = String.new

    month_1 = season_start.strftime('%m')

    season_1 += "#{m[month_1]}"
    season_2 += m[month_1]

    month_2 = season_end.strftime('%m')

    if month_1.to_i != month_2.to_i
      season_1 += " - #{m[month_2]}"
      season_2 += " - #{m[month_2]}"
    end

    update_columns(name: season_1, site_name: season_2)
  end
end
