classdef AppTest < matlab.unittest.TestCase
    % Practice Tracker Unit Tests
    properties
        App
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
    end
end