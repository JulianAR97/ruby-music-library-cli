class Artist 
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

    def add_song(song)
        if (song.artist == nil)
            song.artist = self 
        end 
        self.songs << song if !self.songs.include?(song) #maybe save
    end 

    def genres 
        self.songs.map {|song| song.genre}.uniq
    end 
end 

