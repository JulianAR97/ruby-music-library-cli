class MusicImporter 
    attr_accessor :file_collection
    attr_reader :path
    @@all = []
    
    def initialize(path)
        @path = path 
        @file_collection = []
    end 

    def self.all 
        @@all 
    end 
    
    def files 
        Dir.children(self.path).each {|file| self.file_collection << file}
    end 
    
    def import 
        self.files.each {|file| self.class.all << Song.create_from_filename(file)}
    end 
end 



