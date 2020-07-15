classdef PracticeTracker < handle
    
    properties
        interface
        files
    end
    
    methods
        function obj = PracticeTracker(intface)
            obj.interface = intface;
        end
        
        function addPracticeDataToFile
        end
        
        function getPracticeData
        end
        
    end
    
    methods (Static)
        function createPracticeReport(instrument, date, time, data)
            filename = strcat(instrument, "_", date, "_", time, ".xlsx");
            exl = ExcelHandler(filename);
            
            % append data
            for ii=1:numel(data)
                exl.appendData(data(ii,1),data(ii,2));
            end
        end
        
    end
    
end