classdef Songs_Database < handle
    
    properties
        interface
    end
    
    methods
        function obj = Songs_Database(intface)
            obj.interface = intface;
        end
        
        function addSongToDatabase(obj, name, artist, url)
            curData = obj.interface.UITable.Data; % Get current data from table
            newData = [curData; [{name}, {artist}, {url}]]; % append row to the bottom
            obj.interface.UITable.Data = newData; % Add the data back to the table
            obj.sortSongDatabase; % Resort the entries
            
            %ADD REPORT HERE
        end
    
        function deleteSongInDatabase(obj, name)
            answer = questdlg('Are you sure you want to delete this song?', 'Delete Song', ...
                'Yes','No','No');
            switch answer % Handle response
                case 'Yes'
                    disp([answer 'Song deleted'])
                    obj.interface.UITable.Data(ismember(obj.interface.UITable.Data(:,1),name),:) = []; % Search table for name and clear that row
                    obj.interface.sortSongDatabase; % Resort the entries
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
            tableData = obj.interface.UITable.Data; % Get current data from table
            
            %data = tableData(contains(tableData, name),:);
            
            data = [{'a'},{'b'},{'c'};...
                    {'d'},{'e'},{'f'}];
            [r, c] = size(data);
            formattedData = strings(r,1);
            for ii=1:r
                str = "";
                for jj=1:c
                    str = strcat(str, data{ii,jj}, " ");
                end
                formattedData(ii) = {str};
            end
                        
            uiconfirm(obj.interface.timbr, string(data), 'Search Results', 'Icon', 'success');            
        end
        
    end
    
    methods (Static)
        function exl = createSongDatabase()
            filename = "SongDatabase.txt";
            exl = DataHandler(filename);
            exl.openForWriting;
        end
        
        function exl = openSongDatabase(filename)
            exl = DataHandler(filename);
            exl.openForReading;
        end
    end
end