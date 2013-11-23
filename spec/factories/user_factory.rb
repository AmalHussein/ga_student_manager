require 'faker'

FactoryGirl.define do
	
	factory :user do |f|
		f.first_name {Faker::Name.first_name}
		f.last_name {Faker::Name.last_name}
	end

	# factory :student do
	# 	first_name "rahul"
	# end

	# factory :teacher do
	# 	first_name "tom"
	# end

end