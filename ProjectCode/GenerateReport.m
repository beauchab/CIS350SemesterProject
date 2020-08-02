classdef GenerateReport < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                    matlab.ui.Figure
        ReportFolderEditFieldLabel  matlab.ui.control.Label
        ReportFolderEditField       matlab.ui.control.EditField
        BrowseButton                matlab.ui.control.Button
        OverallTimeCheckBox         matlab.ui.control.CheckBox
        SongsPanel                  matlab.ui.container.Panel
        InstrumentsPanel            matlab.ui.container.Panel
        ClearAllButton              matlab.ui.control.Button
        CreateReportButton          matlab.ui.control.Button
        CheckAllButton              matlab.ui.control.Button
    end

    
    properties(Access = public)
        confirmHandle;        
    end
    
    properties (Access = private)
        pos = struct(...
            'left',6,...
            'curbot',1,...
            'width',180,...
            'height',22,...
            'buffer',21);
    end
    
    methods (Access = private)
        
        function addToPanel(app, panel, names)
            if numel(names) > 9
                app.addFromBottom(panel, names)
            else
                app.addFromTop(panel, names);
            end
        end
        
        function addFromBottom(app, panel, names)
            app.pos.curbot = 1;
            for ii=1:numel(names)
                posit = [app.pos.left,app.pos.curbot,app.pos.width,app.pos.height];
                uicheckbox(panel,...
                    'Text', names{ii},...
                    'Position', posit);
                app.pos.curbot = app.pos.curbot + app.pos.buffer;
            end
        end
        
        function addFromTop(app, panel, names)
            app.pos.curbot = 179;
            for ii=1:numel(names)
                posit = [app.pos.left,app.pos.curbot,app.pos.width,app.pos.height];
                uicheckbox(panel,...
                    'Text', names{ii},...
                    'Position', posit);
                app.pos.curbot = app.pos.curbot - app.pos.buffer;
            end
        end
        
        function generateReport(app, folder)
            
            % get checks
            songChecks = app.getChecks(app.SongsPanel);
            
            % get data from files
            songData = app.getSongData(songChecks, folder);
            
            figure('Name','Practice Graph')
            hold on;
            
            % graph songs
            for ii=1:numel(songChecks)
                secs = zeros([numel(songData(ii).hrs),1]);
                practiceTimes = duration([cell2mat(songData(ii).hrs), cell2mat(songData(ii).mins), secs]);
                dates = datetime(strcat(songData(ii).date, " ", songData(ii).time));
                p = plot(sort(dates), practiceTimes,...
                    'Marker', 'o',...
                    "MarkerSize", 12,...
                    'LineWidth', 3);
                p.MarkerEdgeColor = [1 1 1];
                p.MarkerFaceColor = p.Color;
                
            end
            legend(songData.song);
        end
        
        function selectAllChecks(app)
            app.OverallTimeCheckBox.Value = true;
            
            % Clear songs panel
            for ii=1:numel(app.SongsPanel.Children)
                app.SongsPanel.Children(ii).Value = true;
            end
            
            % Clear instruments panel
            for ii=1:numel(app.InstrumentsPanel.Children)
                app.InstrumentsPanel.Children(ii).Value = true;
            end
        end
        
        function clearAllChecks(app)
            app.OverallTimeCheckBox.Value = false;
            
            % Clear songs panel
            for ii=1:numel(app.SongsPanel.Children)
                app.SongsPanel.Children(ii).Value = false;
            end
            
            % Clear instruments panel
            for ii=1:numel(app.InstrumentsPanel.Children)
                app.InstrumentsPanel.Children(ii).Value = false;
            end
        end
    end
    
    methods (Static)
        function checks = getChecks(panel)
            checks = {};
            for ii=1:numel(panel.Children)
                if panel.Children(ii).Value
                    checks = [checks, {panel.Children(ii).Text}];
                end
            end
        end
        
        function dataStruct = getSongData(checks, folder)
            cd (folder);
            files = dir('*.txt');
            
            fileNames = {files.name};
            
            for ii=1:numel(checks)
                % Initialize Data structure to hold data
                dataStruct(ii).song = checks{ii};
                dataStruct(ii).date = {};
                dataStruct(ii).time = {};
                dataStruct(ii).hrs = {};
                dataStruct(ii).mins = {};
                
                % Loop through each file and grab the hrs and minutes for
                % the song at checks{ii}
                for jj=1:numel(fileNames)
                    
                    % Check if .txt file is actually a practice report
                    if(numel(strsplit(fileNames{jj},'_')) == 3)
                        
                        % Find song number
                        val = GenerateReport.getDataFromFile(fileNames{jj},checks{ii});
                        
                        % If the val is found, get the data of the song
                        if ~isempty(val)
                            % Get time and date
                            dataStruct(ii).date = [dataStruct(ii).date; GenerateReport.getDataFromFile(fileNames{jj}, 'Date')];
                            dataStruct(ii).time = [dataStruct(ii).time; GenerateReport.getDataFromFile(fileNames{jj}, 'Time')];
                            
                            songNum = erase(val,'Song');
                            
                            % Build references to hours and minutes
                            hrsRef = strcat('SongHrs',songNum);
                            minsRef = strcat('SongMins',songNum);
                            
                            % Get hours and minutes from file
                            hrs = GenerateReport.getDataFromFile(fileNames{jj},hrsRef);
                            mins = GenerateReport.getDataFromFile(fileNames{jj},minsRef);
                            
                            dataStruct(ii).hrs = [dataStruct(ii).hrs; GenerateReport.sumArr(hrs)];
                            dataStruct(ii).mins = [dataStruct(ii).mins; GenerateReport.sumArr(mins)];
                        end
                    end
                end
            end
        end
        
        function sum = sumArr(arr)
            sum = 0;    % Sum or array elements
            
            % Check if this is a string array
            if isstring(arr)
                arr = str2double(arr);
            end
            
            for ii=1:numel(arr)
                sum = sum + arr(ii);
            end
        end
                
        function val = getDataFromFile(file, name)
            report = DataHandler(file);
            report.openForReading
            data = report.getData;
            val = strtrim(erase(data(contains(data, name)),name));
        end
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app, songs, instruments)
            app.addToPanel(app.SongsPanel, songs);
            app.addToPanel(app.InstrumentsPanel, instruments);
            app.ReportFolderEditField.Value = 'W:\CIS350SemesterProject\ProjectCode';
        end

        % Button pushed function: CreateReportButton
        function CreateReportButtonPushed(app, event)
            folder = app.ReportFolderEditField.Value;
            if(folder)
                app.generateReport(folder);
            else
                app.confirmHandle = uiconfirm(app.UIFigure,...
                    "No folder selected",...
                    "Warning",...
                    'Icon', 'warning');
                
            end
        end

        % Button pushed function: BrowseButton
        function BrowseButtonPushed(app, event)
            folder = uigetdir('*.txt', "Select Folder");
            app.ReportFolderEditField.Value = folder;
        end

        % Button pushed function: ClearAllButton
        function ClearAllButtonPushed(app, event)
            app.clearAllChecks;
        end

        % Button pushed function: CheckAllButton
        function CheckAllButtonPushed(app, event)
            app.selectAllChecks;
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 432 338];
            app.UIFigure.Name = 'MATLAB App';

            % Create ReportFolderEditFieldLabel
            app.ReportFolderEditFieldLabel = uilabel(app.UIFigure);
            app.ReportFolderEditFieldLabel.HorizontalAlignment = 'right';
            app.ReportFolderEditFieldLabel.Position = [13 305 79 22];
            app.ReportFolderEditFieldLabel.Text = 'Report Folder';

            % Create ReportFolderEditField
            app.ReportFolderEditField = uieditfield(app.UIFigure, 'text');
            app.ReportFolderEditField.Position = [107 305 194 22];

            % Create BrowseButton
            app.BrowseButton = uibutton(app.UIFigure, 'push');
            app.BrowseButton.ButtonPushedFcn = createCallbackFcn(app, @BrowseButtonPushed, true);
            app.BrowseButton.Position = [322 305 100 22];
            app.BrowseButton.Text = 'Browse';

            % Create OverallTimeCheckBox
            app.OverallTimeCheckBox = uicheckbox(app.UIFigure);
            app.OverallTimeCheckBox.Text = 'Overall Time';
            app.OverallTimeCheckBox.Position = [13 274 90 22];

            % Create SongsPanel
            app.SongsPanel = uipanel(app.UIFigure);
            app.SongsPanel.Title = 'Songs';
            app.SongsPanel.Scrollable = 'on';
            app.SongsPanel.Position = [13 41 199 221];

            % Create InstrumentsPanel
            app.InstrumentsPanel = uipanel(app.UIFigure);
            app.InstrumentsPanel.Title = 'Instruments';
            app.InstrumentsPanel.Scrollable = 'on';
            app.InstrumentsPanel.Position = [228 41 194 221];

            % Create ClearAllButton
            app.ClearAllButton = uibutton(app.UIFigure, 'push');
            app.ClearAllButton.ButtonPushedFcn = createCallbackFcn(app, @ClearAllButtonPushed, true);
            app.ClearAllButton.Position = [119 11 93 22];
            app.ClearAllButton.Text = 'Clear All';

            % Create CreateReportButton
            app.CreateReportButton = uibutton(app.UIFigure, 'push');
            app.CreateReportButton.ButtonPushedFcn = createCallbackFcn(app, @CreateReportButtonPushed, true);
            app.CreateReportButton.Position = [322 11 100 22];
            app.CreateReportButton.Text = 'Create Report';

            % Create CheckAllButton
            app.CheckAllButton = uibutton(app.UIFigure, 'push');
            app.CheckAllButton.ButtonPushedFcn = createCallbackFcn(app, @CheckAllButtonPushed, true);
            app.CheckAllButton.Position = [13 11 90 22];
            app.CheckAllButton.Text = 'Check All';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = GenerateReport(varargin)

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            % Execute the startup function
            runStartupFcn(app, @(app)startupFcn(app, varargin{:}))

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