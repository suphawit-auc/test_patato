require 'rails_helper.rb'

describe Movie do
	describe 'searching Tmdb by keyword' do
		context 'with valid API key' do
			it 'calls Tmdb with title keywords' do
			expect(Tmdb::Movie).to receive(:find).with('Inception')
			Movie.find_in_tmdb('Inception')
			end
		end
		context 'with invalid API key' do
			before(:each) do
				allow(Tmdb::Movie).to receive(:find).and_raise(Tmdb::InvalidKeyError)
			end
			it 'raises an InvalidKeyError' do
				expect {Movie.find_in_tmdb('Inception')}.to raise_error(Tmdb::InvalidKeyError)	
			end
		end	
	end

end
