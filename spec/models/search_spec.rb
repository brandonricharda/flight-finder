require 'rails_helper'

RSpec.describe Search, type: :model do
    describe "#create" do

        context "when called without params" do

            let(:search) { Search.create }

            it "doesn't create record" do
                expect { search }.to_not change { Search.count }
            end

            it "returns four errors" do
                expect(search.errors.count).to eql 5
            end

            it "returns query blank error" do
                expect(search.errors[:query].first).to eql "can't be blank"
            end

            it "returns country blank error" do
                expect(search.errors[:country].first).to eql "can't be blank"
            end

            it "returns currency blank error" do
                expect(search.errors[:currency].first).to eql "can't be blank"
            end
            
            it "returns locale blank error" do
                expect(search.errors[:locale].first).to eql "can't be blank"
            end

            it "returns data not found error" do
                expect(search.errors[:base].first).to eql "data not found via API"
            end

        end

        context "when called with invalid params" do

            let(:search) { Search.create({"query" => "invalid", "country" => "invalid", "currency" => "invalid", "locale" => "invalid"}) }

            it "doesn't create record" do
                expect { search }.to_not change { Search.count }
            end

            it "returns data not found via API error" do
                expect(search.errors[:base].first).to eql "data not found via API"
            end

        end

        context "when called with valid params" do

            let(:search) { Search.create({"query" => "Stockholm", "country" => "UK", "currency" => "GBP", "locale" => "en-GB"}) }

            it "creates record" do
                expect { search }.to change { Search.count }.by 1
            end

        end

    end

    describe ".airports" do

        context "when called" do

            let(:search) { Search.create({"query" => "Stockholm", "country" => "UK", "currency" => "GBP", "locale" => "en-GB"}) }

            it "returns airports as expected" do
                expect(search.airports).to include(
                    "Places"=>
                    [{"PlaceId"=>"STOC-sky", "PlaceName"=>"Stockholm", "CountryId"=>"SE-sky", "RegionId"=>"", "CityId"=>"STOC-sky", "CountryName"=>"Sweden"},
                     {"PlaceId"=>"ARN-sky", "PlaceName"=>"Stockholm Arlanda", "CountryId"=>"SE-sky", "RegionId"=>"", "CityId"=>"STOC-sky", "CountryName"=>"Sweden"},
                     {"PlaceId"=>"NYO-sky", "PlaceName"=>"Stockholm Skavsta", "CountryId"=>"SE-sky", "RegionId"=>"", "CityId"=>"STOC-sky", "CountryName"=>"Sweden"},
                     {"PlaceId"=>"BMA-sky", "PlaceName"=>"Stockholm Bromma", "CountryId"=>"SE-sky", "RegionId"=>"", "CityId"=>"STOC-sky", "CountryName"=>"Sweden"},
                     {"PlaceId"=>"VST-sky", "PlaceName"=>"Stockholm Vasteras", "CountryId"=>"SE-sky", "RegionId"=>"", "CityId"=>"STOC-sky", "CountryName"=>"Sweden"}]
                )
            end

        end

    end

end
