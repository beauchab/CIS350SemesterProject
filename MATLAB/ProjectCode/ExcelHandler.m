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
        
        function value = getData(obj, name)
            [~,~,data] = xlsread(obj.filename);
            value = data{ismember(data(:,1), name),2};
            
            % Error checking
            if isnan(value)
                value = ' ';
            end
            
            if isa(value,'double')
                value = num2str(value);
            end
        end
    end
end