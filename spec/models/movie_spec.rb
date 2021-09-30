require 'rails_helper.rb'

describe Movie do
	fixtures :movies
	it 'includes rating and year in full name' do
		# 'build' creates but doesn't save object; 'create' also save it
		movie = FactoryGirl.build(:movie, :title => 'Milk', :rating => 'R')
		expect(movie.name_with_rating).to eq('Milk (R)')
	end
end
