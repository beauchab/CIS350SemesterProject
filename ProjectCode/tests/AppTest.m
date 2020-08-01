classdef AppTest < matlab.uitest.TestCase
    % Practice Tracker Unit Tests
    properties
        App
        co5Arr = [
            "I",	"ii",	"iii",	"IV",	"V",	"vi",	"vii";
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
        
        shapeMajMinVec = ["C", "A", "G", "E", "D"];
        shapesDiminVec = ["6", "5", "4"];
    end
    
    methods (TestMethodSetup)
        function launchApp(testCase)
            cd  'W:\CIS350SemesterProject\ProjectCode';
            testCase.App = timbr;
            testCase.addTeardown(@delete,testCase.App);
        end
    end
    
    methods (Test)
        function testObjCreation(testCase)
            testCase.verifyEqual(class(testCase.App), 'timbr');
        end
        
        %% App methods test
        function testIsValidDate(testCase)
            % Set invalid date
            testCase.type(testCase.App.DateEditField, 'aaa');
        end
        
        function testIsValidTime(testCase)
            % Set invalid date
            testCase.type(testCase.App.TimeEditField, 'aaa');
        end
        %% Guitar Chord Tests
        %THIS TEST SHOULD WORK
        
        function testGuitarChords1(testCase)
            %testCase.verifyEqual(class(testCase.App), 'AppMockUp');
            for x = 1:12
                %Generate Key and Chords in Key for Test Case
                key = testCase.co5Arr(x+1,1);
                
                chords = testCase.co5Arr(x+1,:);
                for ii=numel(chords):-1:1
                    chordsInKey(ii) = strcat(testCase.co5Arr(1,ii), " : ", chords(ii));
                end
                
                %Select Key
                testCase.choose(testCase.App.GuitarChords_KeyDD,key);
                
                chordsToTest = testCase.App.GuitarChords_ChordDD.Items;
                
                for i = 1:7
                    %Test Verifications -> Chords have been properly
                    %concatenated to chord num
                    testCase.verifyEqual(convertCharsToStrings(chordsToTest{i}), chordsInKey(i));
                end
                %Test Verifications:
                keyToVer = strcat(key, '.png');
                testCase.verifyEqual(keyToVer, convertCharsToStrings(testCase.App.gcRealizer.co5PNG));
            end
        end
        
        function testGuitarChords2(testCase)
            %Loop through all Keys
            for x = 1:12
                %Generate Key and Chords in Key for Test Case
                key = testCase.co5Arr(x+1,1);
                
                chords = testCase.co5Arr(x+1,:);
                for ii=numel(chords):-1:1
                    chordsInKey(ii) = strcat(testCase.co5Arr(1,ii), " : ", chords(ii));
                end
                
                %Select Key
                testCase.choose(testCase.App.GuitarChords_KeyDD,key);
                %Loop through all chords
                for i = 1:7
                    %Select Chord
                    chord = chordsInKey(i);
                    %testCase.choose(testCase.App.GuitarChords_ChordDD,chord);
                    root = chord(1:1);
                    type = 'Bar_';
                    %Loop through all caged shapes
                    
                    if(i == 1 || i == 4 || i == 5)
                        subFolder = 'Major';
                        last = 5;                        
                    elseif(i == 7)
                        subFolder = 'Diminished';
                        last = 3;
                    else
                        subFolder = 'Minor';
                        last = 5;
                    end
                    
                    for j = 1:last
                        %Select Caged Shape
                        %Concat File Name
                        if(strcmp(subFolder, 'Diminished'))                            
                            cagedShape = testCase.shapesDiminVec(j);
                            type = '';                    
                        else
                            cagedShape = testCase.shapeMajMinVec(j);
                            if(strcmp(cagedShape, root))
                                type = 'Open_';                    
                            end
                        end
                        
                        if any(ismember(testCase.App.GuitarChords_CAGEDLB.Items,string(cagedShape)))
                            testCase.choose(testCase.App.GuitarChords_CAGEDLB,string(cagedShape));
                            
                            shapeToVer = strcat(type, cagedShape, '.png');
                            
                            % testCase.press(testCase.App.GuitarChords_DisplayChordBtn);
                            % Commented above line cause press sucks
                            testCase.App.gcRealizer.dispGuitarChord;
                            
                            %Test Verifications:
                            testCase.verifyEqual(convertCharsToStrings(testCase.App.gcRealizer.shapePNG),shapeToVer);
                            testCase.verifyEqual(convertCharsToStrings(testCase.App.gcRealizer.tonality),convertCharsToStrings(subFolder));
                            close all;
                        else
                            testCase.verifyEqual(1,0);
                        end
                        %   XLocations
                    end
                end
            end
        end

    end
end