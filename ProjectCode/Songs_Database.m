classdef Songs_Database < handle
    
    properties
        interface
        databaseFile = "SongDatabase.txt";
        resultfound;
    end
    
    methods
        function obj = Songs_Database(intface)
            obj.interface = intface;
            obj.updateTable;
            obj.resultfound = 0;
        end
        
        function updateTable(obj)
            data = obj.getAllSongData;
            obj.interface.UITable.Data = data;
        end
        
        function addSongToDatabase(obj, name, artist, url)
            if ~isfile(obj.databaseFile)
                file = obj.createSongDatabase(obj.databaseFile);
            else
                file = obj.openSongDatabase(obj.databaseFile);
                file.openForAppending;
            end
            
            fprintf(file.fid,"%s, %s, %s\n", name, artist, url);
            
            obj.updateTable;
            obj.sortSongDatabase; % Resort the entries
            file.closeFile;
            
            % Update practice tab
            obj.interface.practiceLog.populateSongsFromDataBase();
        end
    
        function deleteSongInDatabase(obj, name)
            answer = questdlg('Are you sure you want to delete all songs with this name?', 'Delete Song', ...
                'Yes','No','No');
            switch answer % Handle response
                case 'Yes'
                    alldata = string(obj.getAllSongData());
                    songdata = string(obj.getSongRows(name));
                    
                    alldata(ismember(alldata,songdata, 'rows'),:) = [];
                    
                    file = obj.openSongDatabase(obj.databaseFile);
                    file.openForWriting;
                    
                    for ii=1:numel(alldata(:,1))
                        obj.addSongToDatabase(alldata{ii,1},alldata{ii,2},alldata{ii,3});
                    end
                    
                    obj.updateTable;
                    obj.sortSongDatabase; % Resort the entries
                    
                    file.closeFile;
                case 'No'
                    disp([answer 'Song not deleted'])
            end
        end
    
        function sortSongDatabase(obj)
            data = obj.interface.UITable.Data;    % Get current data from table
            sortedData = sortrows(data, 1); % Sort the data by the first column
            obj.interface.UITable.Data = sortedData; % Add the data back to the table
        end
    
        function searchDatabase(obj, name)
            data = obj.getSongRows(name);
            
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
                obj.resultfound = 1;
                waitfor(questdlg(formattedData, 'Search Results', 'OK', 'Cancel', 'OK'));
            else
                questdlg(['Term ', name, ' not found'], 'Search Results', 'error');                
            end           
        end
        
        function songRows = getSongRows(obj, name)
            tableData = obj.interface.UITable.Data; % Get current data from table
            logArr = contains(tableData, name);
            songRows = tableData(logArr(:,1),:);
        end
        
        function data = getAllSongData(obj)
            file = obj.openSongDatabase(obj.databaseFile);
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
        function exl = createSongDatabase(filename)
            exl = DataHandler(filename);
            exl.openForWriting;
        end
        
        function exl = openSongDatabase(filename)
            exl = DataHandler(filename);
        end
    end
end