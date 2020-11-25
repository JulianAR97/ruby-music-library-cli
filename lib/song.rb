class Song
    extend Concerns::Findable
    extend Concerns::SaveAll::ClassMethods
    include Concerns::SaveAll::InstanceMethods
    attr_accessor :name
    attr_reader :artist, :genre
    @@all = []
    
    def initialize(name, artist = nil, genre = nil)
        @name = name 
        self.artist = artist if artist != nil
        self.genre = genre if genre != nil
    end 

    def self.all 
        @@all 
    end 

    def artist=(artist)
        @artist = artist 
        self.artist.add_song(self)
    end 

    def genre=(genre)
        @genre = genre 
        self.genre.songs << self if !self.genre.songs.include?(self)
    end 

    # Sample Filename => "Thundercat - For Love I Come - dance.mp3"
    def self.new_from_filename(filename)
        split_arr = filename.split(" - ") #["Thundercat", "For Love I Come", "dance.mp3"]
        title = split_arr[1]

        #Find or Create Artist and Genre so that when we create a new song we are using
        #Instances of Artist/Genre instead of name strings 
        artist = Artist.find_or_create_by_name(split_arr[0])
        genre = Genre.find_or_create_by_name(split_arr[2].split('.')[0])     
        new(title, artist, genre)      
    end
    
    def self.create_from_filename(filename)
        self.new_from_filename(filename).save
    end 

end 


