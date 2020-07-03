classdef ExcelHandler < handle
    
    properties
        filename
    end
    
    methods
        function obj = ExcelHandler(file)
            filename = file;
            writematrix(["Name", "Value"],filename)
        end
        
        function appendData(obj,name,value)
            writematrix([name, value],obj.filename,'WriteMode','append');            
        end
    end
end