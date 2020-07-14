classdef ExcelHandlerTest < matlab.unittest.TestCase
    % Practice Tracker Unit Tests
    properties
        exl
    end
    
    methods (TestMethodSetup)
        function launchApp(testCase)
            testCase.exl = ExcelHandler('test.xlsx');
        end
    end
    
    methods (Test)
        function testObjCreation(testCase)
            testCase.verifyEqual(class(testCase.exl), 'ExcelHandlerTest');
        end
    end
end