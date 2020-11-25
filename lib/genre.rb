class Genre
    extend Concerns::Findable
    extend Concerns::SaveAll::ClassMethods
    include Concerns::SaveAll::InstanceMethods
    attr_accessor :name, :songs
    @@all = []

    def initialize(name)
        @name = name 
        @songs = []
    end 

    def self.all 
        @@all 
    end 

    def artists
        self.songs.map {|song| song.artist}.uniq
    end 
end 