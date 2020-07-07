classdef ExcelHandler < handle
    
    properties
        filename
    end
    
    methods
        function obj = ExcelHandler(file)
            obj.filename = file;
        end
        
        function addData(obj,data)
            xlswrite(obj.filename,data);           
        end
    end
end