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

end
