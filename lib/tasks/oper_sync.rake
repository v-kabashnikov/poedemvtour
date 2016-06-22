namespace :operators do
  task sync: :environment do
  	  require 'httparty'
	  response = HTTParty.get("http://module.sletat.ru/Main.svc/GetTourOperators")
	  json = JSON.parse(response.body)
	  json["GetTourOperatorsResult"]["Data"].each do |i|
	  	Operator.where(name: i["Name"]).first_or_create r
	  end
  end
end
