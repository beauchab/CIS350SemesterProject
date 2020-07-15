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
             
        shapeVec = ["C", "A", "G", "E", "D"];
                
    end
    
    methods (TestMethodSetup)
        function launchApp(testCase)
            testCase.App = AppMockUp;
            testCase.addTeardown(@delete,testCase.App);
        end
    end
    
    methods (Test)
               
        function testObjCreation(testCase)
            testCase.verifyEqual(class(testCase.App), 'AppMockUp');
        end
        
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
                testCase.verifyEqual(keyToVer, convertCharsToStrings(testCase.App.co5PNG));  
            end            
        end
        
        %THIS NEEDS WORK DUDE
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
                    testCase.choose(testCase.App.GuitarChords_ChordDD,chordsInKey(i));
                    %Loop through all caged shapes
                    
                    if(i == 1 || i == 4 || i == 5)
                        subFolder = 'Major';
                    elseif(i == 7)
                        subFolder = 'Diminished';
                    else
                        subFolder = 'Minor';
                    end
                    
                    for j = 1:5
                        %Select Caged Shape
                        cagedShape = testCase.shapeVec(j);
                        testCase.choose(testCase.App.GuitarChords_CAGEDLB,cagedShape);
                        shapeToVer = strcat(cagedShape, '.png');
                        
                        %Test Verifications:                        
                        %testCase.verifyEqual(convertCharsToStrings(testCase.App.shapePNG),shapeToVer);
                        testCase.verifyEqual(convertCharsToStrings(testCase.App.fMajMin),convertCharsToStrings(subFolder));
                        %   XLocations
                    end
                end 
            end
        end    
    end
end