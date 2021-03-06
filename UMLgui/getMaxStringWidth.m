function maxWidth = getMaxStringWidth(strings,fontName,fontSize)

charWidths = zeros(127,1);

charWidths(32:127,1) = [ ...
0.2526  % 32
0.3144  % 33
0.3144  % 34
0.5634  % 35
0.5634  % 36
0.8742  % 37
0.8118  % 38
0.1902  % 39
0.3768  % 40
0.3768  % 41
0.5634  % 42
0.6252  % 43
0.2526  % 44
0.3768  % 45
0.2526  % 46
0.3144  % 47
0.5634  % 48
0.5634  % 49
0.5634  % 50
0.5634  % 51
0.5634  % 52
0.5634  % 53
0.5634  % 54
0.5634  % 55
0.5634  % 56
0.5634  % 57
0.3144  % 58
0.2526  % 59
0.6252  % 60
0.6252  % 61
0.6252  % 62
0.4392  % 63
0.9360  % 64
0.6876  % 65
0.6876  % 66
0.6876  % 67
0.7494  % 68
0.6252  % 69
0.5634  % 70
0.7494  % 71
0.7494  % 72
0.3144  % 73
0.4392  % 74
0.7494  % 75
0.6252  % 76
0.9360  % 77
0.7494  % 78
0.7494  % 79
0.6252  % 80
0.7494  % 81
0.6876  % 82
0.5634  % 83
0.5634  % 84
0.7494  % 85
0.6876  % 86
0.9984  % 87
0.7494  % 88
0.6876  % 89
0.6252  % 90
0.3144  % 91
0.3144  % 92
0.3144  % 93
0.5010  % 94
0.5634  % 95
0.3768  % 96
0.4392  % 97
0.5010  % 98
0.5010  % 99
0.5010  % 100
0.5010  % 101
0.3768  % 102
0.5010  % 103
0.5010  % 104
0.3144  % 105
0.3144  % 106
0.5010  % 107
0.3144  % 108
0.8118  % 109
0.5010  % 110
0.5634  % 111
0.5010  % 112
0.5010  % 113
0.3768  % 114
0.4392  % 115
0.3144  % 116
0.5010  % 117
0.4392  % 118
0.6876  % 119
0.5010  % 120
0.5010  % 121
0.4392  % 122
0.5010  % 123
0.1902  % 124
0.5010  % 125
0.5634  % 126
0.8118  % 127
];

nStrings = length(strings);

maxWidth0 = 0;

for iString = 1:nStrings
    stringValues = double(strings{iString});
    stringWidth = sum(charWidths(stringValues));
    maxWidth0 = max(maxWidth0,stringWidth);
end

if(strcmp(fontName,'Times-Bold'))
    widthFactor = 1.05;
else
    widthFactor = 1;
end

maxWidth = maxWidth0 * widthFactor * fontSize;

end