namespace :comments do
  task import: :environment do
  	comments = CSV.open("#{Rails.root}/lib/booking_comments.csv", 'rb:UTF-8', col_sep: ';')
  	i = 0 
  	comments.each do |comment|
  		if comment[3] =~ /[А-Яа-я]+/
  			hotel = Hotel.get_or_update(comment[7])
  			hotel.reviews.find_or_create_by(comment: comment[3]) do |comm|
  				comm.rate = comment[2].gsub(',','.').to_f
  				comm.date = Hotel.parse_date_ru(comment[4])
  				comm.name = comment[0]
  			end
  			puts "#{i+=1} comments saved"
  		end
  	end
  end
end