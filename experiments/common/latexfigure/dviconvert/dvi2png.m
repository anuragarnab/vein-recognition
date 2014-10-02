% dvi2png  
%
% This function converts a dvi file to png format.
%
% This function requires that you have dvipng installed on your system.
% This typically comes with a LaTeX Distrubution
%
% Copyright (C) Matthias Pospiech 2009-2012

function success = dvi2png(dviFile, pngFile, dpi)

if (nargin < 2)
    pngFile = [strrep(dviFile, '.dvi', '') '.png'];
end
if (nargin < 3)
    dpi = 300;
end

% Construct the options string for dvipng
options = ['-q* -D ' num2str(dpi) ' -o ' pngFile ' ' dviFile];

% Convert to png using dvipng
cmdStr = ['dvipng ' options];
% if (debugOutput)
%     disp(sprintf('\n[dvipng Command] %s',cmdStr));
% end
[status, message]=system(cmdStr);
% Check for error
if status
    % Report error
    if isempty(message)
        warning('MATLAB:dvi2png', 'Unable to generate png. Check destination directory is writable.');
    else
        warning('MATLAB:dvi2png', 'Unable to generate png. \n Error Message: %s', message);
    end
    success = false;
else
    success = true;
end

end

