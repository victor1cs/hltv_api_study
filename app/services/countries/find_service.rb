module Countries
  class FindService
    def self.call(name)
      Country.where("LOWER(name) = ?", name.downcase).last
    end
  end
end
