classdef Fruit < handle
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Color
        SeedType
    end
    
    methods
        function obj = Fruit
            
        end
    end
    methods(Abstract)
        ripen(obj)
    end
    
end