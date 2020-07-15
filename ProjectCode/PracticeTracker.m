classdef PracticeTracker < handle
    
    properties
        interface
        files
    end
    
    methods
        function obj = PracticeTracker(intface)
            obj.interface = intface;
            
            % populate date and time fields
            obj.setDateTime;
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
            
            report = obj.createPracticeReport(instr, date, time); % Make excel sheet
            children = obj.interface.PracticeTrackerTab.Children; % get all properties
            sessionData = strings(numel(children),2); % initialize session data array
            
            % Loop through properties
            for ii = numel(children):-1:1
                thisProp = children(ii);
                % if a property is a drop down, edit field, or text area grab value
                isValueProp = strcmp(thisProp.Type,'uieditfield')...
                    ||strcmp(thisProp.Type,'uidropdown')...
                    ||strcmp(thisProp.Type,'uitextarea');
                
                % append type and value
                if isValueProp
                    sessionData(ii,:) = [thisProp.UserData,char(thisProp.Value)];
                    % UserData is set in the setUserData function in the
                    % app. User Data is used to store the name of the prop
                else
                    sessionData(ii,:) = [];
                end
            end
            
            report.addData(sessionData);
            obj.clearPracticeTracker;
        end
        
        function setUserData(obj)
            % This function sets the user data for each practice app component
            obj.interface.PracticeNotesTextArea.UserData = "Practice Notes";
            
            obj.interface.SongDropDown.UserData = "Song 1";
            obj.interface.MinutesEditField.UserData = "Song 1 Minutes";
            obj.interface.HoursEditField.UserData = "Song 1 Hours ";
            obj.interface.SongDropDown_2.UserData = "Song 2";
            obj.interface.MinutesEditField_2.UserData = "Song 2 Minutes ";
            obj.interface.HoursEditField_2.UserData = "Song 2 Hours 1";
            obj.interface.SongDropDown_3.UserData = "Song 3";
            obj.interface.MinutesEditField_3.UserData = "Song 3 Minutes";
            obj.interface.HoursEditField_3.UserData = "Song 3 Hours";
            
            obj.interface.DateEditField.UserData = "Date";
            obj.interface.TimeEditField.UserData = "Time";
            
            obj.interface.GoalTextArea.UserData = "Goal";
            obj.interface.InstrumentDropDown.UserData = "Instrument";
            obj.interface.AMPMDropDown.UserData = "AM PM";
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
            
            for ii = numel(children):-1:1
                thisProp = children(ii);
                % if a property is a drop down, edit field, or text area
                % set value
                isValueProp = strcmp(thisProp.Type,'uieditfield')...
                    ||strcmp(thisProp.Type,'uidropdown')...
                    ||strcmp(thisProp.Type,'uitextarea');
                
                if isValueProp
                    obj.setElementVal(report,thisProp);
                end
            end
            
            name = strsplit(filename, '_');
            time = name{3};
            obj.interface.TimeEditField.Value = [time(1:2),':',time(3:4)];
        end
        
    end
    
    methods (Static)
        function exl = createPracticeReport(instrument, date, time)
            
            filename = strcat(instrument, "_", erase(date,"/"), "_", erase(time,":"), ".xlsx");
            exl = ExcelHandler(filename);
        end
        
        function exl = openPracticeReport(filename)
            exl = ExcelHandler(filename);
        end
        
        function setElementVal(report, element)
            element.Value = report.getData(element.UserData);
        end
    end
    
end