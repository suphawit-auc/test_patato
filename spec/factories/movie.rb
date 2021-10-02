FactoryGirl.define do
	factory :movie do
		id '1'
		title 'A Fake Title'
		rating 'PG'
		release_date {10.years.ago} 
		description 'eiei'
	end
end
