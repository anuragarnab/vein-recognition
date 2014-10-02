The problem:
------------
The creation of  a really beautiful and publishable graph with matlab 
is not easy but possible. 
However once you want to export your file you run into many problems, 
which are based on build in bugs of matlab whichhave not been fixed since years. 
They are however well documented by matlab ...

The two most important bugs are the missing font support and 
wrong linestyles. If you use any not standard postscript font 
such as “Times, Helvetica, Courier, Bookman” then the font 
gets replaced by Courier and your graph looks really ugly. 
The linestyles can only be fixed in the eps file directly, 
not in any other output format.

The solution
------------
The function 'latexfigure' is my own approach to solve this problem.
It is basically a wrapper to several existing funtions for the solution
of these problems.

It was inspired by mlf2pdf and uses matlabfrag to get around the 
eps font problem. However I had to patch matlabfrag to support 
also non math fonts.

The linestyles are corrected using the ‘fix_lines.m’ script 
from export_fig. 

The major drawback of this approach is that it requires a 
complete LaTeX collection to create a pdf version of the figure,
which can than be converted afterwards in the target format
using ghostscript.

