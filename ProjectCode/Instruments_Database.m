classdef Instruments_Database < handle
    
    properties
        interface
        databaseFile = "InstrumentDatabase.txt";
        databaseTable
    end
    
    methods
        function obj = Instruments_Database(intface, dbTable)
            obj.interface = intface;
            obj.databaseTable = dbTable;
        end
        
        function updateTable(obj)
            data = obj.getAllData;
            obj.databaseTable = data;
        end
        
        function addToDatabase(obj, varargin)
            if ~isfile(obj.databaseFile)
                file = obj.createDatabase(obj.databaseFile);
            else
                file = obj.openDatabase(obj.databaseFile);
                file.openForAppending;
            end
            
            fprintf(file.fid,"%s, %d\n", varargin{1}, varargin{2});
            
            obj.updateTable;
            obj.sortDatabase; % Resort the entries
            file.closeFile;
        end
    
        function deleteFromDatabase(obj, name)
            answer = questdlg('Are you sure you want to delete all instruments with this name?', 'Delete Instrument', ...
                'Yes','No','No');
            switch answer % Handle response
                case 'Yes'
                    alldata = string(obj.getAllData());
                    rowdata = string(obj.getSongRows(name));
                    
                    alldata(ismember(alldata,rowdata, 'rows'),:) = [];
                    
                    file = obj.openDatabase(obj.databaseFile);
                    file.openForWriting;
                    
                    for ii=1:numel(alldata(:,1))
                        obj.addToDatabase(alldata{ii,1},alldata{ii,2});
                    end
                    
                    obj.updateTable;
                    obj.sortDatabase; % Resort the entries
                    
                    file.closeFile;
                case 'No'
                    disp([answer 'Song not deleted'])
            end
        end
    
        function sortDatabase(obj)
            data = obj.databaseTable.Data;    % Get current data from table
            sortedData = sortrows(data, 1); % Sort the data by the first column
            obj.databaseTable.Data = sortedData; % Add the data back to the table
        end
    
        function searchDatabase(obj, name)
            data = obj.getRows(name);
            
            [r, c] = size(data);
            formattedData = strings(r,1);
            for ii=1:r
                str = "";
                for jj=1:c
                    str = strcat(str, data{ii,jj}, ", ");
                end
                formattedData(ii) = {str};
            end
                     
            if ~isempty(formattedData)
                uiconfirm(obj.interface.timbrApp, formattedData, 'Search Results', 'Icon', 'success');
            else
                uiconfirm(obj.interface.timbrApp, ['Term ', name, ' not found'], 'Search Results', 'Icon', 'error');                
            end           
        end
        
        function rows = getRows(obj, name)
            tableData = obj.interface.UITable.Data; % Get current data from table
            logArr = contains(tableData, name);
            rows = tableData(logArr(:,1),:);
        end
        
        function data = getAllData(obj)
            file = obj.openDatabase(obj.databaseFile);
            file.openForReading;
            data = [];
            line = fgetl(file.fid);
            while (line ~= -1)
                data = [data; strsplit(line,',')];
                line = fgetl(file.fid);
            end
            file.closeFile;
        end    
    end
    
    methods (Static)
        function exl = createDatabase(filename)
            exl = DataHandler(filename);
            exl.openForWriting;
        end
        
        function exl = openDatabase(filename)
            exl = DataHandler(filename);
        end
    end
end
      