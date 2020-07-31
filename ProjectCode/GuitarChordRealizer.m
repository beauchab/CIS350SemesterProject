%{
Name:GuitarChordRealizer
Description: This is a file which defines the Guitar Chord Realizer object.
@author - Brendan P. Beauchamp
@updated - 7/29/2020
%}
classdef GuitarChordRealizer < handle
    
    properties (Access = public)
        interface     %This is the app
        tonality      %This is the tone of the chord
        shapePNG      %This is the name of the image
        xLoc          %This is the fret at which the image will be displayed
        co5PNG        %This is the handle for the circle of fifths image
        fig           %This is the guitar chord figure
        rootFolder = '\\DC01\profiles$\beauchab\Documents\MATLAB'
        %This is the array which allows for transition between keys
        circleOfFifthsArr = [
            "I",	"ii",	"iii",	"IV",	"V",	"vi",	"vii";%header
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
        %Placement Matrices
        %This is a placement array for major and minor chords
        chordMajMinPlacementArr = [
            %C        %A      %G      %E      %D
            9,        0,	  2,	  5,	  7;%A
            10,        1,	  3,	  6,	  8;%Bb
            11,        2,	  4,	  7,	  9;%B
            0,        3,	  5,	  8,	 10;%C
            1,        4,	  6,	  9,	 11;%Db
            2,        5,	  7,	 10,	  0;%D
            3,        6,	  8,	 11,	  1;%Eb
            4,        7,	  9,	  0,	  2;%E
            5,        8,	 10,	  1,	  3;%F
            6,        9,	 11,	  2,	  4;%Gb
            7,       10,	  0,	  3,	  5;%G
            8,       11,	  1,	  4,	  6;%Ab
            ];
        %This is a placement array for diminished chords
        chordDiminPlacementArr = [
            %6        %5      %4
            6,        0,	  8;   %A
            7,        1,	  9;   %Bb
            8,        2,	 10;   %B
            9,        3,	 11;   %C
            10,       4,	 12;   %Db
            11,       5,	  0;   %D
            12,       6,	  1;   %Eb
            0,        7,	  2;   %E
            1,        8,	  3;   %Fb
            2,        9,	  4;   %F
            3,       10,	  5;   %Gb
            4,       11,	  6;   %G
            5,       12,	  7;   %Ab
            ];
    end
    
    methods
        %{
        Name: GuitarChordRealizer
        Description: This is the constructor for the GuitarChordRealizer
                     object.
        @author - Brendan P. Beauchamp
        @updated - 7/29/2020
        @param - interface
                    This is the app
        @return - obj
                    This is the GuitarChordRealizer object
        %}
        function obj = GuitarChordRealizer(interface)
            obj.interface = interface;
            obj.tonality = 'Major';
            obj.shapePNG = 'Bar_C.png';
            obj.xLoc = 9;
            obj.co5PNG = 'A.png';
        end
        %{
        Name: updateCO5PNG
        Description: This function updates the circle of fifths for the
                     guitar chords tab.
        @author - Brendan P. Beauchamp
        @updated - 7/29/2020
        @param - obj
                    This is the GuitarChordRealizer object
        @param - key
                    This is the key which is to be updated
        @return - void
        %}
        function updateCO5PNG(obj, key)
            
            switch(key)
                case 'A'
                    cofPng = 'A.png';
                    %Concat A chords to Chord Drop Down
                case 'Bb'
                    cofPng = 'Bb.png';
                    %Concat Bb chords to Chord Drop Down
                case 'B'
                    cofPng = 'B.png';
                    %Concat B chords to Chord Drop Down
                case 'C'
                    cofPng = 'C.png';
                    %Concat C chords to Chord Drop Down
                case 'Db'
                    cofPng = 'Db.png';
                    %Concat Db chords to Chord Drop Down
                case 'D'
                    cofPng = 'D.png';
                    %Concat D chords to Chord Drop Down
                case 'Eb'
                    cofPng = 'Eb.png';
                    %Concat Eb chords to Chord Drop Down
                case 'E'
                    cofPng = 'E.png';
                    %Concat E chords to Chord Drop Down
                case 'F'
                    cofPng = 'F.png';
                    %Concat F chords to Chord Drop Down
                case 'Gb'
                    cofPng = 'Gb.png';
                    %Concat Gb chords to Chord Drop Down
                case 'G'
                    cofPng = 'G.png';
                    %Concat G chords to Chord Drop Down
                case 'Ab'
                    cofPng = 'Ab.png';
                    %Concat Ab chords to Chord Drop Down
                otherwise
                    %ERROR
                    cofPng = 'ERR.png';
                    %Don't concat to chord drop down
            end
            
            %Update object property
            obj.co5PNG = cofPng;
            
            %Update the Circle of 5ths that is displayed on Guitar Chords Tab
            file = dir(fullfile(obj.rootFolder , ['**\CircleOf5ths\' cofPng]));
            co5FP = fullfile(file.folder, file.name);
            
            I3 = imshow(co5FP, 'Parent', obj.interface.GuitarChords_CO5Axes, ...
                'XData', [1 obj.interface.GuitarChords_CO5Axes.Position(3)], ...
                'YData', [1 obj.interface.GuitarChords_CO5Axes.Position(4)]);
            % Set limits of axes
            obj.interface.GuitarChords_CO5Axes.XLim = [0 I3.XData(2)];
            obj.interface.GuitarChords_CO5Axes.YLim = [0 I3.YData(2)];
        end
        %{
        Name: concatCaged
        Description: This function determines which shapes to display
                     to the user
        @author - Brendan P. Beauchamp
        @updated - 7/29/2020
        @param - obj
                    This is the GuitarChordRealizer object
        %}
        function concatCaged(obj, value)
            shapesCAGED = ["C",	"A",	"G",	"E",	"D"];
            shapesDimin = ["6", "5", "4"];
            %If chord is 7th, update the LB to diminished shapes
            if (contains(value, "vii"))
                newItems = shapesDimin;
                %Otherwise use CAGED shapes
            else
                newItems = shapesCAGED;
            end
            obj.interface.GuitarChords_CAGEDLB.Items = newItems;
        end
        %{
        Name: concatChords
        Description: This function concatenates available chords within
                     the selected key
        @author - Brendan P. Beauchamp
        @updated - 7/29/2020
        @param - obj
                    This is the GuitarChordRealizer object
        @param - value
                    This is the key which the user has selected
        %}
        function concatChords(obj, value)
            chords = obj.circleOfFifthsArr(ismember(obj.circleOfFifthsArr(:,1),value),:);
            for ii=numel(chords):-1:1
                newItems(ii) = strcat(obj.circleOfFifthsArr(1,ii), " : ", chords(ii));
            end
            %Update Chord Drop Down Items
            obj.interface.GuitarChords_ChordDD.Items = newItems;
        end
        %{
        Name: dispGuitarChord
        Description: This function displays a guitar chord to the user
                     based on the selected key, degree, and chord shape
        @author - Brendan P. Beauchamp
        @updated - 7/29/2020
        @param - obj
                    This is the GuitarChordRealizer object
        %}
        function dispGuitarChord(obj)
            %Function Variables
            cTyp = 'Bar';
            txt = " Open";
            
            %Retrieve CAGED List Box Value
            chordShape = obj.interface.GuitarChords_CAGEDLB.Value;
            
            %Parse for chord and cofnum
            CDD = obj.interface.GuitarChords_ChordDD.Value;
            %PARSE NUMERAL FROM CDD            -> Tonality
            cofNum = extractBefore(CDD, ' : ');
            %PARSE NOTE FROM CDD               -> Chord Letter
            note = extractAfter(CDD,' : ');
            
            %Determine Tonality
            tone = obj.cofNumToTonality(cofNum);
            
            %Determine the fret location
            imgXLoc = obj.imgPlaceMath(note, chordShape, tone);
            
            if(strcmp(tone, 'Dimin')) %CHORD DISPLAYED IS DIMINSHED
                
                %Image name is just where the root is
                chordPng = strcat(chordShape,'.png');
                
            else                      %CHORD DISPLAYED IS MAJOR OR MINOR
                
                if(strcmp(tone, 'Minor')) %CHORD DISPLAYED IS MINOR
                    note = extractBefore(note, 'm');
                end
                
                %Image name is either bar or open depending on neck loc
                if (chordShape == note)
                    %Chord to be displayed is at the bottom of the neck
                    cTyp = 'Open';
                end
                chordPng = strcat(cTyp,'_',chordShape,'.png');
            end
            
            %Add values to app properties
            obj.tonality = tone;
            obj.shapePNG = chordPng;
            obj.xLoc = imgXLoc;
            
            %Compile File Path
            file = dir(fullfile(obj.rootFolder , ['**\' obj.tonality '\' obj.shapePNG]));
            crdFP = fullfile(file.folder, file.name);
            
            %Create a figure to display a guitar chord
            f = figure();
            %Modify title based on bar chord
            if(strcmp(cTyp, 'Bar'))
                txt = strcat(" Bar at fret ", num2str(obj.xLoc));
            end
            
            %Concatenate Figure Name
            figName = strcat(note, " ", obj.tonality, txt);
            set(f,'name', figName);
            
            %Display the guitar neck and resize image
            file = dir(fullfile(obj.rootFolder , '**\guitarNeck2.png'));
            neck = imread(fullfile(file.folder, file.name));
            
            %neck = imresize(neck, 0.90);
            [y,x,~] = size(neck);
            
            % generate axes
            ax = axes('Units','pixels', 'Position',[0 0 x y], 'XTick',[], 'YTick',[], ...
                'Nextplot','add', 'YDir','reverse');
            % Display the image in the axes
            image(neck, 'parent', ax);
            
            %Determine the alpha data for the guitar chord
            [im, ~, alpha] = imread(crdFP);
            %Determine the size of the guitar chord
            [~,x1,~] = size(neck);
            
            %Place the image on the axis and set its position
            I4 = imshow(im, 'Parent', ax);
            set(I4, 'AlphaData', alpha, 'XData', [-10 -10+x1]);
            set(f,'Position',[100 100 x y]);
            
            obj.fig = f;
        end
        %{
        Name: imgPlaceMath
        Description: This function uses the chord, tone, and
                     open shape which is chosen to determine where to
                     place the chord on the fret board
        @author - Brendan P. Beauchamp
        @updated - 7/29/2020
        @param - obj
                    This is the GuitarChordRealizer object
        @param - chord
                    This is the chord which the user would like to play
        @param - openShape
                    This is the shape in which the user would like to play
                    the selected chord
        @param - tone
                    This is the tonality of the selected chord
        @return - imgXLoc
                    This is the x location on the fret board in order to
                    play the selected chord with the selected open shape
                    and tone.
        %}
        function imgXLoc = imgPlaceMath(obj, chord, openShape, tone)
            %DEFINE LENGTH OF A FRET ON IMAGE AS IMG_FRET_LENGTH
            IMG_FRET_LENGTH = 1;
            osNum = obj.openShapeToNum(openShape, tone);
            cNum = obj.chordToNum(chord, tone);
            if(strcmp(tone, 'Dimin'))
                imgXLoc = IMG_FRET_LENGTH * obj.chordDiminPlacementArr(cNum, osNum);
            else
                imgXLoc = IMG_FRET_LENGTH * obj.chordMajMinPlacementArr(cNum, osNum);
            end
        end
    end
    
    methods (Static)
        %{
        Name: chordToNum
        Description: This funciton is used to determine which column of the
                     placement matrix is to be utilized
        @author - Brendan P. Beauchamp
        @updated - 7/29/2020
        @param - chord
                    This is the chord to be displayed
        @param - tone
                    This is the tonality of the selected code
        @return - cNum
                    This is the column of the placement matrix
        %}
        function cNum = chordToNum(chord, tone)
            if(strcmp(tone, 'Dimin'))
                chord = extractBefore(chord, '*');
            elseif(strcmp(tone, 'Minor'))
                chord = extractBefore(chord, 'm');
            end
            switch(chord)
                case 'A'
                    cNum = 1;
                case 'Bb'
                    cNum = 2;
                case 'B'
                    cNum = 3;
                case 'C'
                    cNum = 4;
                case 'Db'
                    cNum = 5;
                case 'D'
                    cNum = 6;
                case 'Eb'
                    cNum = 7;
                case 'E'
                    cNum = 8;
                case 'F'
                    cNum = 9;
                case 'Gb'
                    cNum = 10;
                case 'G'
                    cNum = 11;
                case 'Ab'
                    cNum = 12;
                otherwise
                    warning("Problem with fcn chordToNum");
            end
        end
        %{
        Name: openShapeToNum
        Description: This function is used to determine which row of the
                     placement matrix is to be used
        @author - Brendan P. Beauchamp
        @updated - 7/29/2020
        @param - openShape
                    This is the chord shape which the user would like to
                    play.
        @param - tone
                    This is the tonality of the chord selected to play
        @return - osNum
                    This is the row of the placement matrix
        %}
        function osNum = openShapeToNum(openShape,tone)
            if(strcmp(tone, 'Dimin'))
                switch(openShape)
                    case '6'
                        osNum = 1;
                    case '5'
                        osNum = 2;
                    case '4'
                        osNum = 3;
                    otherwise
                        warning("Problem with fcn openShapeToNum");
                end
            else
                switch(openShape)
                    case 'C'
                        osNum = 1;
                    case 'A'
                        osNum = 2;
                    case 'G'
                        osNum = 3;
                    case 'E'
                        osNum = 4;
                    case 'D'
                        osNum = 5;
                    otherwise
                        warning("Problem with fcn openShapeToNum");
                end
            end
        end
        %{
        Name: cofNumToTonality
        Description: This function is used to translate between the degree
                     of the tonic to its respective tonality
        @author - Brendan P. Beauchamp
        @updated - 7/29/2020
        @param - cofNum
                    This is the degree of the tonic
        @return - tonality
                    This is the tonality of the chord
        %}
        function tonality = cofNumToTonality(cofNum)
            %Determine tonality based on the circle of fifths number
            switch(cofNum)
                case 'I'
                    tonality = 'Major';
                case 'ii'
                    tonality = 'Minor';
                case 'iii'
                    tonality = 'Minor';
                case 'IV'
                    tonality = 'Major';
                case 'V'
                    tonality = 'Major';
                case 'vi'
                    tonality = 'Minor';
                case 'vii'
                    tonality = 'Dimin';
                otherwise
                    tonality = 'ERROR';
                    
            end
        end
    end
end