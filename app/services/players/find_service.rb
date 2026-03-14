module Players
  class FindService
    def self.call(nickname)
      Player.where("LOWER(nickname) = ?", nickname.downcase).last
    end
  end
end
