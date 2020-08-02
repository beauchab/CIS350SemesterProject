classdef timbr < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        timbrApp                      matlab.ui.Figure
        FileMenu                      matlab.ui.container.Menu
        ExitMenu                      matlab.ui.container.Menu
        TabGroup                      matlab.ui.container.TabGroup
        PracticeTrackerTab            matlab.ui.container.Tab
        PracticeNotesTextAreaLabel    matlab.ui.control.Label
        PracticeNotesTextArea         matlab.ui.control.TextArea
        DateEditFieldLabel            matlab.ui.control.Label
        DateEditField                 matlab.ui.control.EditField
        TimeEditFieldLabel            matlab.ui.control.Label
        TimeEditField                 matlab.ui.control.EditField
        GoalLabel                     matlab.ui.control.Label
        GoalTextArea                  matlab.ui.control.TextArea
        InstrumentDropDownLabel       matlab.ui.control.Label
        InstrumentDropDown            matlab.ui.control.DropDown
        SubmitSessionButton           matlab.ui.control.Button
        AMPMDropDown                  matlab.ui.control.DropDown
        SongDatabaseButton            matlab.ui.control.Button
        SongPieceDropDownLabel        matlab.ui.control.Label
        SongDropDown                  matlab.ui.control.DropDown
        SongPieceDropDown_2Label      matlab.ui.control.Label
        SongDropDown_2                matlab.ui.control.DropDown
        SongPieceDropDown_3Label      matlab.ui.control.Label
        SongDropDown_3                matlab.ui.control.DropDown
        HoursEditFieldLabel           matlab.ui.control.Label
        HoursEditField                matlab.ui.control.NumericEditField
        MinutesEditFieldLabel         matlab.ui.control.Label
        MinutesEditField              matlab.ui.control.NumericEditField
        MinutesEditField_2Label       matlab.ui.control.Label
        MinutesEditField_2            matlab.ui.control.NumericEditField
        HoursEditField_2Label         matlab.ui.control.Label
        HoursEditField_2              matlab.ui.control.NumericEditField
        MinutesEditField_3Label       matlab.ui.control.Label
        MinutesEditField_3            matlab.ui.control.NumericEditField
        HoursEditField_3Label         matlab.ui.control.Label
        HoursEditField_3              matlab.ui.control.NumericEditField
        ClearInputsButton             matlab.ui.control.Button
        RecallSessionButton           matlab.ui.control.Button
        GeneratePracticeReportButton  matlab.ui.control.Button
        GuitarChordsTab               matlab.ui.container.Tab
        GuitarChords_CAGEDLB          matlab.ui.control.ListBox
        GuitarChords_CO5Axes          matlab.ui.control.UIAxes
        GuitarChords_DisplayChordBtn  matlab.ui.control.Button
        KeyDropDownLabel              matlab.ui.control.Label
        GuitarChords_KeyDD            matlab.ui.control.DropDown
        ChordDropDownLabel            matlab.ui.control.Label
        GuitarChords_ChordDD          matlab.ui.control.DropDown
        SongDatabaseTab               matlab.ui.container.Tab
        AddSongButton                 matlab.ui.control.Button
        UITable                       matlab.ui.control.Table
        DeleteSongButton              matlab.ui.control.Button
        SearchButton                  matlab.ui.control.Button
        InstrumentsTab                matlab.ui.container.Tab
        AddInstrumentButton           matlab.ui.control.Button
        UITable2                      matlab.ui.control.Table
        DeleteInstrumentButton        matlab.ui.control.Button
    end

    
    properties (Access = public)
        practiceLog     % Practice Tracker object
        songDatabase    % Song database object
        instrsDatabase  % Instruments database object
        gcRealizer      % Guitar Chord Realizer objet
        
        rootFolder = 'W:\CIS350SemesterProject'
    end
    
    methods (Access = public)        
        function results = getSongs(app)
            results = app.UITable.Data(:,1);
        end
        
        function results = getInstruments(app)
            results = app.UITable2.Data(:,1);
        end
        
        
        function dispInitImages(app)
            
            % Display initial chord
            file = dir(fullfile(app.rootFolder , '**\TIMBR_DAT\A.png'));
            fullpath = fullfile(file.folder, file.name);
            I3 = imshow(fullpath, 'Parent', app.GuitarChords_CO5Axes, ...
                'XData', [1 app.GuitarChords_CO5Axes.Position(3)], ...
                'YData', [1 app.GuitarChords_CO5Axes.Position(4)]);
            % Set limits of axes
            app.GuitarChords_CO5Axes.XLim = [0 I3.XData(2)];
            app.GuitarChords_CO5Axes.YLim = [0 I3.YData(2)];
            set(app.GuitarChords_CO5Axes,'xticklabel',{[]},'yticklabel',{[]})
        end
    end
    
    
    methods (Static)
        function results = isValidDate(in)
            date = strsplit(in, '/');
            if ~(numel(date) == 3)
                results = false;
                return
            end
            
            month = str2double(date{1});
            day = str2double(date{2});
            year = str2double(date{3});
            
            if isnan(month) || isnan(day) || isnan(year)
                results = false;
                return
            end
            % test month for correct range
            if (month < 0) || (month > 12)
                results = false;
                % test day for correct range
            elseif (day < 0) || (day> 31)
                results = false;
                % test year for correct range
            elseif (year < 1000 || year > 3000)
                results = false;
                % If we reach here, date is correct format
            else
                results = true;
            end
        end
        
        function results = isValidTime(in)
            date = strsplit(in, ':');
            if ~(numel(date) == 2)
                results = false;
                return
            end
            
            hour = str2double(date{1});
            min = str2double(date{2});
            
            if isnan(hour) || isnan(min)
                results = false;
                return
            end
            % test hour for correct range
            if (hour < 0) || (hour > 12)
                results = false;
                % test min for correct range
            elseif (min < 0) || (min > 60)
                results = false;
            else
                results = true;
            end
        end
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            % Database setup
            app.songDatabase = Songs_Database(app);
            app.instrsDatabase = Instruments_Database(app,app.UITable2);
            
            % Guitar Chord Realizer Setup
            app.dispInitImages;
            app.gcRealizer = GuitarChordRealizer(app);
            app.gcRealizer.concatChords(app.GuitarChords_KeyDD.Value);
            
            % Practice log
            app.practiceLog = PracticeTracker(app); % Creates the practiceTracker object
            
        end

        % Button pushed function: SubmitSessionButton
        function SubmitSessionButtonPushed(app, event)
            if ~(app.isValidDate(app.DateEditField.Value) && app.isValidTime(app.TimeEditField.Value))
                uiconfirm(app.timbrApp,'Invalid Time or date, please enter date in format mm/dd/yyyy, and time in format hh:mm','Invalid Date Time',...
                    'Icon','warning');
                return
            else
                app.practiceLog.submitSession;
                uiconfirm(app.timbrApp,'Session Submitted','Session Submit',...
                    'Icon','success');
            end
        end

        % Value changed function: DateEditField
        function DateEditFieldValueChanged(app, event)
            value = app.DateEditField.Value;
            if app.isValidDate(value)
                return
            else
                uiconfirm(app.timbrApp,'Invalid Date, please enter date in format mm/dd/yyyy','Invalid Date',...
                    'Icon','warning');
            end
        end

        % Value changed function: TimeEditField
        function TimeEditFieldValueChanged(app, event)
            value = app.TimeEditField.Value;
            if app.isValidTime(value)
                return
            else
                uiconfirm(app.timbrApp,'Invalid Time, please enter time in format hh:mm','Invalid Time',...
                    'Icon','warning');
            end
        end

        % Button pushed function: ClearInputsButton
        function ClearInputsButtonPushed(app, event)
            app.practiceLog.clearPracticeTracker;
        end

        % Button pushed function: RecallSessionButton
        function RecallSessionButtonPushed(app, event)
            [file,path] = uigetfile('*.txt',... % Opens a dialog that lets you select png files
                'Select a file');
            if(file)
                app.practiceLog.getPracticeData([path, file]);
            end
        end

        % Value changed function: GuitarChords_KeyDD
        function GuitarChords_KeyDDValueChanged(app, event)
            key = app.GuitarChords_KeyDD.Value;
            
            %Function for updating Circle of 5ths Image
            app.gcRealizer.updateCO5PNG(key);
            
            %Concat Key chords to Chord Drop Down
            app.gcRealizer.concatChords(key);
            
            %Retrieve value selected in Chord Drop Down
            value = app.GuitarChords_ChordDD.Value;
            
            %Method for Concat Caged Slider
            app.gcRealizer.concatCaged(value);
        end

        % Button pushed function: GuitarChords_DisplayChordBtn
        function GuitarChords_DisplayChordBtnButtonPushed(app, event)
            %Logic for displaying guitar chord
            app.gcRealizer.dispGuitarChord;
        end

        % Button pushed function: AddSongButton
        function AddSongButtonPushed(app, event)
            prompt = {'Enter song name','Enter song artist(s)','Enter URL to purchase sheet music'};
            dlgtitle = 'Add Song';
            dims = [1 35];
            definput = {'','',''};
            answer = inputdlg(prompt,dlgtitle,dims,definput);
            if(~ isempty(answer))
                app.songDatabase.addSongToDatabase(answer{1},answer{2},answer{3});
            end
        end

        % Button pushed function: DeleteSongButton
        function DeleteSongButtonPushed(app, event)
            prompt = {'Enter song name'};
            dlgtitle = 'Delete Song';
            dims = [1 35];
            definput = {''};
            answer = inputdlg(prompt,dlgtitle,dims,definput);
            if(~ isempty(answer))
                app.songDatabase.deleteSongInDatabase(answer{1});
            end
        end

        % Button pushed function: SearchButton
        function SearchButtonPushed(app, event)
            prompt = {'Enter song name'};
            dlgtitle = 'Search for a Song';
            dims = [1 35];
            definput = {''};
            answer = inputdlg(prompt,dlgtitle,dims,definput);
            if(~ isempty(answer))
                app.songDatabase.searchDatabase(answer{1});
            end
        end

        % Button pushed function: SongDatabaseButton
        function SongDatabaseButtonPushed(app, event)
            app.TabGroup.SelectedTab = app.SongDatabaseTab;
        end

        % Button pushed function: GeneratePracticeReportButton
        function GeneratePracticeReportButtonPushed(app, event)
            GenerateReport(app.getSongs, app.getInstruments);
        end

        % Button pushed function: AddInstrumentButton
        function AddInstrumentButtonPushed(app, event)
            prompt = 'Enter Instrument name';
            dlgtitle = 'Add Instrument';
            dims = [1 35];
            definput = {' '};
            answer = inputdlg(prompt,dlgtitle,dims,definput);
            if(~ isempty(answer))
                app.instrsDatabase.addToDatabase(answer{1},0);
            end
        end

        % Button pushed function: DeleteInstrumentButton
        function DeleteInstrumentButtonPushed(app, event)
            prompt = {'Enter Instrument name'};
            dlgtitle = 'Delete Instrument';
            dims = [1 35];
            definput = {''};
            answer = inputdlg(prompt,dlgtitle,dims,definput);
            if(~ isempty(answer))
                app.instrsDatabase.deleteFromDatabase(answer{1});
            end
        end

        % Callback function
        function SearchButton_2Pushed(app, event)
            prompt = {'Enter Instrument name'};
            dlgtitle = 'Search for a Song';
            dims = [1 35];
            definput = {''};
            answer = inputdlg(prompt,dlgtitle,dims,definput);
            if(~ isempty(answer))
                app.instrsDatabase.searchDatabase(answer{1});
            end
        end

        % Value changed function: GuitarChords_ChordDD
        function GuitarChords_ChordDDValueChanged(app, event)
            %Retrieve value selected in Chord Drop Down
            value = app.GuitarChords_ChordDD.Value;
            
    	    %Method for Concat Caged Slider
            app.gcRealizer.concatCaged(value);
        end

        % Menu selected function: ExitMenu
        function ExitMenuSelected(app, event)
            close(app.timbrApp);
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create timbrApp and hide until all components are created
            app.timbrApp = uifigure('Visible', 'off');
            app.timbrApp.Position = [100 100 776 475];
            app.timbrApp.Name = 'UI Figure';

            % Create FileMenu
            app.FileMenu = uimenu(app.timbrApp);
            app.FileMenu.Text = 'File';

            % Create ExitMenu
            app.ExitMenu = uimenu(app.FileMenu);
            app.ExitMenu.MenuSelectedFcn = createCallbackFcn(app, @ExitMenuSelected, true);
            app.ExitMenu.Text = 'Exit';

            % Create TabGroup
            app.TabGroup = uitabgroup(app.timbrApp);
            app.TabGroup.TabLocation = 'left';
            app.TabGroup.Position = [1 1 776 475];

            % Create PracticeTrackerTab
            app.PracticeTrackerTab = uitab(app.TabGroup);
            app.PracticeTrackerTab.Title = 'Practice Tracker';

            % Create PracticeNotesTextAreaLabel
            app.PracticeNotesTextAreaLabel = uilabel(app.PracticeTrackerTab);
            app.PracticeNotesTextAreaLabel.HorizontalAlignment = 'right';
            app.PracticeNotesTextAreaLabel.Position = [8 133 84 22];
            app.PracticeNotesTextAreaLabel.Text = 'Practice Notes';

            % Create PracticeNotesTextArea
            app.PracticeNotesTextArea = uitextarea(app.PracticeTrackerTab);
            app.PracticeNotesTextArea.Position = [107 60 539 97];

            % Create DateEditFieldLabel
            app.DateEditFieldLabel = uilabel(app.PracticeTrackerTab);
            app.DateEditFieldLabel.HorizontalAlignment = 'right';
            app.DateEditFieldLabel.Position = [12 442 31 22];
            app.DateEditFieldLabel.Text = 'Date';

            % Create DateEditField
            app.DateEditField = uieditfield(app.PracticeTrackerTab, 'text');
            app.DateEditField.ValueChangedFcn = createCallbackFcn(app, @DateEditFieldValueChanged, true);
            app.DateEditField.Position = [58 442 100 22];

            % Create TimeEditFieldLabel
            app.TimeEditFieldLabel = uilabel(app.PracticeTrackerTab);
            app.TimeEditFieldLabel.HorizontalAlignment = 'right';
            app.TimeEditFieldLabel.Position = [166 442 32 22];
            app.TimeEditFieldLabel.Text = 'Time';

            % Create TimeEditField
            app.TimeEditField = uieditfield(app.PracticeTrackerTab, 'text');
            app.TimeEditField.ValueChangedFcn = createCallbackFcn(app, @TimeEditFieldValueChanged, true);
            app.TimeEditField.Position = [213 442 100 22];

            % Create GoalLabel
            app.GoalLabel = uilabel(app.PracticeTrackerTab);
            app.GoalLabel.Position = [12 403 235 22];
            app.GoalLabel.Text = 'What''s your goal for this practice session? ';

            % Create GoalTextArea
            app.GoalTextArea = uitextarea(app.PracticeTrackerTab);
            app.GoalTextArea.Position = [12 334 634 60];

            % Create InstrumentDropDownLabel
            app.InstrumentDropDownLabel = uilabel(app.PracticeTrackerTab);
            app.InstrumentDropDownLabel.HorizontalAlignment = 'right';
            app.InstrumentDropDownLabel.Position = [390 442 62 22];
            app.InstrumentDropDownLabel.Text = 'Instrument';

            % Create InstrumentDropDown
            app.InstrumentDropDown = uidropdown(app.PracticeTrackerTab);
            app.InstrumentDropDown.Items = {'Guitar', 'Piano', 'Vocals', 'Trombone'};
            app.InstrumentDropDown.Position = [467 442 100 22];
            app.InstrumentDropDown.Value = 'Guitar';

            % Create SubmitSessionButton
            app.SubmitSessionButton = uibutton(app.PracticeTrackerTab, 'push');
            app.SubmitSessionButton.ButtonPushedFcn = createCallbackFcn(app, @SubmitSessionButtonPushed, true);
            app.SubmitSessionButton.Position = [546 13 100 22];
            app.SubmitSessionButton.Text = 'Submit Session';

            % Create AMPMDropDown
            app.AMPMDropDown = uidropdown(app.PracticeTrackerTab);
            app.AMPMDropDown.Items = {'AM', 'PM'};
            app.AMPMDropDown.Position = [317 442 59 22];
            app.AMPMDropDown.Value = 'AM';

            % Create SongDatabaseButton
            app.SongDatabaseButton = uibutton(app.PracticeTrackerTab, 'push');
            app.SongDatabaseButton.ButtonPushedFcn = createCallbackFcn(app, @SongDatabaseButtonPushed, true);
            app.SongDatabaseButton.Position = [540 238 100 22];
            app.SongDatabaseButton.Text = 'Song Database';

            % Create SongPieceDropDownLabel
            app.SongPieceDropDownLabel = uilabel(app.PracticeTrackerTab);
            app.SongPieceDropDownLabel.HorizontalAlignment = 'right';
            app.SongPieceDropDownLabel.Position = [19 271 67 22];
            app.SongPieceDropDownLabel.Text = 'Song/Piece';

            % Create SongDropDown
            app.SongDropDown = uidropdown(app.PracticeTrackerTab);
            app.SongDropDown.Position = [101 271 95 22];

            % Create SongPieceDropDown_2Label
            app.SongPieceDropDown_2Label = uilabel(app.PracticeTrackerTab);
            app.SongPieceDropDown_2Label.HorizontalAlignment = 'right';
            app.SongPieceDropDown_2Label.Position = [19 240 67 22];
            app.SongPieceDropDown_2Label.Text = 'Song/Piece';

            % Create SongDropDown_2
            app.SongDropDown_2 = uidropdown(app.PracticeTrackerTab);
            app.SongDropDown_2.Position = [101 240 95 22];

            % Create SongPieceDropDown_3Label
            app.SongPieceDropDown_3Label = uilabel(app.PracticeTrackerTab);
            app.SongPieceDropDown_3Label.HorizontalAlignment = 'right';
            app.SongPieceDropDown_3Label.Position = [19 207 67 22];
            app.SongPieceDropDown_3Label.Text = 'Song/Piece';

            % Create SongDropDown_3
            app.SongDropDown_3 = uidropdown(app.PracticeTrackerTab);
            app.SongDropDown_3.Position = [101 207 95 22];

            % Create HoursEditFieldLabel
            app.HoursEditFieldLabel = uilabel(app.PracticeTrackerTab);
            app.HoursEditFieldLabel.HorizontalAlignment = 'right';
            app.HoursEditFieldLabel.Position = [284 271 38 22];
            app.HoursEditFieldLabel.Text = 'Hours';

            % Create HoursEditField
            app.HoursEditField = uieditfield(app.PracticeTrackerTab, 'numeric');
            app.HoursEditField.Position = [337 271 30 22];

            % Create MinutesEditFieldLabel
            app.MinutesEditFieldLabel = uilabel(app.PracticeTrackerTab);
            app.MinutesEditFieldLabel.HorizontalAlignment = 'right';
            app.MinutesEditFieldLabel.Position = [375 271 48 22];
            app.MinutesEditFieldLabel.Text = 'Minutes';

            % Create MinutesEditField
            app.MinutesEditField = uieditfield(app.PracticeTrackerTab, 'numeric');
            app.MinutesEditField.Position = [438 271 30 22];

            % Create MinutesEditField_2Label
            app.MinutesEditField_2Label = uilabel(app.PracticeTrackerTab);
            app.MinutesEditField_2Label.HorizontalAlignment = 'right';
            app.MinutesEditField_2Label.Position = [375 240 48 22];
            app.MinutesEditField_2Label.Text = 'Minutes';

            % Create MinutesEditField_2
            app.MinutesEditField_2 = uieditfield(app.PracticeTrackerTab, 'numeric');
            app.MinutesEditField_2.Position = [438 240 30 22];

            % Create HoursEditField_2Label
            app.HoursEditField_2Label = uilabel(app.PracticeTrackerTab);
            app.HoursEditField_2Label.HorizontalAlignment = 'right';
            app.HoursEditField_2Label.Position = [284 240 38 22];
            app.HoursEditField_2Label.Text = 'Hours';

            % Create HoursEditField_2
            app.HoursEditField_2 = uieditfield(app.PracticeTrackerTab, 'numeric');
            app.HoursEditField_2.Position = [337 240 30 22];

            % Create MinutesEditField_3Label
            app.MinutesEditField_3Label = uilabel(app.PracticeTrackerTab);
            app.MinutesEditField_3Label.HorizontalAlignment = 'right';
            app.MinutesEditField_3Label.Position = [375 207 48 22];
            app.MinutesEditField_3Label.Text = 'Minutes';

            % Create MinutesEditField_3
            app.MinutesEditField_3 = uieditfield(app.PracticeTrackerTab, 'numeric');
            app.MinutesEditField_3.Position = [438 207 30 22];

            % Create HoursEditField_3Label
            app.HoursEditField_3Label = uilabel(app.PracticeTrackerTab);
            app.HoursEditField_3Label.HorizontalAlignment = 'right';
            app.HoursEditField_3Label.Position = [284 207 38 22];
            app.HoursEditField_3Label.Text = 'Hours';

            % Create HoursEditField_3
            app.HoursEditField_3 = uieditfield(app.PracticeTrackerTab, 'numeric');
            app.HoursEditField_3.Position = [337 207 30 22];

            % Create ClearInputsButton
            app.ClearInputsButton = uibutton(app.PracticeTrackerTab, 'push');
            app.ClearInputsButton.ButtonPushedFcn = createCallbackFcn(app, @ClearInputsButtonPushed, true);
            app.ClearInputsButton.Position = [8 17 100 22];
            app.ClearInputsButton.Text = 'Clear Inputs';

            % Create RecallSessionButton
            app.RecallSessionButton = uibutton(app.PracticeTrackerTab, 'push');
            app.RecallSessionButton.ButtonPushedFcn = createCallbackFcn(app, @RecallSessionButtonPushed, true);
            app.RecallSessionButton.Position = [429 13 100 22];
            app.RecallSessionButton.Text = 'Recall Session';

            % Create GeneratePracticeReportButton
            app.GeneratePracticeReportButton = uibutton(app.PracticeTrackerTab, 'push');
            app.GeneratePracticeReportButton.ButtonPushedFcn = createCallbackFcn(app, @GeneratePracticeReportButtonPushed, true);
            app.GeneratePracticeReportButton.Position = [117 17 152 22];
            app.GeneratePracticeReportButton.Text = 'Generate Practice Report';

            % Create GuitarChordsTab
            app.GuitarChordsTab = uitab(app.TabGroup);
            app.GuitarChordsTab.Title = 'Guitar Chords';

            % Create GuitarChords_CAGEDLB
            app.GuitarChords_CAGEDLB = uilistbox(app.GuitarChordsTab);
            app.GuitarChords_CAGEDLB.Items = {'C', 'A', 'G', 'E', 'D'};
            app.GuitarChords_CAGEDLB.Position = [79 155 47 90];
            app.GuitarChords_CAGEDLB.Value = 'C';

            % Create GuitarChords_CO5Axes
            app.GuitarChords_CO5Axes = uiaxes(app.GuitarChordsTab);
            app.GuitarChords_CO5Axes.Position = [160 13 472 435];

            % Create GuitarChords_DisplayChordBtn
            app.GuitarChords_DisplayChordBtn = uibutton(app.GuitarChordsTab, 'push');
            app.GuitarChords_DisplayChordBtn.ButtonPushedFcn = createCallbackFcn(app, @GuitarChords_DisplayChordBtnButtonPushed, true);
            app.GuitarChords_DisplayChordBtn.Position = [41 46 100 22];
            app.GuitarChords_DisplayChordBtn.Text = 'Display Chord';

            % Create KeyDropDownLabel
            app.KeyDropDownLabel = uilabel(app.GuitarChordsTab);
            app.KeyDropDownLabel.HorizontalAlignment = 'right';
            app.KeyDropDownLabel.Position = [15 406 26 22];
            app.KeyDropDownLabel.Text = 'Key';

            % Create GuitarChords_KeyDD
            app.GuitarChords_KeyDD = uidropdown(app.GuitarChordsTab);
            app.GuitarChords_KeyDD.Items = {'A', 'Bb', 'B', 'C', 'Db', 'D', 'Eb', 'E', 'F', 'Gb', 'G', 'Ab'};
            app.GuitarChords_KeyDD.ValueChangedFcn = createCallbackFcn(app, @GuitarChords_KeyDDValueChanged, true);
            app.GuitarChords_KeyDD.Position = [56 406 85 22];
            app.GuitarChords_KeyDD.Value = 'A';

            % Create ChordDropDownLabel
            app.ChordDropDownLabel = uilabel(app.GuitarChordsTab);
            app.ChordDropDownLabel.HorizontalAlignment = 'right';
            app.ChordDropDownLabel.Position = [12 301 38 22];
            app.ChordDropDownLabel.Text = 'Chord';

            % Create GuitarChords_ChordDD
            app.GuitarChords_ChordDD = uidropdown(app.GuitarChordsTab);
            app.GuitarChords_ChordDD.Items = {'I', 'ii', 'iii', 'IV', 'V', 'vi', 'vii'};
            app.GuitarChords_ChordDD.ValueChangedFcn = createCallbackFcn(app, @GuitarChords_ChordDDValueChanged, true);
            app.GuitarChords_ChordDD.Position = [65 301 76 22];
            app.GuitarChords_ChordDD.Value = 'I';

            % Create SongDatabaseTab
            app.SongDatabaseTab = uitab(app.TabGroup);
            app.SongDatabaseTab.Title = 'Song Database';

            % Create AddSongButton
            app.AddSongButton = uibutton(app.SongDatabaseTab, 'push');
            app.AddSongButton.ButtonPushedFcn = createCallbackFcn(app, @AddSongButtonPushed, true);
            app.AddSongButton.Position = [78 444 100 22];
            app.AddSongButton.Text = 'Add Song';

            % Create UITable
            app.UITable = uitable(app.SongDatabaseTab);
            app.UITable.ColumnName = {'Title'; 'Artist/Composer'; 'URL'};
            app.UITable.RowName = {};
            app.UITable.Position = [78 11 498 416];

            % Create DeleteSongButton
            app.DeleteSongButton = uibutton(app.SongDatabaseTab, 'push');
            app.DeleteSongButton.ButtonPushedFcn = createCallbackFcn(app, @DeleteSongButtonPushed, true);
            app.DeleteSongButton.Position = [277 444 100 22];
            app.DeleteSongButton.Text = 'Delete Song';

            % Create SearchButton
            app.SearchButton = uibutton(app.SongDatabaseTab, 'push');
            app.SearchButton.ButtonPushedFcn = createCallbackFcn(app, @SearchButtonPushed, true);
            app.SearchButton.Position = [476 444 100 22];
            app.SearchButton.Text = 'Search';

            % Create InstrumentsTab
            app.InstrumentsTab = uitab(app.TabGroup);
            app.InstrumentsTab.Title = 'Instruments';

            % Create AddInstrumentButton
            app.AddInstrumentButton = uibutton(app.InstrumentsTab, 'push');
            app.AddInstrumentButton.ButtonPushedFcn = createCallbackFcn(app, @AddInstrumentButtonPushed, true);
            app.AddInstrumentButton.Position = [85 442 100 22];
            app.AddInstrumentButton.Text = 'Add Instrument';

            % Create UITable2
            app.UITable2 = uitable(app.InstrumentsTab);
            app.UITable2.ColumnName = {'Instrument'; 'Hours Practiced'};
            app.UITable2.RowName = {};
            app.UITable2.Position = [85 9 537 416];

            % Create DeleteInstrumentButton
            app.DeleteInstrumentButton = uibutton(app.InstrumentsTab, 'push');
            app.DeleteInstrumentButton.ButtonPushedFcn = createCallbackFcn(app, @DeleteInstrumentButtonPushed, true);
            app.DeleteInstrumentButton.Position = [512 442 110 22];
            app.DeleteInstrumentButton.Text = 'Delete Instrument';

            % Show the figure after all components are created
            app.timbrApp.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = timbr

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.timbrApp)

            % Execute the startup function
            runStartupFcn(app, @startupFcn)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.timbrApp)
        end
    end
end