module Teams
  class FindService
    def self.call(name)
      Team.where("LOWER(name) = ?", name.downcase).last
    end
  end
end
