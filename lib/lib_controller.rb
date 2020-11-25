class MusicLibraryController 
    attr_reader :path 
    
    def initialize(path = './db/mp3s')
        @path = path 
        MusicImporter.new(path).import
    end 

    def call 
        puts "Welcome to your music library!"
        puts "To list all of your songs, enter 'list songs'."
        puts "To list all of the artists in your library, enter 'list artists'."
        puts "To list all of the genres in your library, enter 'list genres'."
        puts "To list all of the songs by a particular artist, enter 'list artist'." 
        puts "To list all of the songs of a particular genre, enter 'list genre'."
        puts "To play a song, enter 'play song'."
        puts "To quit, type 'exit'." 
        puts "What would you like to do?"
        
        # we use strip instead of strip here because strip gets rid of \n and whitespace
        # strip only gets rid of \n
        input = gets.strip 
        
        #Map out options with an hash to keep code neat 
        possibilites = {
            "list songs" => "list_songs",
            "list artists" => "list_artists",
            "list genres" => "list_genres",
            "list artist" => "list_songs_by_artist",
            "list genre" => "list_songs_by_genre",
            "play song" => "play_song"
        }
        return if input == 'exit'
        self.send(possibilites[input]) if possibilites[input] 

        #Keep running call and ask for user input until they explicitly 'exit'
        self.call
        
    end 

    def list_songs 
        sorted = Song.all.sort {|a, b| a.name <=> b.name}
        sorted.each_with_index do |song, i|
            # Return string needs to be formatted "1. artist - song - genre"
            puts "#{i + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
        end 
    end 


    def list_artists
        sorted = Artist.all.sort {|a, b| a.name <=> b.name}
        sorted.each_with_index do |artist, i|
            puts "#{i + 1}. #{artist.name}"
        end 
    end 

    def list_genres 
        sorted = Genre.all.sort {|a, b| a.name <=> b.name}
        sorted.each_with_index do |genre, i|
            puts "#{i + 1}. #{genre.name}"
        end 
    end 

    def list_songs_by_artist 
        puts "Please enter the name of an artist:"
        input = gets.strip
        if Artist.find_by_name(input)
            songs = Artist.find_by_name(input).songs.map {|song| song.name + ' - ' + song.genre.name}
            songs.sort.each_with_index {|song, i| puts "#{i + 1}. #{song}"} 
        end 
    end 

    def list_songs_by_genre 
        puts "Please enter the name of a genre:"
        input = gets.strip 
        if Genre.find_by_name(input)
            songs = Genre.find_by_name(input).songs.map {|song| [song.name, song.artist.name]}
            songs.sort! {|a, b| a[0] <=> b[0]}
            songs.each_with_index {|song, i| puts "#{i + 1}. #{song[1]} - #{song[0]}"}
        end 
    end 

    def play_song 
        puts "Which song number would you like to play?"
        input = gets.strip
        #Here we create an numbered array for all of the songs, and if it includes the input,
        #We return the song at that index in the alphabetical song array. 
        if (1..Song.all.size).to_a.join('').include?(input)
            song = Song.all.sort {|a, b| a.name <=> b.name}[input.to_i - 1]     
            puts "Playing #{song.name} by #{song.artist.name}"
        end 
    end 
end
