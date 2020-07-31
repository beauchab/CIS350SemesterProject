classdef PracticeTracker < handle
    
    properties
        interface
    end
    
    methods
        function obj = PracticeTracker(intface)
            obj.interface = intface;
            
            % Setup app
            obj.setDateTime;
            obj.setUserData;
            obj.populateSongsFromDataBase
            obj.populateInstrumentsFromDataBase;
        end
        
        function setDateTime(obj)
            obj.interface.DateEditField.Value = datestr(now,'mm/dd/yyyy');
            time = datestr(now,'HH:MM PM');
            obj.interface.TimeEditField.Value = strtrim(time(1:5));
            obj.interface.AMPMDropDown.Value = time(7:8);
        end
        
        function populateSongsFromDataBase(obj)
            data = obj.interface.UITable.Data;
            if isempty(data)
                obj.interface.SongDropDown.Items = {'N/A'};
                obj.interface.SongDropDown_2.Items = {'N/A'};
                obj.interface.SongDropDown_3.Items = {'N/A'};
            else
                obj.interface.SongDropDown.Items = data(:,1);
                obj.interface.SongDropDown_2.Items = data(:,1);
                obj.interface.SongDropDown_3.Items = data(:,1);
            end
        end
        
        function populateInstrumentsFromDataBase(obj)
            data = obj.interface.UITable2.Data;
            if isempty(data)
                obj.interface.InstrumentDropDown.Items = {'N/A'};
            else
                obj.interface.InstrumentDropDown.Items = data(:,1);
            end
        end
        
        function updateInstrumentHours(app, instrument,hours,mins)
            curData = app.UITable2.Data{ismember(app.UITable2.Data,instrument),2};
            app.UITable2.Data(ismember(app.UITable2.Data,instrument),2) = curData + hours + (mins/60);
        end
        
        function submitSession(obj)
            instr = obj.interface.InstrumentDropDown.Value;
            date = obj.interface.DateEditField.Value;
            time = obj.interface.TimeEditField.Value;
            
            report = obj.createPracticeReport(instr, date, time); % Make report
            children = obj.interface.PracticeTrackerTab.Children; % get all properties
            
            % Loop through properties
            for ii = numel(children):-1:1
                thisProp = children(ii);
                
                % append type and value based on type of property
                if strcmp(thisProp.Type,'uieditfield')||strcmp(thisProp.Type,'uidropdown')
                    report.addData(thisProp.UserData,thisProp.Value,'%s');
                    % UserData is set in the setUserData function in the
                    % app. User Data is used to store the name of the prop
                elseif strcmp(thisProp.Type,'uitextarea')
                    report.addData(thisProp.UserData,thisProp.Value{1},'%s');
                elseif strcmp(thisProp.Type,'uinumericeditfield')
                    report.addData(thisProp.UserData,thisProp.Value,'%d');
                end
            end
            report.closeFile;
            
            obj.clearPracticeTracker;
        end
        
        function setUserData(obj)
            % This function sets the user data for each practice app component
            obj.interface.PracticeNotesTextArea.UserData = "PracticeNotes";
            
            obj.interface.SongDropDown.UserData = "Song1";
            obj.interface.MinutesEditField.UserData = "SongMins1";
            obj.interface.HoursEditField.UserData = "SongHrs1 ";
            obj.interface.SongDropDown_2.UserData = "Song2";
            obj.interface.MinutesEditField_2.UserData = "SongMins2 ";
            obj.interface.HoursEditField_2.UserData = "SongHrs2";
            obj.interface.SongDropDown_3.UserData = "Song3";
            obj.interface.MinutesEditField_3.UserData = "SongMins3";
            obj.interface.HoursEditField_3.UserData = "SongHrs3";
            
            obj.interface.DateEditField.UserData = "Date";
            obj.interface.TimeEditField.UserData = "Time";
            
            obj.interface.GoalTextArea.UserData = "Goal";
            obj.interface.InstrumentDropDown.UserData = "Instrument";
            obj.interface.AMPMDropDown.UserData = "AMPM";
        end
        
        function clearPracticeTracker(obj)
            obj.interface.PracticeNotesTextArea.Value = "";
            
            obj.interface.SongDropDown.Value = obj.interface.SongDropDown.Items(1);
            obj.interface.MinutesEditField.Value = 0;
            obj.interface.HoursEditField.Value = 0;
            obj.interface.SongDropDown_2.Value = obj.interface.SongDropDown_2.Items(1);
            obj.interface.MinutesEditField_2.Value = 0;
            obj.interface.HoursEditField_2.Value = 0;
            obj.interface.SongDropDown_3.Value = obj.interface.SongDropDown_3.Items(1);
            obj.interface.MinutesEditField_3.Value = 0;
            obj.interface.HoursEditField_3.Value = 0;
            
            obj.setDateTime;
            
            obj.interface.GoalTextArea.Value = "";
            obj.interface.InstrumentDropDown.Value = obj.interface.InstrumentDropDown.Items(1);
            obj.interface.AMPMDropDown.Value = obj.interface.AMPMDropDown.Items(1);
        end
        
        function getPracticeData(obj, filename)
            report = obj.openPracticeReport(filename);
            children = obj.interface.PracticeTrackerTab.Children; % get all properties
            data = report.getData();
            
            for ii = numel(children):-1:1
                thisProp = children(ii);
                % if a property is a drop down, edit field, or text area
                % set value
                isValueProp = strcmp(thisProp.Type,'uieditfield')...
                    ||strcmp(thisProp.Type,'uidropdown')...
                    ||strcmp(thisProp.Type,'uitextarea');
                
                if isValueProp
                    thisProp.Value = strtrim(erase(data(contains(data,thisProp.UserData)),thisProp.UserData));
                elseif strcmp(thisProp.Type,'uinumericeditfield')
                    thisProp.Value = double(strtrim(erase(data(contains(data,thisProp.UserData)),thisProp.UserData)));
                end
            end
            
            report.closeFile;
            
            name = strsplit(filename, {'_','.'});
            time = name{3};
            if(length(time)<4)
                obj.interface.TimeEditField.Value = [time(1),':',time(2:3)];
            else
                obj.interface.TimeEditField.Value = [time(1:2),':',time(3:4)];
            end
            
        end
        
    end
    
    methods (Static)
        function exl = createPracticeReport(instrument, date, time)
            filename = strcat(instrument, "_", erase(date,"/"), "_", erase(time,":"), ".txt");
            exl = DataHandler(filename);
            exl.openForWriting;
        end
        
        function exl = openPracticeReport(filename)
            exl = DataHandler(filename);
            exl.openForReading;
            
            end
    end
    
    
end