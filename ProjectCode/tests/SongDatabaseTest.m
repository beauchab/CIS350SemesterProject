classdef SongDatabaseTest < matlab.uitest.TestCase
    % Song Database Unit Tests
    properties
        App
        database
    end
    
    methods (TestMethodSetup)
        function launchApp(testCase)
            cd  'W:\CIS350SemesterProject\ProjectCode';
            testCase.App = timbr;
            testCase.database = Songs_Database(testCase.App);
            testCase.addTeardown(@delete,testCase.App);
        end
    end
    
    methods (Test)
        function testObjCreation(testCase)
            testCase.verifyEqual(class(testCase.database), 'Songs_Database');
        end
        
        %Unit Testing for Song Database
        function TestAddSong(testCase)
            delete(testCase.database.databaseFile);
            testCase.database.addSongToDatabase('Shallow', 'Lady Gaga', 'LadyGagaMusic.com');
            testCase.verifyEqual(strtrim(testCase.App.UITable.Data{1,1}),'Shallow');
            testCase.verifyEqual(strtrim(testCase.App.UITable.Data{1,2}),'Lady Gaga');
            testCase.verifyEqual(strtrim(testCase.App.UITable.Data{1,3}),'LadyGagaMusic.com'); 
           
            testCase.database.addSongToDatabase('We Will Rock You', 'Queen', 'QueenMusic.com');
            testCase.verifyEqual(strtrim(testCase.App.UITable.Data{1,1}),'Shallow');
            testCase.verifyEqual(strtrim(testCase.App.UITable.Data{1,2}),'Lady Gaga');
            testCase.verifyEqual(strtrim(testCase.App.UITable.Data{1,3}),'LadyGagaMusic.com'); 
            testCase.verifyEqual(strtrim(testCase.App.UITable.Data{2,1}),'We Will Rock You');
            testCase.verifyEqual(strtrim(testCase.App.UITable.Data{2,2}),'Queen');
            testCase.verifyEqual(strtrim(testCase.App.UITable.Data{2,3}),'QueenMusic.com');
            
            testCase.database.addSongToDatabase('Baby', 'Justin Bieber', 'JustinBieberMusic.com');
            testCase.verifyEqual(strtrim(testCase.App.UITable.Data{1,1}),'Baby');
            testCase.verifyEqual(strtrim(testCase.App.UITable.Data{1,2}),'Justin Bieber');
            testCase.verifyEqual(strtrim(testCase.App.UITable.Data{1,3}),'JustinBieberMusic.com');  
            testCase.verifyEqual(strtrim(testCase.App.UITable.Data{2,1}),'Shallow');
            testCase.verifyEqual(strtrim(testCase.App.UITable.Data{2,2}),'Lady Gaga');
            testCase.verifyEqual(strtrim(testCase.App.UITable.Data{2,3}),'LadyGagaMusic.com'); 
            testCase.verifyEqual(strtrim(testCase.App.UITable.Data{3,1}),'We Will Rock You');
            testCase.verifyEqual(strtrim(testCase.App.UITable.Data{3,2}),'Queen');
            testCase.verifyEqual(strtrim(testCase.App.UITable.Data{3,3}),'QueenMusic.com');
        end
        
        function TestDeleteSong(testCase)
            testCase.database.deleteSongInDatabase('Shallow');
            testCase.verifyEqual(strtrim(testCase.App.UITable.Data{1,1}),'Baby');
            testCase.verifyEqual(strtrim(testCase.App.UITable.Data{1,2}),'Justin Bieber');
            testCase.verifyEqual(strtrim(testCase.App.UITable.Data{1,3}),'JustinBieberMusic.com'); 
            testCase.verifyEqual(strtrim(testCase.App.UITable.Data{2,1}),'We Will Rock You');
            testCase.verifyEqual(strtrim(testCase.App.UITable.Data{2,2}),'Queen');
            testCase.verifyEqual(strtrim(testCase.App.UITable.Data{2,3}),'QueenMusic.com');            
        end

        function TestSearchSong(testCase)
            delete(testCase.database.databaseFile);
            testCase.database.addSongToDatabase('Shallow', 'Lady Gaga', 'LadyGagaMusic.com');
            testCase.verifyEqual(strtrim(testCase.App.UITable.Data{1,1}),'Shallow');
            testCase.verifyEqual(strtrim(testCase.App.UITable.Data{1,2}),'Lady Gaga');
            testCase.verifyEqual(strtrim(testCase.App.UITable.Data{1,3}),'LadyGagaMusic.com'); 
            
            close all;  % close any previously generated figures.
             % Button pushed function: SearchButton
            prompt = {'Enter song name'};
            dlgtitle = 'Search for a Song';
            dims = [1 35];
            definput = {'Shallow'};
            answer = inputdlg(prompt,dlgtitle,dims,definput);
            if(~ isempty(answer))
                testCase.App.songDatabase.searchDatabase(answer{1});
            end
            testCase.verifyEqual(testCase.App.songDatabase.resultfound, 1);
        end
    end
end