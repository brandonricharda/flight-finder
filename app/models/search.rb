class Search < ApplicationRecord
    validates :query, presence: true
    validates :country, presence: true
    validates :currency, presence: true
    validates :locale, presence: true
    validates_with SearchValidator

    def package_data
        result = {}
        result["query"] = self.query
        result["country"] = self.country
        result["currency"] = self.currency
        result["locale"] = self.locale
        result
    end

    def airports
        JSON.parse(skyscanner.find_airports(package_data).body)
    end

    def skyscanner
        SkyScanner.new
    end

end
