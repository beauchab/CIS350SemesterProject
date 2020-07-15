classdef AppMockUp < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        timbr                       matlab.ui.Figure
        FileMenu                    matlab.ui.container.Menu
        SettingsMenu                matlab.ui.container.Menu
        OptionsMenu                 matlab.ui.container.Menu
        TabGroup                    matlab.ui.container.TabGroup
        PracticeTrackerTab          matlab.ui.container.Tab
        PracticeNotesTextAreaLabel  matlab.ui.control.Label
        PracticeNotesTextArea       matlab.ui.control.TextArea
        DateEditFieldLabel          matlab.ui.control.Label
        DateEditField               matlab.ui.control.EditField
        TimeEditFieldLabel          matlab.ui.control.Label
        TimeEditField               matlab.ui.control.EditField
        GoalLabel                   matlab.ui.control.Label
        GoalTextArea                matlab.ui.control.TextArea
        InstrumentDropDownLabel     matlab.ui.control.Label
        InstrumentDropDown          matlab.ui.control.DropDown
        SubmitSessionButton         matlab.ui.control.Button
        AMPMDropDown                matlab.ui.control.DropDown
        SongDatabaseButton          matlab.ui.control.Button
        SongPieceDropDownLabel      matlab.ui.control.Label
        SongDropDown                matlab.ui.control.DropDown
        SongPieceDropDown_2Label    matlab.ui.control.Label
        SongDropDown_2              matlab.ui.control.DropDown
        SongPieceDropDown_3Label    matlab.ui.control.Label
        SongDropDown_3              matlab.ui.control.DropDown
        HoursEditFieldLabel         matlab.ui.control.Label
        HoursEditField              matlab.ui.control.NumericEditField
        MinutesEditFieldLabel       matlab.ui.control.Label
        MinutesEditField            matlab.ui.control.NumericEditField
        MinutesEditField_2Label     matlab.ui.control.Label
        MinutesEditField_2          matlab.ui.control.NumericEditField
        HoursEditField_2Label       matlab.ui.control.Label
        HoursEditField_2            matlab.ui.control.NumericEditField
        MinutesEditField_3Label     matlab.ui.control.Label
        MinutesEditField_3          matlab.ui.control.NumericEditField
        HoursEditField_3Label       matlab.ui.control.Label
        HoursEditField_3            matlab.ui.control.NumericEditField
        ClearInputsButton           matlab.ui.control.Button
        RecallSessionButton         matlab.ui.control.Button
        Circleof5thsTab             matlab.ui.container.Tab
        UIAxes                      matlab.ui.control.UIAxes
        GuitarChordsTab             matlab.ui.container.Tab
        KeyDropDownLabel            matlab.ui.control.Label
        KeyDropDown                 matlab.ui.control.DropDown
        ChordDropDownLabel          matlab.ui.control.Label
        ChordDropDown               matlab.ui.control.DropDown
        CAGEDopenchordListBoxLabel  matlab.ui.control.Label
        CAGEDopenchordListBox       matlab.ui.control.ListBox
        CircleOfFifthsAxes          matlab.ui.control.UIAxes
        Panel                       matlab.ui.container.Panel
        ChordShapeAxes              matlab.ui.control.UIAxes
        GuitarNeckAxes              matlab.ui.control.UIAxes
        MetronomeTab                matlab.ui.container.Tab
        SongDatabaseTab             matlab.ui.container.Tab
        AddSongButton               matlab.ui.control.Button
        UITable                     matlab.ui.control.Table
        InstrumentsTab              matlab.ui.container.Tab
        AddInstrumentButton         matlab.ui.control.Button
        UITable2                    matlab.ui.control.Table
    end

    
    properties (Access = private)
        practiceLog % Description
    end
    
    methods (Access = private)
        
        function imgXLoc = imgPlaceMath(app, chord, openShape)
            %DEFINE LENGTH OF A FRET ON IMAGE AS IMG_FRET_LENGTH
            %osNum = openShapeToNum(openShape)
            %cNum = chordToNum(chord)
            %imgXLoc = IMG_FRET_LENGTH * chordShapePlacementArr[osNum][cNum]
        end
        
        function cNum = chordToNum(chord)
            switch(chord)
                case 'A'
                    %cNum = 1
                case 'Bb'
                    %cNum = 2
                case 'B'
                    %cNum = 3
                case 'C'
                    %cNum = 4
                case 'Db'
                    %cNum = 5
                case 'D'
                    %cNum = 6
                case 'Eb'
                    %cNum = 7
                case 'E'
                    %cNum = 8
                case 'F'
                    %cNum = 9
                case 'Gb'
                    %cNum = 10
                case 'G'
                    %cNum = 11
                case 'Ab'
                    %cNum = 12
                otherwise
                    %ERROR
            end
        end
        
        function osNum = openShapeToNum(openShape)
            switch(openShape)
                case 'C'
                    %osNum = 1
                case 'A'
                    %osNum = 2
                case 'G'
                    %osNum = 3
                case 'E'
                    %osNum = 4
                case 'D'
                    %osNum = 5
                otherwise
                    %ERROR
            end
        end
        
        function concatChords(app, value)
            circleOfFifthsArr = [
                "I",	"ii",	"iii",	"IV",	"V",	"vi",	"vii";%header
            		  "A",	"Bm",	"Dbm",	"D",	"E",	"Gbm",	"Ab*";
            		  "Bb",	"Cm",	"Dm",	"Eb",	"F",	"Gm",	"A*";
            		  "B",	"Dbm",	"Ebm",	"E",	"Gb",	"Abm",	"Bb*";
            		  "C",	"Dm",	"Em",	"F",	"G",	"Am",	"B*";
            		  "Db",	"Ebm",	"Fm",	"Gb",	"Ab",	"Bbm",	"C*";
            		  "D",	"Em",	"Gbm",	"G",	"A",	"Bm",	"Db*";
            		  "Eb",	"Fm",	"Gm",	"Ab",	"Bb",	"Cm",	"D*";
            		  "E",	"Gbm",	"Abm",	"A",	"B",	"Dbm",	"Eb*";
            		  "F",	"Gm",	"Am",	"Bb",	"C",	"Dm",	"E*";
            		  "Gb",	"Abm",	"Bbm",	"B",	"Db",	"Ebm",	"F*";
            		  "G",	"Am",	"Bm",	"C",	"D",	"Em",	"Gb*";
            		  "Ab",	"Bbm",	"Cm",	"Db",	"Eb",	"Fm",	"G*"
          	     ];
            
            chords = circleOfFifthsArr(ismember(circleOfFifthsArr(:,1),value),:);
            for ii=numel(chords):-1:1
                newItems(ii) = strcat(circleOfFifthsArr(1,ii), " : ", chords(ii));
            end
            app.ChordDropDown.Items = newItems;
        end
        
        
        
        
        
    end
    
    methods (Static)
        function displayTransparentImg(axes, imgName)
            % DISPLAY A TRANSPARENT IMAGE ON UIAXES OBJECT
            % app: handle to app object
            % axes: UIAxes object
            % imgName: string of image name and, if necessary, path
            
            [imdata, ~, imalpha] = imread(imgName);
            image(imdata, "AlphaData", imalpha, "Parent", axes);
            axes.Visible = "off";
        end
        
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

    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            app.concatChords(app.KeyDropDown.Value);
            app.practiceLog = PracticeTracker(app); % Creates the practiceTracker object
            app.practiceLog.setUserData; % sets user data for the practice tracker elements
            
            %exampleFile = 'unnamed.png';
            %app.displayTransparentImg(app.ChordShapeAxes, exampleFile);
            
%             figure1 = figure;
%             ax1 = axes('Parent',figure1);
%             ax2 = axes('Parent',figure1);
%             set(ax1,'Visible','off');
%             set(ax2,'Visible','off');
%             
%             [a,map,alpha] = imread('BarAShape.png');
%             I = imshow(a,'Parent',ax2);
%             set(I,'AlphaData',alpha);
%             imshow('guitarNeck.png','Parent',ax1);
%             
            app.GuitarNeckAxes.Visible = false;
            app.ChordShapeAxes.Visible = false;
            
            I2 = imshow('guitarNeck.png','Parent',app.GuitarNeckAxes);
            app.GuitarNeckAxes.XLim = [0 I2.XData(2)];
            app.GuitarNeckAxes.YLim = [0 I2.YData(2)];
            
            [a,map,alpha] = imread('BarAShape.png');
            I = imshow(a,'Parent',app.ChordShapeAxes);
            app.ChordShapeAxes.XLim = [0 I.XData(2)];
            app.ChordShapeAxes.YLim = [0 I.YData(2)];
            
            set(I,'AlphaData',alpha);
            
            I = imread('BarAShape.png');
            f1 = imshow(I,'Parent',app.GuitarNeckAxes);
            hold(app.UIAxes, 'on')
            I2 = imread('guitarNeck.png');
            f2 = imshow(I2,'Parent',app.GuitarNeckAxes);
            hold(app.UIAxes, 'off')
            set(f2,'AlphaData', 0.5);
            %
            %             [imdata, ~, imalpha] = imread('BarAShape.png');
            %             image(imdata, "AlphaData", imalpha, "Parent", app.ChordShapeAxes);
            %             UIAxes4.Visible = "off";
            
            % Display image and stretch to fill axes
            I = imshow('circlefifths.jpg', 'Parent', app.UIAxes, ...
                'XData', [1 app.UIAxes.Position(3)], ...
                'YData', [1 app.UIAxes.Position(4)]);
            % Set limits of axes
            app.UIAxes.XLim = [0 I.XData(2)];
            app.UIAxes.YLim = [0 I.YData(2)];
            %
            %             I2 = imshow('guitarNeck.png', 'Parent', app.GuitarNeckAxes, ...
            %                 'XData', [1 app.GuitarNeckAxes.Position(3)], ...
            %                 'YData', [1 app.GuitarNeckAxes.Position(4)]);
            %             % Set limits of axes
            
            %             I3 = imshow('W:\CIS350SemesterProject\ChordShapes\Major\BarAShape.png', 'Parent', app.UIAxes2_2, ...
            %                 'XData', [1 app.UIAxes2_2.Position(3)], ...
            %                 'YData', [1 app.UIAxes2_2.Position(4)]);
            % Set limits of axes
        end

        % Value changed function: KeyDropDown
        function KeyDropDown_ValueChanged(app, event)
            value = app.KeyDropDown.Value;
            switch(value)
                case 'A'
                    %crcl5Path = 'crcl5_A.jpg';
                    %Concat A chords to Chord Drop Down
                case 'Bb'
                    %crcl5Path = 'crcl5_Bb.jpg';
                    %Concat Bb chords to Chord Drop Down
                case 'B'
                    %crcl5Path = 'crcl5_B.jpg';
                    %Concat B chords to Chord Drop Down
                case 'C'
                    %crcl5Path = 'crcl5_C.jpg';
                    %Concat C chords to Chord Drop Down
                case 'Db'
                    %crcl5Path = 'crcl5_Db.jpg';
                    %Concat Db chords to Chord Drop Down
                case 'D'
                    %crcl5Path = 'crcl5_D.jpg';
                    %Concat D chords to Chord Drop Down
                case 'Eb'
                    %crcl5Path = 'crcl5_Eb.jpg';
                    %Concat Eb chords to Chord Drop Down
                case 'E'
                    %crcl5Path = 'crcl5_E.jpg';
                    %Concat E chords to Chord Drop Down
                case 'F'
                    %crcl5Path = 'crcl5_F.jpg';
                    %Concat F chords to Chord Drop Down
                case 'Gb'
                    %crcl5Path = 'crcl5_Gb.jpg';
                    %Concat Gb chords to Chord Drop Down
                case 'G'
                    %crcl5Path = 'crcl5_G.jpg';
                    %Concat G chords to Chord Drop Down
                case 'Ab'
                    %crcl5Path = 'crcl5_Ab.jpg';
                    %Concat Ab chords to Chord Drop Down
                otherwise
                    %crcl5Path = 'crcl5_ERR.jpg';
                    %Don't concat to chord drop down
            end
            app.concatChords(value);
            
        end

        % Value changed function: ChordDropDown
        function ChordDropDown_ValueChanged(app, event)
            value = app.ChordDropDown.Value;
            %Seperate value into numerals and chord
            %Chord will be used in CAGED list box
            switch(value)%this should be based on numeral
                case 'I'
                    %Change chord shape subfolder to major
                case 'ii'
                    %Change chord shape subfolder to minor
                case 'iii'
                    %Change chord shape subfolder to minor
                case 'IV'
                    %Change chord shape subfolder to major
                case 'V'
                    %Change chord shape subfolder to major
                case 'vi'
                    %Change chord shape subfolder to minor
                case 'vii'
                    %Change chord shape subfolder to diminished
                otherwise
                    %ERROR
                    
            end
        end

        % Value changed function: CAGEDopenchordListBox
        function CAGEDListBox_ValueChanged(app, event)
            openShape = app.CAGEDopenchordListBox.Value; %this is the open shape to be displayed
            CDD = app.ChordDropDown.Value;
            %parse out which chord is to be displayed -> chord
            switch(value)
                case 'C'
                    %chordShapeImg = 'C.jpg';
                case 'A'
                    %chordShapeImg = 'A.jpg';
                case 'G'
                    %chordShapeImg = 'G.jpg';
                case 'E'
                    %chordShapeImg = 'E.jpg';
                case 'D'
                    %chordShapeImg = 'D.jpg';
                otherwise
                    %ERROR
            end
            
            %imgXLoc = imgPlaceMath(chord, openShape)
            %update image using imgXLoc, .jpg, and [major/minor/dim] subfolder
            
        end

        % Button pushed function: SubmitSessionButton
        function SubmitSessionButtonPushed(app, event)
            app.practiceLog.submitSession;
        end

        % Value changed function: DateEditField
        function DateEditFieldValueChanged(app, event)
            value = app.DateEditField.Value;
            if app.isValidDate(value)
                return
            else
                uiconfirm(app.timbr,'Invalid Date, please enter date in format mm/dd/yyyy','Invalid Date',...
                    'Icon','warning');
            end
        end

        % Value changed function: TimeEditField
        function TimeEditFieldValueChanged(app, event)
            value = app.TimeEditField.Value;
            if app.isValidTime(value)
                return
            else
                uiconfirm(app.timbr,'Invalid Time, please enter time in format hh:mm','Invalid Time',...
                    'Icon','warning');
            end
        end

        % Button pushed function: ClearInputsButton
        function ClearInputsButtonPushed(app, event)
            app.practiceLog.clearPracticeTracker;
        end

        % Button pushed function: RecallSessionButton
        function RecallSessionButtonPushed(app, event)
            [file,path] = uigetfile('*.xlsx',... % Opens a dialog that lets you select png files
               'Select a file');
            app.practiceLog.getPracticeData([path, file]);
        end
    end

    % App initialization and construction
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create timbr
            app.timbr = uifigure;
            app.timbr.Position = [100 100 776 475];
            app.timbr.Name = 'UI Figure';

            % Create FileMenu
            app.FileMenu = uimenu(app.timbr);
            app.FileMenu.Text = 'File';

            % Create SettingsMenu
            app.SettingsMenu = uimenu(app.timbr);
            app.SettingsMenu.Text = 'Settings';

            % Create OptionsMenu
            app.OptionsMenu = uimenu(app.timbr);
            app.OptionsMenu.Text = 'Options';

            % Create TabGroup
            app.TabGroup = uitabgroup(app.timbr);
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
            app.AMPMDropDown.Position = [317 442 43 22];
            app.AMPMDropDown.Value = 'AM';

            % Create SongDatabaseButton
            app.SongDatabaseButton = uibutton(app.PracticeTrackerTab, 'push');
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

            % Create Circleof5thsTab
            app.Circleof5thsTab = uitab(app.TabGroup);
            app.Circleof5thsTab.Title = 'Circle of 5ths';

            % Create UIAxes
            app.UIAxes = uiaxes(app.Circleof5thsTab);
            app.UIAxes.XTick = [];
            app.UIAxes.XTickLabel = {'[ ]'};
            app.UIAxes.YTick = [];
            app.UIAxes.YTickLabel = {'[ ]'};
            app.UIAxes.Position = [1 15 509 461];

            % Create GuitarChordsTab
            app.GuitarChordsTab = uitab(app.TabGroup);
            app.GuitarChordsTab.Title = 'Guitar Chords';

            % Create KeyDropDownLabel
            app.KeyDropDownLabel = uilabel(app.GuitarChordsTab);
            app.KeyDropDownLabel.HorizontalAlignment = 'right';
            app.KeyDropDownLabel.Position = [15 444 26 22];
            app.KeyDropDownLabel.Text = 'Key';

            % Create KeyDropDown
            app.KeyDropDown = uidropdown(app.GuitarChordsTab);
            app.KeyDropDown.Items = {'A', 'Bb', 'B', 'C', 'Db', 'D', 'Eb', 'E', 'F', 'Gb', 'G', 'Ab'};
            app.KeyDropDown.ValueChangedFcn = createCallbackFcn(app, @KeyDropDown_ValueChanged, true);
            app.KeyDropDown.Position = [56 444 46 22];
            app.KeyDropDown.Value = 'A';

            % Create ChordDropDownLabel
            app.ChordDropDownLabel = uilabel(app.GuitarChordsTab);
            app.ChordDropDownLabel.HorizontalAlignment = 'right';
            app.ChordDropDownLabel.Position = [131 444 38 22];
            app.ChordDropDownLabel.Text = 'Chord';

            % Create ChordDropDown
            app.ChordDropDown = uidropdown(app.GuitarChordsTab);
            app.ChordDropDown.Items = {'I', 'ii', 'iii', 'IV', 'V', 'vi', 'vii'};
            app.ChordDropDown.ValueChangedFcn = createCallbackFcn(app, @ChordDropDown_ValueChanged, true);
            app.ChordDropDown.Position = [184 444 76 22];
            app.ChordDropDown.Value = 'I';

            % Create CAGEDopenchordListBoxLabel
            app.CAGEDopenchordListBoxLabel = uilabel(app.GuitarChordsTab);
            app.CAGEDopenchordListBoxLabel.HorizontalAlignment = 'right';
            app.CAGEDopenchordListBoxLabel.Position = [15 380 55 41];
            app.CAGEDopenchordListBoxLabel.Text = {'CAGED'; 'open  '; 'chord '};

            % Create CAGEDopenchordListBox
            app.CAGEDopenchordListBox = uilistbox(app.GuitarChordsTab);
            app.CAGEDopenchordListBox.Items = {'C', 'A', 'G', 'E', 'D'};
            app.CAGEDopenchordListBox.ValueChangedFcn = createCallbackFcn(app, @CAGEDListBox_ValueChanged, true);
            app.CAGEDopenchordListBox.Position = [78 371 100 52];
            app.CAGEDopenchordListBox.Value = 'C';

            % Create CircleOfFifthsAxes
            app.CircleOfFifthsAxes = uiaxes(app.GuitarChordsTab);
            title(app.CircleOfFifthsAxes, 'Title')
            xlabel(app.CircleOfFifthsAxes, 'X')
            ylabel(app.CircleOfFifthsAxes, 'Y')
            app.CircleOfFifthsAxes.Position = [317 281 300 185];

            % Create Panel
            app.Panel = uipanel(app.GuitarChordsTab);
            app.Panel.Title = 'Panel';
            app.Panel.Position = [-83 7 593 269];

            % Create ChordShapeAxes
            app.ChordShapeAxes = uiaxes(app.Panel);
            app.ChordShapeAxes.XTick = [];
            app.ChordShapeAxes.XTickLabel = {'[ ]'};
            app.ChordShapeAxes.YTick = [];
            app.ChordShapeAxes.Position = [47 23 371 216];

            % Create GuitarNeckAxes
            app.GuitarNeckAxes = uiaxes(app.Panel);
            app.GuitarNeckAxes.XTick = [];
            app.GuitarNeckAxes.XTickLabel = '';
            app.GuitarNeckAxes.YTick = [];
            app.GuitarNeckAxes.YTickLabel = {'[ ]'};
            app.GuitarNeckAxes.Position = [13 55 568 152];

            % Create MetronomeTab
            app.MetronomeTab = uitab(app.TabGroup);
            app.MetronomeTab.Title = 'Metronome';

            % Create SongDatabaseTab
            app.SongDatabaseTab = uitab(app.TabGroup);
            app.SongDatabaseTab.Title = 'Song Database';

            % Create AddSongButton
            app.AddSongButton = uibutton(app.SongDatabaseTab, 'push');
            app.AddSongButton.Position = [11 443 100 22];
            app.AddSongButton.Text = 'Add Song';

            % Create UITable
            app.UITable = uitable(app.SongDatabaseTab);
            app.UITable.ColumnName = {'Title'; 'Artist/Composer'; 'Status'; 'Hours Practiced'; 'Delete'};
            app.UITable.RowName = {};
            app.UITable.Position = [11 10 498 416];

            % Create InstrumentsTab
            app.InstrumentsTab = uitab(app.TabGroup);
            app.InstrumentsTab.Title = 'Instruments';

            % Create AddInstrumentButton
            app.AddInstrumentButton = uibutton(app.InstrumentsTab, 'push');
            app.AddInstrumentButton.Position = [9 446 100 22];
            app.AddInstrumentButton.Text = 'Add Instrument';

            % Create UITable2
            app.UITable2 = uitable(app.InstrumentsTab);
            app.UITable2.ColumnName = {'Instrument'; 'Date'; 'Hours Practiced'; 'Delete'};
            app.UITable2.RowName = {};
            app.UITable2.Position = [9 9 505 423];
        end
    end

    methods (Access = public)

        % Construct app
        function app = AppMockUp

            % Create and configure components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.timbr)

            % Execute the startup function
            runStartupFcn(app, @startupFcn)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.timbr)
        end
    end
end