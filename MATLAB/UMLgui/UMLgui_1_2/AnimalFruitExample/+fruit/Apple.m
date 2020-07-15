classdef Apple < fruit.Fruit
    methods 
        function obj = Apple
            obj.Color = "Green";
        end
        function ripen(obj)
            obj.Color = "Red";
        end
    end
end