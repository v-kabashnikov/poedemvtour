namespace :sletat do
  task sync: :environment do
    Country.sync
    DepartCity.sync
   
  end
end
