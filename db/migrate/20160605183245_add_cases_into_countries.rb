class AddCasesIntoCountries < ActiveRecord::Migration
  def change
  	add_column :countries, :case_1, :string
  	add_column :countries, :case_2, :string
  	add_column :countries, :case_3, :string

  	Country.where(name: 'Вьетнам').update_all(
  	  case_1: 'ВО ВЬЕТНАМЕ',
  	  case_2: 'ВЬЕТНАМА',
  	  case_3: 'О ВЬЕТНАМЕ',
  	  youtube_link: 'http://www.youtube.com/watch?v=yqVgDLXHUV4'
  	)
  end
end
