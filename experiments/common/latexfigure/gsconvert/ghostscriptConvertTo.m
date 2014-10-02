% ghostscriptConvertTo  
%
% This function converts a pdf file to eps or png
%
% This function requires that you have gs (linux, mac)
% or gswin32c (windows) installed on your system.
%
% Most parts of the code are derived 
% from savefig by Peder Axensten
%
% Copyright (C) Matthias Pospiech 2009-2012

function ghostscriptConvertTo(fileFormat, inputFile, outputFile, dpi, useCurrentDir)

debugOutput = false;

if (nargin < 4)
    dpi = 600;
end

if (nargin < 5)
    useCurrentDir = true;
end

res = num2str(dpi);

% Generate the gs command.
switch(computer)													% Get gs command.
    case {'MAC','MACI'},			gs= '/usr/local/bin/gs';
    case {'PCWIN','PCWIN64'},		gs= 'gswin32c.exe';
    otherwise,						gs= 'gs';
end

gs=		[gs		' -q -dSAFER -dNOPAUSE -dBATCH -dEPSCrop'];					% Essential.
gs=		[gs		' -dUseFlateCompression=true'];						% Useful stuff.
gs=		[gs		' -dAutoRotatePages=/None'];						% Probably good.
gs=		[gs		' -dHaveTrueTypes'];								% Probably good.

switch fileFormat
    case 'png'
        gs=		[gs		' -r' res];                                     % resolution
        gs=		[gs		' -dGraphicsAlphaBits#4 -dTextAlphaBits#4' ];   % further options
        gs=		[gs		' -sDEVICE=png16m'];                            % device
    case 'eps'
        gs=		[gs		' -r6000'];                                     % resolution
        gs=		[gs		' -dLanguageLevel=3' ];                         % further options
        gs=		[gs		' -sDEVICE=epswrite'];                          % device
end

if (useCurrentDir)
    % Get file name.
    [pathstr, namestr, ext] = fileparts(inputFile);
    inputFile= [fullfile(cd, namestr) ext];

    [pathstr, namestr, ext] = fileparts(outputFile);
    outputFile= [fullfile(cd, namestr) ext];
end

% add files
cmd    = [gs		' -sOutputFile="' outputFile '" -f "' inputFile '"'];
status = system(cmd);                                               % Run Ghostscript.
if (debugOutput || status), display (cmd), end

end