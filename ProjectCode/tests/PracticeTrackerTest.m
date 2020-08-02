classdef PracticeTrackerTest < matlab.uitest.TestCase
    % Practice Tracker Unit Tests
    properties
        App
        tracker
    end
    
    methods (TestMethodSetup)
        function launchApp(testCase)
            cd  'W:\CIS350SemesterProject\ProjectCode';
            testCase.App = timbr;
            testCase.tracker = PracticeTracker(testCase.App);
            testCase.addTeardown(@delete,testCase.App);
        end
    end
    
    methods (Test)
        function testObjCreation(testCase)
            testCase.verifyEqual(class(testCase.tracker), 'PracticeTracker');
        end
        
        function testSetDateTime(testCase)
            testCase.tracker.setDateTime
            time = datestr(now,'HH:MM PM');
            testCase.verifyEqual(testCase.App.DateEditField.Value,datestr(now,'mm/dd/yyyy'));
            testCase.verifyEqual(testCase.App.TimeEditField.Value,strtrim(time(1:5)));
            testCase.verifyEqual(testCase.App.AMPMDropDown.Value,time(7:8));
        end
         
        function testSubmitSession(testCase)
            % set data
            testCase.type(testCase.App.PracticeNotesTextArea, "This is a test note");
            testCase.type(testCase.App.GoalTextArea, "This is a test goal");
            
            testCase.choose(testCase.App.SongDropDown, 1);
            testCase.type(testCase.App.MinutesEditField, 15);
            testCase.type(testCase.App.HoursEditField, 1);
            
            testCase.choose(testCase.App.SongDropDown_2, 1);
            testCase.type(testCase.App.MinutesEditField_2, 30);
            testCase.type(testCase.App.HoursEditField_2, 2);
            
            testCase.choose(testCase.App.SongDropDown_3, 1);
            testCase.type(testCase.App.MinutesEditField_3, 45);
            testCase.type(testCase.App.HoursEditField_3, 0);
            
            testCase.App.practiceLog.setDateTime;
            
            testCase.choose(testCase.App.InstrumentDropDown, 1);
            testCase.choose(testCase.App.AMPMDropDown, 1);
            
            % press button
            testCase.press(testCase.App.SubmitSessionButton);
            
            % verify file was created
            instr = testCase.App.InstrumentDropDown.Value;
            date = testCase.App.DateEditField.Value;
            time = testCase.App.TimeEditField.Value;
            curfolder = pwd;
            file = strcat(curfolder, '\', instr, "_", erase(date,"/"), "_", erase(time,":"), ".txt");
            testCase.verifyEqual(isfile(file),true);
        end
        
        function testRecallSession(testCase)
            % set data
            testCase.type(testCase.App.PracticeNotesTextArea, "This is a test note");
            testCase.type(testCase.App.GoalTextArea, "This is a test goal");
            
            testCase.choose(testCase.App.SongDropDown, 1);
            testCase.type(testCase.App.MinutesEditField, 15);
            testCase.type(testCase.App.HoursEditField, 1);
            
            testCase.choose(testCase.App.SongDropDown_2, 1);
            testCase.type(testCase.App.MinutesEditField_2, 30);
            testCase.type(testCase.App.HoursEditField_2, 2);
            
            testCase.choose(testCase.App.SongDropDown_3, 1);
            testCase.type(testCase.App.MinutesEditField_3, 45);
            testCase.type(testCase.App.HoursEditField_3, 0);
            
            testCase.App.practiceLog.setDateTime;
            
            testCase.choose(testCase.App.InstrumentDropDown, 1);
            testCase.choose(testCase.App.AMPMDropDown, 1);
            
            % press button
            testCase.press(testCase.App.SubmitSessionButton);
            
            % verify file was created
            instr = testCase.App.InstrumentDropDown.Value;
            date = testCase.App.DateEditField.Value;
            time = testCase.App.TimeEditField.Value;
            curfolder = pwd;
            file = strcat(curfolder, '\', instr, "_", erase(date,"/"), "_", erase(time,":"), ".txt");
            testCase.verifyEqual(isfile(file),true);
            
            testCase.App.practiceLog.getPracticeData(file);
            
            testCase.verifyEqual(testCase.App.PracticeNotesTextArea.Value, {'This is a test note'});
            testCase.verifyEqual(testCase.App.GoalTextArea.Value, {'This is a test goal'});
            
            testCase.verifyEqual(testCase.App.SongDropDown.Value, testCase.App.SongDropDown.Items{1});
            testCase.verifyEqual(testCase.App.MinutesEditField.Value, 15);
            testCase.verifyEqual(testCase.App.HoursEditField.Value, 1);
            
            
            testCase.verifyEqual(testCase.App.SongDropDown.Value, testCase.App.SongDropDown.Items{1});
            testCase.verifyEqual(testCase.App.MinutesEditField.Value, 15);
            testCase.verifyEqual(testCase.App.HoursEditField.Value, 1);
            
            testCase.choose(testCase.App.SongDropDown_2, 1);
            testCase.type(testCase.App.MinutesEditField_2, 30);
            testCase.type(testCase.App.HoursEditField_2, 2);
            
            testCase.choose(testCase.App.SongDropDown_3, 1);
            testCase.type(testCase.App.MinutesEditField_3, 45);
            testCase.type(testCase.App.HoursEditField_3, 0);
            
            testCase.choose(testCase.App.InstrumentDropDown, 1);
            testCase.choose(testCase.App.AMPMDropDown, 1);
        end
        
        function testClearSession(testCase)
            % set data
            testCase.type(testCase.App.PracticeNotesTextArea, "This is a test note");
            testCase.type(testCase.App.GoalTextArea, "This is a test goal");
            
            testCase.choose(testCase.App.SongDropDown, 1);
            testCase.type(testCase.App.MinutesEditField, 15);
            testCase.type(testCase.App.HoursEditField, 1);
            
            testCase.choose(testCase.App.SongDropDown_2, 1);
            testCase.type(testCase.App.MinutesEditField_2, 30);
            testCase.type(testCase.App.HoursEditField, 2);
            
            testCase.choose(testCase.App.SongDropDown, 1);
            testCase.type(testCase.App.MinutesEditField_3, 45);
            testCase.type(testCase.App.HoursEditField_3, 0);
            
            testCase.App.practiceLog.setDateTime;
            
            testCase.choose(testCase.App.InstrumentDropDown, 1);
            testCase.choose(testCase.App.AMPMDropDown, 1);
            
            % press button
            testCase.press(testCase.App.ClearInputsButton);
            
            % verify data
            children = testCase.App.PracticeTrackerTab.Children; % get all properties
            
            for ii = numel(children):-1:1
                thisProp = children(ii);
                
                if strcmp(thisProp.Type,'uitextarea')
                    testCase.verifyEqual(thisProp.Value,{''});
                elseif strcmp(thisProp.Type,'uidropdown')
                    testCase.verifyEqual(thisProp.Value, thisProp.Items{1});
                elseif strcmp(thisProp.Type,'uieditfield')
                    if ~(strcmp(thisProp.UserData, "Date")||strcmp(thisProp.UserData, "Time"))
                        testCase.verifyEqual(thisProp.Value, {0});
                    end
                end
            end
        end
    end
end