function makeAppDiagram
% makeAppDiagram creates a UML class diagram for the app
%
% See also:
%   UMLgui ClassFile Tree ClassGroup
%
% Ben Goddard 20/03/20
% Thanks to Todd F Velde (TFV) for help with packages


    oldPath = path;

    % change this directory list to create custom scripts
	dirList = recursiveDirList('W:\CIS350SemesterProject\ProjectCode');

    nDir = length(dirList);

    fileList = {};
    classNames = {};
    nFiles = 0;
    completeTree = true;
    md=[];
    nonParentClass = [];

    % read in files from directories
    for iDir = 1:nDir
       
        m = strsplit(dirList{iDir},'+');

        isPackage = ( length(m)>1 );

        if(~isPackage)
            addpath(dirList{iDir}); 
        end

        listingM = dir([dirList{iDir} filesep '*.m']);
        nFilesM = length(listingM);

        listingAT = dir([dirList{iDir} filesep '@*']);
        nFilesAT = length(listingAT);
       
        for iFile = 1:nFilesM
            classNameM = listingM(iFile).name(1:end-2);
            if isPackage
                classNameM = strjoin([m(2:end),{classNameM}],'.');
            end
            classNames = [classNames,classNameM];  %#ok
        end

        for iFile = 1:nFilesAT
            classNameAT = listingAT(iFile).name(2:end);
            if isPackage
                classNameAT = strjoin([m(2:end),{classNameAT}],'.');
            end
            classNames = [classNames,classNameAT];  %#ok
        end

        nFiles = nFiles + nFilesM + nFilesAT;
    end

    % establish which are valid classes
    for iFile = 1:nFiles
        className = classNames{iFile};
        metaDataCmd = ['md  = ?' className ';'];

        try
            eval(metaDataCmd);

        catch err

            if(strcmp(err.identifier, 'MATLAB:class:InvalidSuperClass'))
                completeTree = false;
                nonParentClass = className;
            else
                fprintf(1,'Unknown error:\n');
                fprintf(1,[err.message '\n']);
            end
        end

        if(~isempty(md) && completeTree)                    
            fileList = [fileList className];      %#ok
        end
    end

    % put into alphabetical order
    [~,sortOrder] = sort(lower(fileList));
    fileList = fileList(sortOrder);

    if(~completeTree)
        fileList = {};
    end

    if(isempty(fileList))

        if(completeTree)
            fprintf(1,'Selected directories contain no class files!\n');
        else
            fprintf(1,['Incomplete tree: ' nonParentClass ' missing superclasses\n']);
        end

    else

        % determine if we use fancy (true) or compact (false) plotting
        options.fancy=true;
        
        % make and open the pdf
        tree = Tree(fileList,options);
        saveFile = tree.saveFile;

        % open(saveFile);

    end

    path(oldPath);

end