classdef GenerateReportTest < matlab.uitest.TestCase
    % Practice Tracker Unit Tests
    properties
        App
        songs = [{'Shallow'}, {'Old Devil Moon'}, {'Fur elise'}];
        instrs = [{'Guitar'}, {'Piano'}];
    end
    
    methods (TestMethodSetup)
        function launchApp(testCase)
            cd  'W:\CIS350SemesterProject\ProjectCode';
            testCase.App = GenerateReport(testCase.songs, testCase.instrs);
            testCase.addTeardown(@delete,testCase.App);
        end
    end
    
    methods (Test)
        function testObjCreation(testCase)
            testCase.verifyEqual(class(testCase.App), 'GenerateReport');
        end
        
        function testSongPanelPopulation(testCase)
            % verify song panel has the right songs
            testCase.verifyEqual(numel(testCase.songs),numel(testCase.App.SongsPanel.Children));
            for ii=numel(testCase.songs):-1:1
                kidArr(ii) = {testCase.App.SongsPanel.Children(ii).Text};
            end
            intsct = intersect(kidArr, testCase.songs);
            
            testCase.verifyEqual(numel(intsct), numel(testCase.songs));
            testCase.verifyEqual(numel(intsct), numel(testCase.App.SongsPanel.Children));
        end
        
        function testInstrumentPanelPopulate(testCase)
            % verify instrument panel has the right instruments
            testCase.verifyEqual(numel(testCase.instrs),numel(testCase.App.InstrumentsPanel.Children));
            for ii=numel(testCase.instrs):-1:1
                kidArr(ii) = {testCase.App.InstrumentsPanel.Children(ii).Text};
            end
            intsct = intersect(kidArr, testCase.instrs);
            
            testCase.verifyEqual(numel(intsct), numel(testCase.instrs));
            testCase.verifyEqual(numel(intsct), numel(testCase.App.InstrumentsPanel.Children));
        end
        
        function testCheckAll(testCase)
            testCase.press(testCase.App.CheckAllButton);
            
            % Test Songs panel
            for ii=1:numel(testCase.App.SongsPanel.Children)
                testCase.verifyEqual(testCase.App.SongsPanel.Children(ii).Value, true);
            end
            
            % Test Instruments Panel
            for ii=1:numel(testCase.App.InstrumentsPanel.Children)
                testCase.verifyEqual(testCase.App.InstrumentsPanel.Children(ii).Value, true);
            end
        end
        
        function testClearSession(testCase)
            % set data
            testCase.press(testCase.App.CheckAllButton);
            testCase.press(testCase.App.ClearAllButton);
            
            % Test Songs panel
            for ii=1:numel(testCase.App.SongsPanel.Children)
                testCase.verifyEqual(testCase.App.SongsPanel.Children(ii).Value, false);
            end
            
            % Test Instruments Panel
            for ii=1:numel(testCase.App.InstrumentsPanel.Children)
                testCase.verifyEqual(testCase.App.InstrumentsPanel.Children(ii).Value, false);
            end
        end
        
        function testBrowse(testCase)
            uiconfirm(testCase.App.UIFigure, "Select W:\CIS350SemesterProject", "prompt");
            testCase.press(testCase.App.BrowseButton);
            testCase.verifyEqual(testCase.App.ReportFolderEditField.Value,'W:\CIS350SemesterProject');
        end
        
        function testGenerateReport(testCase)
            close all;  % close any previously generated figures.
            testCase.press(testCase.App.CheckAllButton);
            testCase.press(testCase.App.CreateReportButton);
            figHandle = findobj('Type', 'figure');
            testCase.verifyEqual(figHandle.Name, 'Practice Graph');
        end
        
    end
end