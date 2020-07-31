% Run code coverage on test suite

% Import unit test classes and codecoverageplugin
import matlab.unittest.TestSuite
import matlab.unittest.TestRunner
import matlab.unittest.plugins.CodeCoveragePlugin

% Create test suite from the tests in 'tests' folder
suite = TestSuite.fromFolder('tests');

% Add a test runner to watch tests while they run
runner = TestRunner.withTextOutput;
runner.addPlugin(CodeCoveragePlugin.forFolder(pwd))

% Run tests and output coverage report
result = runner.run(suite);
