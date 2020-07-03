classdef AppMockUp < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                    matlab.ui.Figure
        FileMenu                    matlab.ui.container.Menu
        SettingsMenu                matlab.ui.container.Menu
        OptionsMenu                 matlab.ui.container.Menu
        TabGroup                    matlab.ui.container.TabGroup
        PracticeTrackerTab          matlab.ui.container.Tab
        PracticeNotesTextAreaLabel  matlab.ui.control.Label
        PracticeNotesTextArea       matlab.ui.control.TextArea
        SongsPanel                  matlab.ui.container.Panel
        SongDatabaseButton          matlab.ui.control.Button
        SongPieceDropDownLabel      matlab.ui.control.Label
        SongPieceDropDown           matlab.ui.control.DropDown
        SongPieceDropDown_2Label    matlab.ui.control.Label
        SongPieceDropDown_2         matlab.ui.control.DropDown
        SongPieceDropDown_3Label    matlab.ui.control.Label
        SongPieceDropDown_3         matlab.ui.control.DropDown
        MinutesEditFieldLabel       matlab.ui.control.Label
        MinutesEditField            matlab.ui.control.NumericEditField
        HoursEditFieldLabel         matlab.ui.control.Label
        HoursEditField              matlab.ui.control.NumericEditField
        MinutesEditField_2Label     matlab.ui.control.Label
        MinutesEditField_2          matlab.ui.control.NumericEditField
        HoursEditField_2Label       matlab.ui.control.Label
        HoursEditField_2            matlab.ui.control.NumericEditField
        MinutesEditField_3Label     matlab.ui.control.Label
        MinutesEditField_3          matlab.ui.control.NumericEditField
        HoursEditField_3Label       matlab.ui.control.Label
        HoursEditField_3            matlab.ui.control.NumericEditField
        DateEditFieldLabel          matlab.ui.control.Label
        DateEditField               matlab.ui.control.EditField
        TimeEditFieldLabel          matlab.ui.control.Label
        TimeEditField               matlab.ui.control.EditField
        WhatsyourgoalforthispracticesessionLabel  matlab.ui.control.Label
        TextArea                    matlab.ui.control.TextArea
        InstrumentDropDownLabel     matlab.ui.control.Label
        InstrumentDropDown          matlab.ui.control.DropDown
        Circleof5thsTab             matlab.ui.container.Tab
        UIAxes                      matlab.ui.control.UIAxes
        GuitarChordsTab             matlab.ui.container.Tab
        KeyDropDownLabel            matlab.ui.control.Label
        KeyDropDown                 matlab.ui.control.DropDown
        UIAxes2                     matlab.ui.control.UIAxes
        ChordDropDownLabel          matlab.ui.control.Label
        ChordDropDown               matlab.ui.control.DropDown
        CAGEDopenchordListBoxLabel  matlab.ui.control.Label
        CAGEDopenchordListBox       matlab.ui.control.ListBox
        UIAxes3                     matlab.ui.control.UIAxes
        MetronomeTab                matlab.ui.container.Tab
        SongDatabaseTab             matlab.ui.container.Tab
        AddSongButton               matlab.ui.control.Button
        UITable                     matlab.ui.control.Table
        InstrumentsTab              matlab.ui.container.Tab
        AddInstrumentButton         matlab.ui.control.Button
        UITable2                    matlab.ui.control.Table
    end


    properties (Access = private)
        Property % Description
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
        
    end


    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            
            % Display image and stretch to fill axes
            I = imshow('circlefifths.jpg', 'Parent', app.UIAxes, ...
                'XData', [1 app.UIAxes.Position(3)], ...
                'YData', [1 app.UIAxes.Position(4)]);
            % Set limits of axes
            app.UIAxes.XLim = [0 I.XData(2)];
            app.UIAxes.YLim = [0 I.YData(2)];
            
            I2 = imshow('guitarNeck.png', 'Parent', app.UIAxes2, ...
                'XData', [1 app.UIAxes2.Position(3)], ...
                'YData', [1 app.UIAxes2.Position(4)]);
            % Set limits of axes
            app.UIAxes2.XLim = [0 I2.XData(2)];
            app.UIAxes2.YLim = [0 I2.YData(2)];
            
            I3 = imshow('A.png', 'Parent', app.UIAxes2_2, ...
                'XData', [1 app.UIAxes2_2.Position(3)], ...
                'YData', [1 app.UIAxes2_2.Position(4)]);
            % Set limits of axes
            app.UIAxes2_2.XLim = [0 I3.XData(2)];
            app.UIAxes2_2.YLim = [0 I3.YData(2)];
        end

        % Value changed function: KeyDropDown
        function KeyDropDown_ValueChanged(app, event)
            value = app.InstrumentDropDown_2.Value;
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
    end

    % App initialization and construction
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure
            app.UIFigure = uifigure;
            app.UIFigure.Position = [100 100 640 480];
            app.UIFigure.Name = 'UI Figure';

            % Create FileMenu
            app.FileMenu = uimenu(app.UIFigure);
            app.FileMenu.Text = 'File';

            % Create SettingsMenu
            app.SettingsMenu = uimenu(app.UIFigure);
            app.SettingsMenu.Text = 'Settings';

            % Create OptionsMenu
            app.OptionsMenu = uimenu(app.UIFigure);
            app.OptionsMenu.Text = 'Options';

            % Create TabGroup
            app.TabGroup = uitabgroup(app.UIFigure);
            app.TabGroup.TabLocation = 'left';
            app.TabGroup.Position = [1 1 789 480];

            % Create PracticeTrackerTab
            app.PracticeTrackerTab = uitab(app.TabGroup);
            app.PracticeTrackerTab.Title = 'Practice Tracker';

            % Create PracticeNotesTextAreaLabel
            app.PracticeNotesTextAreaLabel = uilabel(app.PracticeTrackerTab);
            app.PracticeNotesTextAreaLabel.HorizontalAlignment = 'right';
            app.PracticeNotesTextAreaLabel.Position = [8 87 84 22];
            app.PracticeNotesTextAreaLabel.Text = 'Practice Notes';

            % Create PracticeNotesTextArea
            app.PracticeNotesTextArea = uitextarea(app.PracticeTrackerTab);
            app.PracticeNotesTextArea.Position = [107 14 408 97];

            % Create SongsPanel
            app.SongsPanel = uipanel(app.PracticeTrackerTab);
            app.SongsPanel.TitlePosition = 'centertop';
            app.SongsPanel.Title = 'Songs';
            app.SongsPanel.Position = [8 181 507 149];

            % Create SongDatabaseButton
            app.SongDatabaseButton = uibutton(app.SongsPanel, 'push');
            app.SongDatabaseButton.Position = [393 54 100 22];
            app.SongDatabaseButton.Text = 'Song Database';

            % Create SongPieceDropDownLabel
            app.SongPieceDropDownLabel = uilabel(app.SongsPanel);
            app.SongPieceDropDownLabel.HorizontalAlignment = 'right';
            app.SongPieceDropDownLabel.Position = [4 85 67 22];
            app.SongPieceDropDownLabel.Text = 'Song/Piece';

            % Create SongPieceDropDown
            app.SongPieceDropDown = uidropdown(app.SongsPanel);
            app.SongPieceDropDown.Position = [86 85 95 22];

            % Create SongPieceDropDown_2Label
            app.SongPieceDropDown_2Label = uilabel(app.SongsPanel);
            app.SongPieceDropDown_2Label.HorizontalAlignment = 'right';
            app.SongPieceDropDown_2Label.Position = [4 54 67 22];
            app.SongPieceDropDown_2Label.Text = 'Song/Piece';

            % Create SongPieceDropDown_2
            app.SongPieceDropDown_2 = uidropdown(app.SongsPanel);
            app.SongPieceDropDown_2.Position = [86 54 95 22];

            % Create SongPieceDropDown_3Label
            app.SongPieceDropDown_3Label = uilabel(app.SongsPanel);
            app.SongPieceDropDown_3Label.HorizontalAlignment = 'right';
            app.SongPieceDropDown_3Label.Position = [4 21 67 22];
            app.SongPieceDropDown_3Label.Text = 'Song/Piece';

            % Create SongPieceDropDown_3
            app.SongPieceDropDown_3 = uidropdown(app.SongsPanel);
            app.SongPieceDropDown_3.Position = [86 21 95 22];

            % Create MinutesEditFieldLabel
            app.MinutesEditFieldLabel = uilabel(app.SongsPanel);
            app.MinutesEditFieldLabel.HorizontalAlignment = 'right';
            app.MinutesEditFieldLabel.Position = [281 85 48 22];
            app.MinutesEditFieldLabel.Text = 'Minutes';

            % Create MinutesEditField
            app.MinutesEditField = uieditfield(app.SongsPanel, 'numeric');
            app.MinutesEditField.Position = [344 85 30 22];

            % Create HoursEditFieldLabel
            app.HoursEditFieldLabel = uilabel(app.SongsPanel);
            app.HoursEditFieldLabel.HorizontalAlignment = 'right';
            app.HoursEditFieldLabel.Position = [190 85 38 22];
            app.HoursEditFieldLabel.Text = 'Hours';

            % Create HoursEditField
            app.HoursEditField = uieditfield(app.SongsPanel, 'numeric');
            app.HoursEditField.Position = [243 85 30 22];

            % Create MinutesEditField_2Label
            app.MinutesEditField_2Label = uilabel(app.SongsPanel);
            app.MinutesEditField_2Label.HorizontalAlignment = 'right';
            app.MinutesEditField_2Label.Position = [281 54 48 22];
            app.MinutesEditField_2Label.Text = 'Minutes';

            % Create MinutesEditField_2
            app.MinutesEditField_2 = uieditfield(app.SongsPanel, 'numeric');
            app.MinutesEditField_2.Position = [344 54 30 22];

            % Create HoursEditField_2Label
            app.HoursEditField_2Label = uilabel(app.SongsPanel);
            app.HoursEditField_2Label.HorizontalAlignment = 'right';
            app.HoursEditField_2Label.Position = [190 54 38 22];
            app.HoursEditField_2Label.Text = 'Hours';

            % Create HoursEditField_2
            app.HoursEditField_2 = uieditfield(app.SongsPanel, 'numeric');
            app.HoursEditField_2.Position = [243 54 30 22];

            % Create MinutesEditField_3Label
            app.MinutesEditField_3Label = uilabel(app.SongsPanel);
            app.MinutesEditField_3Label.HorizontalAlignment = 'right';
            app.MinutesEditField_3Label.Position = [281 21 48 22];
            app.MinutesEditField_3Label.Text = 'Minutes';

            % Create MinutesEditField_3
            app.MinutesEditField_3 = uieditfield(app.SongsPanel, 'numeric');
            app.MinutesEditField_3.Position = [344 21 30 22];

            % Create HoursEditField_3Label
            app.HoursEditField_3Label = uilabel(app.SongsPanel);
            app.HoursEditField_3Label.HorizontalAlignment = 'right';
            app.HoursEditField_3Label.Position = [190 21 38 22];
            app.HoursEditField_3Label.Text = 'Hours';

            % Create HoursEditField_3
            app.HoursEditField_3 = uieditfield(app.SongsPanel, 'numeric');
            app.HoursEditField_3.Position = [243 21 30 22];

            % Create DateEditFieldLabel
            app.DateEditFieldLabel = uilabel(app.PracticeTrackerTab);
            app.DateEditFieldLabel.HorizontalAlignment = 'right';
            app.DateEditFieldLabel.Position = [12 447 31 22];
            app.DateEditFieldLabel.Text = 'Date';

            % Create DateEditField
            app.DateEditField = uieditfield(app.PracticeTrackerTab, 'text');
            app.DateEditField.Position = [58 447 100 22];

            % Create TimeEditFieldLabel
            app.TimeEditFieldLabel = uilabel(app.PracticeTrackerTab);
            app.TimeEditFieldLabel.HorizontalAlignment = 'right';
            app.TimeEditFieldLabel.Position = [166 447 32 22];
            app.TimeEditFieldLabel.Text = 'Time';

            % Create TimeEditField
            app.TimeEditField = uieditfield(app.PracticeTrackerTab, 'text');
            app.TimeEditField.Position = [213 447 100 22];

            % Create WhatsyourgoalforthispracticesessionLabel
            app.WhatsyourgoalforthispracticesessionLabel = uilabel(app.PracticeTrackerTab);
            app.WhatsyourgoalforthispracticesessionLabel.Position = [12 408 235 22];
            app.WhatsyourgoalforthispracticesessionLabel.Text = 'What''s your goal for this practice session? ';

            % Create TextArea
            app.TextArea = uitextarea(app.PracticeTrackerTab);
            app.TextArea.Position = [12 339 503 60];

            % Create InstrumentDropDownLabel
            app.InstrumentDropDownLabel = uilabel(app.PracticeTrackerTab);
            app.InstrumentDropDownLabel.HorizontalAlignment = 'right';
            app.InstrumentDropDownLabel.Position = [338 447 62 22];
            app.InstrumentDropDownLabel.Text = 'Instrument';

            % Create InstrumentDropDown
            app.InstrumentDropDown = uidropdown(app.PracticeTrackerTab);
            app.InstrumentDropDown.Position = [415 447 100 22];

            % Create Circleof5thsTab
            app.Circleof5thsTab = uitab(app.TabGroup);
            app.Circleof5thsTab.Title = 'Circle of 5ths';

            % Create UIAxes
            app.UIAxes = uiaxes(app.Circleof5thsTab);
            app.UIAxes.XTick = [];
            app.UIAxes.XTickLabel = {'[ ]'};
            app.UIAxes.YTick = [];
            app.UIAxes.YTickLabel = {'[ ]'};
            app.UIAxes.Position = [1 20 509 461];

            % Create GuitarChordsTab
            app.GuitarChordsTab = uitab(app.TabGroup);
            app.GuitarChordsTab.Title = 'Guitar Chords';

            % Create KeyDropDownLabel
            app.KeyDropDownLabel = uilabel(app.GuitarChordsTab);
            app.KeyDropDownLabel.HorizontalAlignment = 'right';
            app.KeyDropDownLabel.Position = [15 449 26 22];
            app.KeyDropDownLabel.Text = 'Key';

            % Create KeyDropDown
            app.KeyDropDown = uidropdown(app.GuitarChordsTab);
            app.KeyDropDown.Items = {'A', 'Bb', 'B', 'C', 'Db', 'D', 'Eb', 'E', 'F', 'Gb', 'G', 'Ab'};
            app.KeyDropDown.ValueChangedFcn = createCallbackFcn(app, @KeyDropDown_ValueChanged, true);
            app.KeyDropDown.Position = [56 449 46 22];
            app.KeyDropDown.Value = 'A';

            % Create UIAxes2
            app.UIAxes2 = uiaxes(app.GuitarChordsTab);
            app.UIAxes2.XTick = [];
            app.UIAxes2.XTickLabel = '';
            app.UIAxes2.YTick = [];
            app.UIAxes2.YTickLabel = {'[ ]'};
            app.UIAxes2.Position = [1 73 644 170];

            % Create ChordDropDownLabel
            app.ChordDropDownLabel = uilabel(app.GuitarChordsTab);
            app.ChordDropDownLabel.HorizontalAlignment = 'right';
            app.ChordDropDownLabel.Position = [111 449 38 22];
            app.ChordDropDownLabel.Text = 'Chord';

            % Create ChordDropDown
            app.ChordDropDown = uidropdown(app.GuitarChordsTab);
            app.ChordDropDown.Items = {'I', 'ii', 'iii', 'IV', 'V', 'vi', 'vii'};
            app.ChordDropDown.ValueChangedFcn = createCallbackFcn(app, @ChordDropDown_ValueChanged, true);
            app.ChordDropDown.Position = [164 449 76 22];
            app.ChordDropDown.Value = 'I';

            % Create CAGEDopenchordListBoxLabel
            app.CAGEDopenchordListBoxLabel = uilabel(app.GuitarChordsTab);
            app.CAGEDopenchordListBoxLabel.HorizontalAlignment = 'right';
            app.CAGEDopenchordListBoxLabel.Position = [15 385 55 41];
            app.CAGEDopenchordListBoxLabel.Text = {'CAGED'; 'open  '; 'chord '};

            % Create CAGEDopenchordListBox
            app.CAGEDopenchordListBox = uilistbox(app.GuitarChordsTab);
            app.CAGEDopenchordListBox.Items = {'C', 'A', 'G', 'E', 'D'};
            app.CAGEDopenchordListBox.ValueChangedFcn = createCallbackFcn(app, @CAGEDListBox_ValueChanged, true);
            app.CAGEDopenchordListBox.Position = [78 338 100 90];
            app.CAGEDopenchordListBox.Value = 'C';

            % Create UIAxes3
            app.UIAxes3 = uiaxes(app.GuitarChordsTab);
            title(app.UIAxes3, 'Title')
            xlabel(app.UIAxes3, 'X')
            ylabel(app.UIAxes3, 'Y')
            app.UIAxes3.Position = [326 300 222 171];

            % Create MetronomeTab
            app.MetronomeTab = uitab(app.TabGroup);
            app.MetronomeTab.Title = 'Metronome';

            % Create SongDatabaseTab
            app.SongDatabaseTab = uitab(app.TabGroup);
            app.SongDatabaseTab.Title = 'Song Database';

            % Create AddSongButton
            app.AddSongButton = uibutton(app.SongDatabaseTab, 'push');
            app.AddSongButton.Position = [11 448 100 22];
            app.AddSongButton.Text = 'Add Song';

            % Create UITable
            app.UITable = uitable(app.SongDatabaseTab);
            app.UITable.ColumnName = {'Title'; 'Artist/Composer'; 'Status'; 'Hours Practiced'; 'Delete'};
            app.UITable.RowName = {};
            app.UITable.Position = [11 15 498 416];

            % Create InstrumentsTab
            app.InstrumentsTab = uitab(app.TabGroup);
            app.InstrumentsTab.Title = 'Instruments';

            % Create AddInstrumentButton
            app.AddInstrumentButton = uibutton(app.InstrumentsTab, 'push');
            app.AddInstrumentButton.Position = [9 451 100 22];
            app.AddInstrumentButton.Text = 'Add Instrument';

            % Create UITable2
            app.UITable2 = uitable(app.InstrumentsTab);
            app.UITable2.ColumnName = {'Instrument'; 'Date'; 'Hours Practiced'; 'Delete'};
            app.UITable2.RowName = {};
            app.UITable2.Position = [9 14 505 423];
        end
    end

    methods (Access = public)

        % Construct app
        function app = AppMockUp

            % Create and configure components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            % Execute the startup function
            runStartupFcn(app, @startupFcn)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end