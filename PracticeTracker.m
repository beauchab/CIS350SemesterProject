classdef PracticeTracker < handle
    
    properties
        interface
        files
    end
    
    methods
        function obj = PracticeTracker(intface)
            obj.interface = intface;
            
            % populate date and time fields
            obj.interface.DateEditField.Value = datestr(now,'mm/dd/yyyy');
            time = datestr(now,'HH:MM PM');
            obj.interface.TimeEditField.Value = strtrim(time(1:5));
            obj.interface.AMPMDropDown.Value = time(7:8);
        end
        
        function submitSession(obj)
            instr = obj.interface.InstrumentDropDown.Value;
            date = obj.interface.DateEditField.Value;
            time = obj.interface.TimeEditField.Value;
            
            report = obj.createPracticeReport(instr, date, time);
            
            
            % get all properties
            children = obj.interface.PracticeTrackerTab.Children;
            
            sessionData = strings(numel(children),2);
            
            for ii = numel(children):-1:1
                thisProp = children(ii);
                % if a property is a drop down or edit field grab its type and value
                isValueProp = strcmp(thisProp.Type,'uieditfield')...
                    ||strcmp(thisProp.Type,'uidropdown');
                
                % append date and value
                if isValueProp
                    sessionData(ii,:) = [thisProp.UserData,thisProp.Value]; 
                    % UserData is set in the setUserData function in the
                    % app. User Data is used to store the name of the prop
                else
                    sessionData(ii,:) = [];
                end
            end
            
            report.addData(sessionData);
                           
        end
        
        function addPracticeDataToFile
        end
        
        function getPracticeData
        end
        
    end
    
    methods (Static)
        function exl = createPracticeReport(instrument, date, time)
            
            filename = strcat(instrument, "_", erase(date,"/"), "_", erase(time,":"), ".xlsx");
            exl = ExcelHandler(filename);
        end
        
    end
    
end