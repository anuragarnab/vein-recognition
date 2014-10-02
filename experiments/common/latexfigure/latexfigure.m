% latexfigure creates a pdf, eps or png figure using LaTeX and replacement
%   of default fonts with LaTeX fonts using psfrag tool
%   This function uses the matlabfrag function and makes simply a
%   concatenation of the text part and the graphical part in a single 
%   file. It requires:
%
%                  MATLAB                         |      OTHER
%              -----------------------------------|----------------------------
%              matlabfrag.m (modified, bugfixed)  |     pdflatex
%              strsplit.m (bugfix of strsplit)    |     gs (ghostscript)
%              fix_lines (from export_fig)        |
%
% currently matlabfrag.m is shipped in a modified and bugfixed version,
% until a new version is released.
% 
% this code was inspired by mlf2pdf.m
% it reuses code and files from export_fig, savefig (not used), strsplit
%
% Basic example:
%    % handle, filename, format
%    latexfigure(hfig,'latexfigure','png'); 
%
% options:
%  - 'packages': latex code
%  - 'fixLines': boolean, if or not the dashes shall be fixed
%  - 'dpi'     : resolution (600 dpi default)
%  - 'debug'   : boolean, 
%  - 'mathmode': boolean, enables math mode for all texts
%  - 'distpath': string for the latex distribution binary path
% 
% Copyright (C) Matthias Pospiech 2009-2012


function latexfigure(h,FileName,outputFormat,varargin)

currmfile = mfilename('fullpath');
currPath = currmfile(1:end-length(mfilename()));

addpath([currPath 'exportfig']);
addpath([currPath 'gsconvert']);
addpath([currPath 'matlabfrag']);
addpath([currPath 'strsplit']);

%% parse input parameters
p = inputParser;
p.FunctionName = 'latexfigure';

% p.addRequired('FileName', @(x) ischar(x) );
% p.addRequired('outputFormat', @(x) any( strcmpi(x,{'eps','png','pdf'}) ) );
p.addOptional('packages', '', @(x) ischar(x) );
p.addOptional('fixLines', true, @(x) islogical(x) );
p.addParamValue('dpi', 600, @(x) isnumeric(x) );
p.addOptional('debug', false, @(x) islogical(x) );
p.addOptional('mathmode', false, @(x) islogical(x) );
p.addOptional('distpath', 'C:/Program Files (x86)/MiKTeX 2.9/miktex/bin/', @(x) ischar(x) );

p.parse(FileName,varargin{:});

% apply resulting parameters
strDistPath = p.Results.distpath;
useMathForText = p.Results.mathmode;
usefixLines = p.Results.fixLines;
strPackages = p.Results.packages;
debugOutput = p.Results.debug;
dpi = p.Results.dpi;

if (~any( strcmpi(outputFormat,{'pdf','eps','png'})))
    error(['latexfigure: can not handle graphics format: ' outputFormat]);
end

if (~debugOutput)
    FragFigureName = strcat('TEMP',num2str(round(rand*10000))); %Generate random file name
else
    FragFigureName = 'DEBUG';
end

if ~exist('matlabfrag.m', 'file')
    disp('MatLabFrag M-file does not exist or is not in the MATLAB''s search path.');
    disp('This file can be downloaded at: http://www.mathworks.com/matlabcentral/fileexchange');
    disp('                                                         Try again...');
    return;
end

%-------------------------------------------------------
% call matlabfrag to export figure to .eps and .tex file.
%
% create two files 
% - 'FragFigureName.eps' <- image
% - 'FragFigureName.tex' <- frag text
%-------------------------------------------------------
matlabfrag(FragFigureName,'handle',h, 'mathmode', useMathForText);
if (usefixLines)
    fix_lines([FragFigureName '.eps']);
end

%-------------------------------------------------------
% Temporary LaTeX file (including the figure)
%-------------------------------------------------------
% creates 'FragFigureName-main.tex'
createLaTeXFile();

%-------------------------------------------------------
% run LaTeX with document file including the figure
%-------------------------------------------------------
success = runLaTeX();
if (~success), return, end

% we now have these file
% - FragFigureName-main.tex
% - FragFigureName.tex
% - FragFigureName.eps
% - .. many FragFigureName-main.* files

%-------------------------------------------------------
% convert to destiny format
% (only for eps or png, not for pdf)
%-------------------------------------------------------
% convert to eps 
if (any( strcmpi(outputFormat,{'eps'})))
    ghostscriptConvertTo('eps', [FragFigureName '.pdf'], [FragFigureName '.eps'], dpi);
end
% convert from pdf to png
if (any( strcmpi(outputFormat,{'png'})))
    ghostscriptConvertTo(outputFormat, [FragFigureName '.pdf'], [FragFigureName '.png'], dpi);
end

%-------------------------------------------------------
% Rename FragFigureName to FileName and delete FileName 
% before (if it exists)
%-------------------------------------------------------
% delete any previous output file
if (exist([FileName '.' outputFormat], 'file'))
    delete([FileName '.' outputFormat]);
end

% rename Temporary file (FragFigureName) to target FileName
if isunix==0
    inputFile = [FragFigureName '.' outputFormat];
    [pathstr, namestr, ext] = fileparts(inputFile);
    inputFile = [fullfile(cd, namestr) ext];

    cmd = ['move "' inputFile '" "' FileName '.' outputFormat '"'];
    if (debugOutput), display(cmd), end
    dos(cmd);
else 
   cmd = ['mv ' FragFigureName '.' outputFormat ' ' FileName '.' outputFormat];
   if (debugOutput), display(cmd), end
   unix(cmd);
end

%-------------------------------------------------------
% Delete all the temporary files
%-------------------------------------------------------
if (~debugOutput)
    delete([FragFigureName '*']);
end
%-------------------------------------------------------
% functions...
%-------------------------------------------------------

    function createLaTeXFile()
        fid = fopen(strcat(FragFigureName,'-main.tex'),'w');

        fprintf(fid,'\\documentclass[11pt, oneside]{article}\n');
        fprintf(fid,'\\usepackage{graphicx}\n');
        fprintf(fid,'\\usepackage{amsmath}\n');
        fprintf(fid,'\\usepackage[T1]{fontenc}\n');
        fprintf(fid,'\\usepackage[latin1]{inputenc}\n');
        fprintf(fid,'\\usepackage{xcolor}\n');
        fprintf(fid,'\\usepackage{textcomp}\n');        

        if (any( strcmpi(outputFormat,{'pdf','eps','png'})))
            fprintf(fid,'\\usepackage[]{pstool}\n'); % crop=pdfcrop
        end

        split=strsplit(strPackages,'\n');
        for i=1:size(split,2)
            fprintf(fid,'%s\n',split{i}); % Suplementary LaTeX Code
        end

        fprintf(fid,'\\pagestyle{empty}\n');
        fprintf(fid,' \n');
        fprintf(fid,'\\begin{document}\n');
        fprintf(fid,'   \\centering\n');
        fprintf(fid,'   \\psfragfig{%s}\n',FragFigureName);
        fprintf(fid,' \n');
        fprintf(fid,'\\end{document}\n');
        fclose(fid);
    end


    function success = runLaTeX()
        Str=sprintf([latexInterpreter() ' -interaction=nonstopmode -shell-escape %s-main.tex'], FragFigureName);
       
        if (debugOutput)
            disp(sprintf('\n[LaTeX Command] %s',Str));
        end
        
        [status, result]=system(Str);

        if (status == 0)
            success = true;
        else
            success = false;
        end
        if (success == false)
            if (~debugOutput)
                delete([FragFigureName '*']);
            end
            error('Error %d -- LATEX:\n%s',status ,result);
            return;
        end
    end

    function s = latexInterpreter()
        if isunix
            appendix = '';
        else
            appendix = '.exe';
        end
        
        if (any( strcmpi(outputFormat,{'pdf', 'eps', 'png'})))
            s = ['"' strDistPath 'pdflatex' appendix '"'];
        else
            s = ['"' strDistPath 'latex' appendix '"'];
        end
    end

rmpath([currPath 'exportfig']);
rmpath([currPath 'gsconvert']);
rmpath([currPath 'matlabfrag']);
rmpath([currPath 'strsplit']);

end


