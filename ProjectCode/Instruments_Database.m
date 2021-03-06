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
            obj.updateTable;
        end
        
        function updateTable(obj)
            if isfile(obj.databaseFile)
                data = obj.getAllData;
                obj.databaseTable.Data = data;
            end
        end
        
        function addToDatabase(obj, varargin)
            if ~isfile(obj.databaseFile)
                file = obj.createDatabase(obj.databaseFile);
            else
                file = obj.openDatabase(obj.databaseFile);
                file.openForAppending;
            end
            
            fprintf(file.fid,"%s, %s\n", varargin{1}, varargin{2});
            
            obj.updateTable;
            obj.sortDatabase; % Resort the entries
            file.closeFile;
            
            % Update practice tab
            obj.interface.practiceLog.populateInstrumentsFromDataBase();
        end
    
        function deleteFromDatabase(obj, name)
            answer = questdlg('Are you sure you want to delete all instruments with this name?', 'Delete Instrument', ...
                'Yes','No','No');
            switch answer % Handle response
                case 'Yes'
                    alldata = string(obj.getAllData());
                    rowdata = string(obj.getRows(name));
                    
                    alldata(ismember(alldata,rowdata, 'rows'),:) = [];
                    
                    file = obj.openDatabase(obj.databaseFile);
                    file.openForWriting;
                    
                    for ii=1:numel(alldata(:,1))
                        obj.addToDatabase(alldata{ii,1},alldata{ii,2});
                    end
                                        
                    file.closeFile;
                case 'No'
                    disp([answer 'Song not deleted'])
            end
        end
    
        function sortDatabase(obj)
            data = obj.databaseTable.Data;    % Get current data from table
            if ~isempty(data)&&(numel(data(:,1))>1)
                sortedData = sortrows(data, 1); % Sort the data by the first column
                obj.databaseTable.Data = sortedData; % Add the data back to the table
            end
        end
    
%         function searchDatabase(obj, name)
%             data = obj.getRows(name);
%             
%             [r, c] = size(data);
%             formattedData = strings(r,1);
%             for ii=1:r
%                 str = "";
%                 for jj=1:c
%                     str = strcat(str, data{ii,jj}, ", ");
%                 end
%                 formattedData(ii) = {str};
%             end
%                      
%             if ~isempty(formattedData)
%                 obj.resultfound = 1;
%                 waitfor(questdlg(formattedData, 'Search Results', 'OK', 'Cancel', 'OK'));
%             else
%                 questdlg(['Term ', name, ' not found'], 'Search Results', 'error');                
%             end           
%         end
        
        function rows = getRows(obj, name)
            tableData = obj.databaseTable.Data; % Get current data from table
            logArr = contains(tableData, name);
            rows = tableData(logArr(:,1),:);
        end
        
        function data = getAllData(obj)
            if ~isfile(obj.databaseFile)
                file = obj.createDatabase(obj.databaseFile);
            else
                file = obj.openDatabase(obj.databaseFile);
                file.openForReading;
            end
            data = [];
            line = fgetl(file.fid);
            while (line ~= -1)
                lineArr = strsplit(line,', ');
                data = [data; lineArr(:,1:2)];
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
      