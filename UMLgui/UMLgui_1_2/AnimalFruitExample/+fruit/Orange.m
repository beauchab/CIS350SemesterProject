classdef Orange < fruit.Fruit
    methods 
        function obj = Orange
            obj.Color = "Green";
        end
        function ripen(obj)
            obj.Color = "Orange";
        end
    end
end