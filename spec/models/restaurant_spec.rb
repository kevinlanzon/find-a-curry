require 'spec_helper'

describe Restaurant, type: :model do

  it { is_expected.to have_many :reviews }
  it { is_expected.to belong_to :user }

  it 'is not valid with a name of less than three characters' do
    restaurant = Restaurant.new(name: "kf")
    expect(restaurant).to have(1).error_on(:name)
    expect(restaurant).not_to be_valid
  end


  it "is not valid unless it has a unique name" do
    Restaurant.create(name: "Toastie's")
    restaurant = Restaurant.new(name: "Toastie's")
    expect(restaurant).to have(1).error_on(:name)
  end
end

  describe '#average_rating' do
  context 'no reviews' do
    it 'returns "N/A" when there are no reviews' do
      restaurant = Restaurant.create(name: "Toastie's")
      expect(restaurant.average_rating).to eq 'N/A'
    end
  end
end

  context '1 review' do
  it 'returns that rating' do
    restaurant = Restaurant.create(name: "Toastie's")
    restaurant.reviews.create(rating: 4)
    expect(restaurant.average_rating).to eq 4
  end
end

  context 'multiple reviews' do
  it 'returns the average' do
    restaurant = Restaurant.create(name: "Toastie's")
    restaurant.reviews.create(rating: 1)
    restaurant.reviews.create(rating: 5)
    expect(restaurant.average_rating).to eq 3
  end
end
