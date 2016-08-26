classdef Animal
   
    properties
        
        id
        strain
        cage
        weight
        sex
        DOB
        
    end % properties
   
    methods
        
        % constructor
        function animal = Animal(id, strain, cage, sex, weight, DOB)
            animal.id       = id;
            animal.strain   = strain;
            animal.cage     = cage;
            animal.sex      = sex;
            animal.weight   = weight;
            animal.DOB      = DOB;
        end % constructor
   
    end % methods
   
end % classdef
