class CreateProjectSettings < ActiveRecord::Migration
  def change
    create_table :project_settings do |t|
      t.string :name, null: false
      t.string :slug, null: false
      t.string :val, null: false

      t.timestamps null: false
    end

    ProjectSetting.create!(
      name: 'время жизни кэша погоды для страны (сек)',
      slug: 'weather_country_cache_life_time',
      val: 86400
    )

    ProjectSetting.create!(
      name: 'надбавка градусов температуры воздуха у курортов',
      slug: 'plus_weather_resort',
      val: 6
    )
  end
end
