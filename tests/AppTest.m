classdef AppTest < matlab.unittest.TestCase
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
        function catVec = concatenateChordNum(iterator)
            chords = AppTest.co5Arr(iterator+1,:);
            for ii=numel(chords):-1:1
                 catVec(ii) = strcat(circleOfFifthsArr(1,ii), " : ", chords(ii));
            end
        end
        
        function testObjCreation(testCase)
            testCase.verifyEqual(class(testCase.App), 'AppMockUp');
        end
        
        %THIS NEEDS WORK DUDE
        function testGuitarChords1(testCase)
            %testCase.verifyEqual(class(testCase.App), 'AppMockUp');
            for x = 1:12 
                %Generate Key and Chords in Key for Test Case
                key = circleOfFifthsArr(x+1,1);
                chordsInKey = concatenateChordNum(x);
                chordsToTest = app.GuitarChords_KeyDD.Items;
                %Select Key
                testCase.choose(app.GuitarChords_KeyDD,key);
                for i = 1:7
                    %Test Verifications -> Chords have been properly 
                    %concatenated to chord num
                    testCase.verifyEqual(chordsToTest(i), chordsInKey(i));
                end
                %Test Verifications:
                %Can you verify a JPG attached to an axis??????
                %testCase.verifyEqual(chordsToTest(i), chordsInKey(i))     
            end            
        end
        
        %THIS NEEDS WORK DUDE
        function testGuitarChords2(testCase)
            %Loop through all Keys
            for x = 1:12 
                %Generate Key and Chords in Key for Test Case
                key = circleOfFifthsArr(x+1,1);
                chordsInKey = concatenateChordNum(x);
                %Select Key
                testCase.choose(app.GuitarChords_KeyDD,key);                
                %Loop through all chords
                for i = 1:7
                    %Select Chord
                    testCase.choose(app.GuitarChords_ChordDD,chordsInKey(i));
                    %Loop through all caged shapes
                    for j = 1:5
                        %Select Caged Shape
                        cagedShape = AppTest.shapeVec(j);
                        testCase.choose(app.GuitarChords_CAGEDLB,cagedShape);
                        
                        %Test Verifications:
                        %   JPG name?????
                        %   sub folder
                        %   Figure title
                        %   XLocations
                    end
                end
                %Can you verify a JPG attached to an axis??????
                %testCase.verifyEqual(chordsToTest(i), chordsInKey(i))     
            end
        end
        
        
        
    end
end