function createSubmissionZIP()
% PPGCC19 - thanks to james_tompkin@brown.edu for providing this code!
%
% Run this script to create an appropriate zip file to submit.

% Files we wish to include
% - Everything in 'code'
% - writeup/writeup.pdf

% Some of you will end up in a pickle and run this 
% from the wrong directory.
% Work out whether we're in the right directory
% to execute, e.g., one below 'code'
curdir = pwd;
[~,name,~] = fileparts( curdir );
foundMyself = strcmp( 'createSubmissionZIP.m', ls( 'createSubmissionZIP.m' ) );
if strcmp(name,'code') || strcmp(name,'data') || strcmp(name,'writeup')
    % Executing from the wrong directory,
    cd ..
elseif ~foundMyself
    % We haven't found this file, and 
    % any other potential place is too complex for us to track
    disp( 'Are you sure you''re executing this script from the right place?' );
    disp( 'Please make sure the MATLAB ''Current Folder'' contains createSubimssionZIP.m');
end

% Compile the PDF if it doesn't exist
writeupFile = ['writeup' filesep 'writeup.pdf'];
questionsFile = ['questions' filesep 'questions.pdf'];
if ~exist(writeupFile,'file')
    cd 'writeup'
    command1 = 'pdflatex writeup.tex';
    command2 = 'bibtex';
    % LaTeX assured compile sequence if bibtex is used
    system( command1 );
    system( command2 );
    system( command1 );
    system( command1 );
    cd ..
end

if ~exist(questionsFile,'file') && false
    cd 'questions'
    command1 = 'pdflatex questions.tex';
    command2 = 'bibtex';
    % LaTeX assured compile sequence if bibtex is used
    system( command1 );
    system( command2 );
    system( command1 );
    system( command1 );
    cd ..
end


zip( 'PPGCC19submission.zip', {'code/*.m','writeup/writeup.pdf'} );

end
