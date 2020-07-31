classdef DataHandler < handle
    
    properties
        filename
        fid;
    end
    
    methods
        function obj = DataHandler(file)
            obj.filename = file;
        end
        
        function openForWriting(obj)
            obj.fid = fopen(obj.filename,'w');
        end
        
        function openForReading(obj)
            obj.fid = fopen(obj.filename,'r');
        end
        
        function openForAppending(obj)
            obj.fid = fopen(obj.filename,'a');
        end
        
        function addData(obj,name, value, valType)
            fprintf(obj.fid,['%s ', valType, '\n'], name, value);           
        end
        
        function data = getData(obj)
            data = strings(15,1); % Hardcoded since we know how many inputs there are
            for ii=1:15
                data(ii) = fgetl(obj.fid);
            end
        end
        
        function closeFile(obj)
            fclose(obj.fid);
        end
    end
end