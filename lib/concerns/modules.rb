module Concerns
    
    module Findable 
        
        def find_by_name(name)
            all.find {|ele| ele.name == name} 
        end 

        def find_or_create_by_name(name)
            if find_by_name(name) != nil 
                find_by_name(name)
            else 
                create(name)
            end 
        end 
    
    end 

    module SaveAll 
        
        module ClassMethods

            def destroy_all 
                all.clear 
            end 

            def create(name)
                new_inst = self.new(name)
                new_inst.save
                new_inst
            end 
        
        end 
        
        module InstanceMethods 
            
            def save 
                self.class.all << self
            end 
        
        end 
    end 
end

