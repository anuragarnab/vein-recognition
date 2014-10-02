% dvi2ps
%
% This function converts a dvi file to ps format.
%
% This function requires that you have dvips installed on your system.
% This typically comes with a LaTeX Distrubution.
%
% Copyright (C) Matthias Pospiech 2009-2012

function success = dvi2ps(dviFile, psFile)

dviFile = strrep(dviFile, '.dvi', '');
psFile = strrep(psFile, '.dvi', '');
if (nargin < 2)
    psFile = dviFile;
end

cmdStr =  sprintf('dvips -o %s.ps %s.dvi', psFile, dviFile);
% if (debugOutput)
%     disp(sprintf('\n[dvipng Command] %s',cmdStr));
% end
[status, message] = system(cmdStr);
% Check for error
if status
    % Report error
    if isempty(message)
        warning('MATLAB:dvi2ps', 'Unable to generate ps. Check destination directory is writable.');
    else
        warning('MATLAB:dvi2ps', 'Error %d -- dvips:\n%s',status ,result);
    end
    success = false;
else
    success = true;
end

end
