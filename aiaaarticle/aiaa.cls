%%
%% This is file `aiaanew.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% classes.dtx  (with options: `aiaa')
%% 
%% This is a generated file.
%% 
%% Copyright 1993 1994 1995 1996 1997 1998 1999 2000 2001 2002 2003 2004 2005 2006
%% The LaTeX3 Project and any individual authors listed elsewhere
%% in this file.
%% 
%% This file was generated from file(s) of the LaTeX base system.
%% --------------------------------------------------------------
%% 
%% It may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.3c
%% of this license or (at your option) any later version.
%% The latest version of this license is in
%%    http://www.latex-project.org/lppl.txt
%% and version 1.3c or later is part of all distributions of LaTeX
%% version 2005/12/01 or later.
%% 
%% This file has the LPPL maintenance status "maintained".
%% 
%% This file may only be distributed together with a copy of the LaTeX
%% base system. You may however distribute the LaTeX base system without
%% such generated files.
%% 
%% The list of all files belonging to the LaTeX base distribution is
%% given in the file `manifest.txt'. See also `legal.txt' for additional
%% information.
%% 
%% The list of derived (unpacked) files belonging to the distribution
%% and covered by LPPL is defined by the unpacking scripts (with
%% extension .ins) which are part of the distribution.
%% \CharacterTable
%%  {Upper-case    \A\B\C\D\E\F\G\H\I\J\K\L\M\N\O\P\Q\R\S\T\U\V\W\X\Y\Z
%%   Lower-case    \a\b\c\d\e\f\g\h\i\j\k\l\m\n\o\p\q\r\s\t\u\v\w\x\y\z
%%   Digits        \0\1\2\3\4\5\6\7\8\9
%%   Exclamation   \!     Double quote  \"     Hash (number) \#
%%   Dollar        \$     Percent       \%     Ampersand     \&
%%   Acute accent  \'     Left paren    \(     Right paren   \)
%%   Asterisk      \*     Plus          \+     Comma         \,
%%   Minus         \-     Point         \.     Solidus       \/
%%   Colon         \:     Semicolon     \;     Less than     \<
%%   Equals        \=     Greater than  \>     Question mark \?
%%   Commercial at \@     Left bracket  \[     Backslash     \\
%%   Right bracket \]     Circumflex    \^     Underscore    \_
%%   Grave accent  \`     Left brace    \{     Vertical bar  \|
%%   Right brace   \}     Tilde         \~}
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{aiaa}
              [2005/09/16 v1.4f
 Standard LaTeX document class]
\newcommand\@ptsize{}
\newif\if@restonecol
\newif\if@titlepage
\@titlepagefalse
\if@compatibility\else
\DeclareOption{a4paper}
   {\setlength\paperheight {297mm}%
    \setlength\paperwidth  {210mm}}
\DeclareOption{a5paper}
   {\setlength\paperheight {210mm}%
    \setlength\paperwidth  {148mm}}
\DeclareOption{b5paper}
   {\setlength\paperheight {250mm}%
    \setlength\paperwidth  {176mm}}
\DeclareOption{letterpaper}
   {\setlength\paperheight {11in}%
    \setlength\paperwidth  {8.5in}}
\DeclareOption{legalpaper}
   {\setlength\paperheight {14in}%
    \setlength\paperwidth  {8.5in}}
\DeclareOption{executivepaper}
   {\setlength\paperheight {10.5in}%
    \setlength\paperwidth  {7.25in}}
\DeclareOption{landscape}
   {\setlength\@tempdima   {\paperheight}%
    \setlength\paperheight {\paperwidth}%
    \setlength\paperwidth  {\@tempdima}}
\fi
\newif\if@ninepoint
\@ninepointfalse
\if@compatibility
  \renewcommand\@ptsize{0}
\else
\DeclareOption{9pt}{\renewcommand\@ptsize{0}\@ninepointtrue}
\fi
\DeclareOption{10pt}{\renewcommand\@ptsize{0}\@ninepointfalse}
\DeclareOption{11pt}{\renewcommand\@ptsize{1}\@ninepointfalse}
\DeclareOption{12pt}{\renewcommand\@ptsize{2}\@ninepointfalse}
\if@compatibility\else
\DeclareOption{oneside}{\@twosidefalse \@mparswitchfalse}
\fi
\DeclareOption{twoside}{\@twosidetrue  \@mparswitchtrue}
\DeclareOption{draft}{\setlength\overfullrule{5pt}}
\if@compatibility\else
\DeclareOption{final}{\setlength\overfullrule{0pt}}
\fi
\DeclareOption{titlepage}{\@titlepagetrue}
\if@compatibility\else
\DeclareOption{notitlepage}{\@titlepagefalse}
\fi
\if@compatibility\else
\DeclareOption{onecolumn}{\@twocolumnfalse}
\fi
\DeclareOption{twocolumn}{\@twocolumntrue}
\DeclareOption{leqno}{\input{leqno.clo}}
\DeclareOption{fleqn}{\input{fleqn.clo}}
\DeclareOption{openbib}{%
  \AtEndOfPackage{%
   \renewcommand\@openbib@code{%
      \advance\leftmargin\bibindent
      \itemindent -\bibindent
      \listparindent \itemindent
      \parsep \z@
      }%
   \renewcommand\newblock{\par}}%
}
\newif\if@conference
\@conferencefalse
\if@compatibility\else
\DeclareOption{conference}{\@conferencetrue}
\fi
\newif\if@submit
\@submitfalse
\if@compatibility\else
\DeclareOption{submit}{\@submittrue}
\fi

\newif\if@mtpro
\@mtprofalse
\if@compatibility\else
\DeclareOption{mtpro}{\@mtprotrue}
\fi

\ExecuteOptions{letterpaper,9pt,oneside,twocolumn,final}
\ProcessOptions
\input{size1\@ptsize.clo}
\if@submit
\@conferencetrue
\@twocolumnfalse
\fi

\setlength\lineskip{1\p@}
\setlength\normallineskip{1\p@}
\renewcommand\baselinestretch{}
\setlength\parskip{0\p@ \@plus \p@}
\@lowpenalty   51
\@medpenalty  151
\@highpenalty 301
\setcounter{topnumber}{2}
\renewcommand\topfraction{.9}
\setcounter{bottomnumber}{1}
\renewcommand\bottomfraction{.1}
\setcounter{totalnumber}{3}
\renewcommand\textfraction{.2}
\renewcommand\floatpagefraction{.9}
\setcounter{dbltopnumber}{2}
\renewcommand\dbltopfraction{.9}
\renewcommand\dblfloatpagefraction{.9}
\if@twoside
  \def\ps@headings{%
      \let\@oddfoot\@empty\let\@evenfoot\@empty
      \def\@evenhead{\thepage\hfil\slshape\leftmark}%
      \def\@oddhead{{\slshape\rightmark}\hfil\thepage}%
      \let\@mkboth\markboth
    \def\sectionmark##1{%
      \markboth {\MakeUppercase{%
        \ifnum \c@secnumdepth >\z@
          \thesection\quad
        \fi
        ##1}}{}}%
    \def\subsectionmark##1{%
      \markright {%
        \ifnum \c@secnumdepth >\@ne
          \thesubsection\quad
        \fi
        ##1}}}
\else
  \def\ps@headings{%
    \let\@oddfoot\@empty
    \def\@oddhead{{\slshape\rightmark}\hfil\thepage}%
    \let\@mkboth\markboth
    \def\sectionmark##1{%
      \markright {\MakeUppercase{%
        \ifnum \c@secnumdepth >\m@ne
          \thesection\quad
        \fi
        ##1}}}}
\fi
\def\ps@myheadings{%
    \let\@oddfoot\@empty\let\@evenfoot\@empty
    \def\@evenhead{\thepage\hfil\slshape\leftmark}%
    \def\@oddhead{{\slshape\rightmark}\hfil\thepage}%
    \let\@mkboth\@gobbletwo
    \let\sectionmark\@gobble
    \let\subsectionmark\@gobble
    }
  \if@titlepage
  \newcommand\maketitle{\begin{titlepage}%
  \let\footnotesize\small
  \let\footnoterule\relax
  \let \footnote \thanks
  \null\vfil
  \vskip 60\p@
  \begin{center}%
    \linespread{1.0}
    {\Huge \@title \par}%
    \vskip 3em%
    {\large
     \lineskip .75em%
      \begin{tabular}[t]{c}%
        \@author
      \end{tabular}\par}%
      \vskip 1.5em%
    {\large \@date \par}%       % Set date in \large size.
  \end{center}\par
  \@thanks
  \vfil\null
  \end{titlepage}%
  \setcounter{footnote}{0}%
  \global\let\thanks\relax
  \global\let\maketitle\relax
  \global\let\@thanks\@empty
  \global\let\@author\@empty
  \global\let\@date\@empty
  \global\let\@title\@empty
  \global\let\title\relax
  \global\let\author\relax
  \global\let\date\relax
  \global\let\and\relax
}
\else
\newcommand\maketitle{\par
    \linespread{1.0}
  \begingroup
    \renewcommand\thefootnote{\@fnsymbol\c@footnote}%
    \def\@makefnmark{\rlap{\@textsuperscript{\normalfont\@thefnmark}}}%
    \long\def\@makefntext##1{\parindent 1em\noindent
            \hb@xt@1.8em{%
                \hss\@textsuperscript{\normalfont\@thefnmark}}##1}%
    \if@twocolumn
      \ifnum \col@number=\@ne
        \@maketitle
      \else
        \twocolumn[\@maketitle]%
      \fi
    \else
      \newpage
      \global\@topnum\z@   % Prevents figures from going at top of page.
      \@maketitle
    \fi
    \thispagestyle{plain}\@thanks
  \endgroup
  \setcounter{footnote}{0}%
  \global\let\thanks\relax
  \global\let\maketitle\relax
  \global\let\@maketitle\relax
  \global\let\@thanks\@empty
  \global\let\@author\@empty
  \global\let\@date\@empty
  \global\let\@title\@empty
  \global\let\title\relax
  \global\let\author\relax
  \global\let\date\relax
  \global\let\and\relax
}
\def\@maketitle{%
  \newpage
  \null
  \vskip 2em%
  \begin{center}%
  \let \footnote \thanks
    {\Huge \bfseries \boldmath \@title \par}%
    \vskip 1.5em%
    {\large
      \lineskip .5em%
      \begin{tabular}[t]{c}%
        \@author
      \end{tabular}\par}%
    \vskip 2em%
      \begin{minipage}{13.4cm}
\linespread{1.0}
\bfseries\boldmath\small \@abstract
      \end{minipage}
    \vskip 1em%
 
%    {\large \@date}%
  \end{center}%
  \par
  \vskip 1.5em}
\fi
\setcounter{secnumdepth}{3}
\newcounter {part}
\newcounter {section}
\newcounter {subsection}[section]
\newcounter {subsubsection}[subsection]
\newcounter {paragraph}[subsubsection]
\newcounter {subparagraph}[paragraph]
\renewcommand \thepart {\@Roman\c@part}
\renewcommand \thesection {\@Roman\c@section.}
\renewcommand\thesubsection   {\@Alph\c@subsection.}
\renewcommand\thesubsubsection{\@arabic\c@subsubsection}
\renewcommand\theparagraph    {\@alph\c@paragraph}
\renewcommand\thesubparagraph {\@roman\c@subparagraph}
\newcommand\part{%
   \if@noskipsec \leavevmode \fi
   \par
   \addvspace{4ex}%
   \@afterindentfalse
   \secdef\@part\@spart}

\def\@part[#1]#2{%
    \ifnum \c@secnumdepth >\m@ne
      \refstepcounter{part}%
      \addcontentsline{toc}{part}{\thepart\hspace{1em}#1}%
    \else
      \addcontentsline{toc}{part}{#1}%
    \fi
    {\parindent \z@ \raggedright
     \interlinepenalty \@M
     \normalfont
     \ifnum \c@secnumdepth >\m@ne
       \Large\bfseries \partname\nobreakspace\thepart
       \par\nobreak
     \fi
     \huge \bfseries #2%
     \markboth{}{}\par}%
    \nobreak
    \vskip 3ex
    \@afterheading}
\def\@spart#1{%
    {\parindent \z@ \raggedright
     \interlinepenalty \@M
     \normalfont
     \huge \bfseries #1\par}%
     \nobreak
     \vskip 3ex
     \@afterheading}
\newcommand\section{\@startsection {section}{1}{\z@}%
                                   {-3.5ex \@plus -1ex \@minus -.2ex}%
                                   {2.3ex \@plus.2ex}%
                                   {\normalfont\large\bfseries\boldmath\center}}
\newcommand\subsection{\@startsection{subsection}{2}{\z@}%
                                     {-3.25ex\@plus -1ex \@minus -.2ex}%
                                     {1.5ex \@plus .2ex}%
                                     {\normalfont\bfseries}}
\newcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
                                     {-3.25ex\@plus -1ex \@minus -.2ex}%
                                     {1.5ex \@plus .2ex}%
                                     {\normalfont\normalsize\bfseries}}
\newcommand\paragraph{\@startsection{paragraph}{4}{\z@}%
                                    {3.25ex \@plus1ex \@minus.2ex}%
                                    {-1em}%
                                    {\normalfont\normalsize\bfseries}}
\newcommand\subparagraph{\@startsection{subparagraph}{5}{\parindent}%
                                       {3.25ex \@plus1ex \@minus .2ex}%
                                       {-1em}%
                                      {\normalfont\normalsize\bfseries}}
\if@twocolumn
  \setlength\leftmargini  {2em}
\else
  \setlength\leftmargini  {2.5em}
\fi
\leftmargin  \leftmargini
\setlength\leftmarginii  {2.2em}
\setlength\leftmarginiii {1.87em}
\setlength\leftmarginiv  {1.7em}
\if@twocolumn
  \setlength\leftmarginv  {.5em}
  \setlength\leftmarginvi {.5em}
\else
  \setlength\leftmarginv  {1em}
  \setlength\leftmarginvi {1em}
\fi
\setlength  \labelsep  {0.5em}
\setlength  \labelwidth{\leftmargini}
\addtolength\labelwidth{-\labelsep}
\@beginparpenalty -\@lowpenalty
\@endparpenalty   -\@lowpenalty
\@itempenalty     -\@lowpenalty
\renewcommand\theenumi{\@arabic\c@enumi}
\renewcommand\theenumii{\@alph\c@enumii}
\renewcommand\theenumiii{\@roman\c@enumiii}
\renewcommand\theenumiv{\@Alph\c@enumiv}
\newcommand\labelenumi{\theenumi.}
\newcommand\labelenumii{(\theenumii)}
\newcommand\labelenumiii{\theenumiii.}
\newcommand\labelenumiv{\theenumiv.}
\renewcommand\p@enumii{\theenumi}
\renewcommand\p@enumiii{\theenumi(\theenumii)}
\renewcommand\p@enumiv{\p@enumiii\theenumiii}
\newcommand\labelitemi{\textbullet}
\newcommand\labelitemii{\normalfont\bfseries \textendash}
\newcommand\labelitemiii{\textasteriskcentered}
\newcommand\labelitemiv{\textperiodcentered}
\newenvironment{description}
               {\list{}{\labelwidth\z@ \itemindent-\leftmargin
                        \let\makelabel\descriptionlabel}}
               {\endlist}
\newcommand*\descriptionlabel[1]{\hspace\labelsep
                                \normalfont\bfseries #1}



\if@titlepage

%  \newenvironment{abstract}{%
%      \titlepage
%      \null\vfil
%      \@beginparpenalty\@lowpenalty
%      \begin{center}%
%        \bfseries \abstractname
%        \@endparpenalty\@M
%      \end{center}}%
     {\par\vfil\null\endtitlepage}
\else
%  \newenvironment{abstract}{%
%      \if@twocolumn
%        \section*{\abstractname}%
%      \else
%        \small
%        \begin{center}%
%          {\bfseries \abstractname\vspace{-.5em}\vspace{\z@}}%
%        \end{center}%
%        \quotation
%      \fi}
      {\if@twocolumn\else
%\endquotation
\fi}
\fi
\newenvironment{verse}
               {\let\\\@centercr
                \list{}{\itemsep      \z@
                        \itemindent   -1.5em%
                        \listparindent\itemindent
                        \rightmargin  \leftmargin
                        \advance\leftmargin 1.5em}%
                \item\relax}
               {\endlist}
\newenvironment{quotation}
               {\list{}{\listparindent 1.5em%
                        \itemindent    \listparindent
                        \rightmargin   \leftmargin
                        \parsep        \z@ \@plus\p@}%
                \item\relax}
               {\endlist}
\newenvironment{quote}
               {\list{}{\rightmargin\leftmargin}%
                \item\relax}
               {\endlist}
\if@compatibility
\newenvironment{titlepage}
    {%
      \if@twocolumn
        \@restonecoltrue\onecolumn
      \else
        \@restonecolfalse\newpage
      \fi
      \thispagestyle{empty}%
      \setcounter{page}\z@
    }%
    {\if@restonecol\twocolumn \else \newpage \fi
    }
\else
\newenvironment{titlepage}
    {%
      \if@twocolumn
        \@restonecoltrue\onecolumn
      \else
        \@restonecolfalse\newpage
      \fi
      \thispagestyle{empty}%
      \setcounter{page}\@ne
    }%
    {\if@restonecol\twocolumn \else \newpage \fi
     \if@twoside\else
        \setcounter{page}\@ne
     \fi
    }
\fi
\newcommand\appendix{\par
  \setcounter{section}{0}%
  \setcounter{subsection}{0}%
  \gdef\thesection{\@Alph\c@section}
  \setcounter{equation}{0}
  \@addtoreset{equation}{section}%
  \gdef\theequation{\@Alph\c@section.\arabic{equation}}%
}
\setlength\arraycolsep{5\p@}
\setlength\tabcolsep{6\p@}
\setlength\arrayrulewidth{.4\p@}
\setlength\doublerulesep{2\p@}
\setlength\tabbingsep{\labelsep}
\skip\@mpfootins = \skip\footins
\setlength\fboxsep{3\p@}
\setlength\fboxrule{.4\p@}
\renewcommand \theequation {\@arabic\c@equation}
\newcounter{figure}
\renewcommand \thefigure {\@arabic\c@figure}
\def\fps@figure{tbp}
\def\ftype@figure{1}
\def\ext@figure{lof}
\def\fnum@figure{\fontsizecaption\bfseries\boldmath\figurename\nobreakspace\thefigure}
\newenvironment{figure}
               {\@float{figure}}
               {\end@float}
\newenvironment{figure*}
               {\@dblfloat{figure}}
               {\end@dblfloat}
\newcounter{table}
\renewcommand\thetable{\@arabic\c@table}
\def\fps@table{tbp}
\def\ftype@table{2}
\def\ext@table{lot}
\def\fnum@table{\fontsizecaption\bfseries\boldmath\tablename\nobreakspace\thetable}
\newenvironment{table}
               {\@float{table}}
               {\end@float}
\newenvironment{table*}
               {\@dblfloat{table}}
               {\end@dblfloat}
\newlength\abovecaptionskip
\newlength\belowcaptionskip
\setlength\abovecaptionskip{10\p@}
\setlength\belowcaptionskip{0\p@}
\long\def\@makecaption#1#2{%
  \vskip\abovecaptionskip
  \sbox\@tempboxa{#1: #2}%
  \fontsizecaption
  \ifdim \wd\@tempboxa >\hsize
     #1: #2\par
  \else
    \global \@minipagefalse
    \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
  \fi 
  \vskip\belowcaptionskip}
\DeclareOldFontCommand{\rm}{\normalfont\rmfamily}{\mathrm}
\DeclareOldFontCommand{\sf}{\normalfont\sffamily}{\mathsf}
\DeclareOldFontCommand{\tt}{\normalfont\ttfamily}{\mathtt}
\DeclareOldFontCommand{\bf}{\normalfont\bfseries}{\mathbf}
\DeclareOldFontCommand{\it}{\normalfont\itshape}{\mathit}
\DeclareOldFontCommand{\sl}{\normalfont\slshape}{\@nomath\sl}
\DeclareOldFontCommand{\sc}{\normalfont\scshape}{\@nomath\sc}
\DeclareRobustCommand*\cal{\@fontswitch\relax\mathcal}
\DeclareRobustCommand*\mit{\@fontswitch\relax\mathnormal}
\newcommand\@pnumwidth{1.55em}
\newcommand\@tocrmarg{2.55em}
\newcommand\@dotsep{4.5}
\setcounter{tocdepth}{3}
\newcommand\tableofcontents{%
    \section*{\contentsname
        \@mkboth{%
           \MakeUppercase\contentsname}{\MakeUppercase\contentsname}}%
    \@starttoc{toc}%
    }
\newcommand*\l@part[2]{%
  \ifnum \c@tocdepth >-2\relax
    \addpenalty\@secpenalty
    \addvspace{2.25em \@plus\p@}%
    \setlength\@tempdima{3em}%
    \begingroup
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      {\leavevmode
       \large \bfseries #1\hfil \hb@xt@\@pnumwidth{\hss #2}}\par
       \nobreak
       \if@compatibility
         \global\@nobreaktrue
         \everypar{\global\@nobreakfalse\everypar{}}%
      \fi
    \endgroup
  \fi}
\newcommand*\l@section[2]{%
  \ifnum \c@tocdepth >\z@
    \addpenalty\@secpenalty
    \addvspace{1.0em \@plus\p@}%
    \setlength\@tempdima{1.5em}%
    \begingroup
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      \leavevmode \bfseries
      \advance\leftskip\@tempdima
      \hskip -\leftskip
      #1\nobreak\hfil \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
    \endgroup
  \fi}
\newcommand*\l@subsection{\@dottedtocline{2}{1.5em}{2.3em}}
\newcommand*\l@subsubsection{\@dottedtocline{3}{3.8em}{3.2em}}
\newcommand*\l@paragraph{\@dottedtocline{4}{7.0em}{4.1em}}
\newcommand*\l@subparagraph{\@dottedtocline{5}{10em}{5em}}
\newcommand\listoffigures{%
    \section*{\listfigurename}%
      \@mkboth{\MakeUppercase\listfigurename}%
              {\MakeUppercase\listfigurename}%
    \@starttoc{lof}%
    }
\newcommand*\l@figure{\@dottedtocline{1}{1.5em}{2.3em}}
\newcommand\listoftables{%
    \section*{\listtablename}%
      \@mkboth{%
          \MakeUppercase\listtablename}%
         {\MakeUppercase\listtablename}%
    \@starttoc{lot}%
    }
\let\l@table\l@figure
\newdimen\bibindent
\setlength\bibindent{1.5em}
\newenvironment{thebibliography}[1]
     {\section*{\refname}%
      \@mkboth{\MakeUppercase\refname}{\MakeUppercase\refname}%
      \list{\@biblabel{\@arabic\c@enumiv}}%
           {\settowidth\labelwidth{\@biblabel{#1}}%
            \leftmargin\labelwidth
            \advance\leftmargin\labelsep
            \@openbib@code
            \usecounter{enumiv}%
            \let\p@enumiv\@empty
            \renewcommand\theenumiv{\@arabic\c@enumiv}}%
      \sloppy
      \clubpenalty4000
      \@clubpenalty \clubpenalty
      \widowpenalty4000%
      \sfcode`\.\@m}
     {\def\@noitemerr
       {\@latex@warning{Empty `thebibliography' environment}}%
      \endlist}
\newcommand\newblock{\hskip .11em\@plus.33em\@minus.07em}
\let\@openbib@code\@empty
\newenvironment{theindex}
               {\if@twocolumn
                  \@restonecolfalse
                \else
                  \@restonecoltrue
                \fi
                \twocolumn[\section*{\indexname}]%
                \@mkboth{\MakeUppercase\indexname}%
                        {\MakeUppercase\indexname}%
                \thispagestyle{plain}\parindent\z@
                \parskip\z@ \@plus .3\p@\relax
                \columnseprule \z@
                \columnsep 35\p@
                \let\item\@idxitem}
               {\if@restonecol\onecolumn\else\clearpage\fi}
\newcommand\@idxitem{\par\hangindent 40\p@}
\newcommand\subitem{\@idxitem \hspace*{20\p@}}
\newcommand\subsubitem{\@idxitem \hspace*{30\p@}}
\newcommand\indexspace{\par \vskip 10\p@ \@plus5\p@ \@minus3\p@\relax}
\renewcommand\footnoterule{%
  \kern-3\p@
  \hrule\@width.4\columnwidth
  \kern2.6\p@}
\newcommand\@makefntext[1]{%
    \parindent 1em%
    \noindent
    \hb@xt@1.8em{\hss\@makefnmark}#1}
\newcommand\contentsname{Contents}
\newcommand\listfigurename{List of Figures}
\newcommand\listtablename{List of Tables}
\newcommand\refname{References}
\newcommand\indexname{Index}
\newcommand\figurename{Figure}
\newcommand\tablename{Table}
\newcommand\partname{Part}
\newcommand\appendixname{Appendix}
\newcommand\abstractname{Abstract}
\def\today{\ifcase\month\or
  January\or February\or March\or April\or May\or June\or
  July\or August\or September\or October\or November\or December\fi
  \space\number\day, \number\year}
\setlength\columnsep{10\p@}
\setlength\columnseprule{0\p@}
\pagestyle{plain}
\pagenumbering{arabic}
\if@twoside
\else
  \raggedbottom
\fi
\if@twocolumn
  \twocolumn
  \sloppy
  \flushbottom
\else
  \onecolumn
\fi


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Dropword

  \RequirePackage[dvips]{dropping}% dvips set to make compatible with pdflatex

\if@submit
    \def\dropword#1#2 {#1#2 }
\else
    \def\dropword#1#2 {
      \dropping{2}{\bfseries{} #1\hspace{0.15em}}\normalfont{}\MakeUppercase{#2}
    }% spaces important!
\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fonts
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{amsmath}
% Use STIX instead of times: looks almost the same but avoids the bug of times font when used in conjunction with psfrag and a eps fig that also uses times
  \IfFileExists{stix.sty}%
  {
    \AtEndOfClass{
      \RequirePackage[nomath]{stix}
    }
  }
  {
    \AtEndOfClass{
      \RequirePackage{times}  
    }
  }

%  \IfFileExists{mtpro2.sty}%
  \if@mtpro
   \AtEndOfClass{
    \RequirePackage{mtpro2}       % mathtimes pro 2 package (commercial)
    \enablesubscriptcorrection
%  \DeclareMathSizes{9}{9}{5.0}{4.6}   % redefine the math font sizes for 10pt document
%  \DeclareMathSizes{10}{10}{5.5}{5.1}   % redefine the math font sizes for 10pt document
%  \DeclareMathSizes{11}{11}{6.05}{5.61}  % redefine the math font sizes for 11pt document
%  \DeclareMathSizes{12}{12}{6.6}{6.12}  % redefine the math font sizes for 12pt document
    \DeclareMathSymbol{0}{\mathalpha}{operators}{`0}\DeclareMathSymbol{1}{\mathalpha}{operators}{`1}\DeclareMathSymbol{2}{\mathalpha}{operators}{`2}\DeclareMathSymbol{3}{\mathalpha}{operators}{`3}\DeclareMathSymbol{4}{\mathalpha}{operators}{`4}\DeclareMathSymbol{5}{\mathalpha}{operators}{`5}\DeclareMathSymbol{6}{\mathalpha}{operators}{`6}\DeclareMathSymbol{7}{\mathalpha}{operators}{`7}\DeclareMathSymbol{8}{\mathalpha}{operators}{`8}\DeclareMathSymbol{9}{\mathalpha}{operators}{`9}}
  \else
    \AtEndOfClass{
      \RequirePackage{txfonts}
      \DeclareMathSizes{10}{10}{6.5}{5.5}
      \RequirePackage{amssymb}
      \let\wtilde\tilde
      \let\what\hat
      \let\wbar\bar
      \let\XL\displaystyle
      \let\mathbold\bf
      \let\overcbrace\overbrace
      \let\undercbrace\underbrace
    }
  \fi


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% MISC

\renewcommand\figurename{Fig.}

\if@conference
  \RequirePackage{lastpage}
%  \renewcommand{\thepage}{\arabic{page} of \pageref{LastPage}} 
  \renewcommand{\thepage}{\arabic{page}} 
\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% \tablecaption command: creates a AIAA-like table caption
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%\let\tablecaption\caption
%\let\figurecaption\caption
\newcommand{\tablecaption}[1]{\caption{\fontsizecaption\bfseries{\boldmath #1}}}
\newcommand{\figurecaption}[1]{\caption{\fontsizecaption\bfseries{\boldmath #1}}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% TABLES AND FIGURES
%%  from booktabs.sty and altered to obtain a double toprule and botrule
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{scalefnt}
\RequirePackage{fixltx2e}
%\RequirePackage{stfloats}
\newlength\lengthfigure                  % declare a figure width unit
\setlength\lengthfigure{1.0in} % make the figure width unit scale with the textwidth


\newdimen\heavyrulewidth
\newdimen\lightrulewidth
\newdimen\cmidrulewidth
\newdimen\belowrulesep
\newdimen\aboverulesep
\newdimen\cmidrulesep
\newdimen\cmidrulekern
\newdimen\defaultaddspace
\heavyrulewidth=.08em
\lightrulewidth=.05em
\cmidrulewidth=.03em
\belowrulesep=.65ex
\aboverulesep=.4ex
\cmidrulesep=\doublerulesep
\cmidrulekern=.25em
\defaultaddspace=0.02em
\newcount\rulesflag
\newdimen\@cmidrulewidth
\newcount\@cmidla
\newcount\@cmidlb
\rulesflag=0
\def\toprule{\noalign{\ifnum0=`}\fi
    \@ifnextchar[{\@toprule}{\@toprule[\lightrulewidth]}}
\def\@toprule[#1]{\ifnum\rulesflag=1\vskip
    \doublerulesep\global\rulesflag=0\fi
    \hrule\vspace{0.05cm}\hrule \@height#1\futurelet\@tempa\@endrule}
\def\@endrule{\ifx\@tempa\toprule\global\rulesflag=1%
    \else\ifx\@tempa\midrule\global\rulesflag=1%
    \else\ifx\@tempa\bottomrule\global\rulesflag=1%
    \else\ifx\@tempa\cmidrule\global\rulesflag=1%
    \else\ifx\@tempa\specialrule\global\rulesflag=1%
    \else\ifx\@tempa\addlinespace\global\rulesflag=1%
    \else\vskip \belowrulesep\fi\fi\fi\fi\fi\fi\ifnum0=`{\fi}}
\def\midrule{\noalign{\ifnum0=`}\fi
    \@ifnextchar[{\@midrule}{\@midrule[\lightrulewidth]}}
\def\@midrule[#1]{\ifnum\rulesflag=1\vskip \doublerulesep\global\rulesflag=0
    \else\vskip \aboverulesep\fi
    \hrule \@height#1\futurelet\@tempa\@endrule}
\def\@botrule[#1]{\ifnum\rulesflag=1\vskip \doublerulesep\global\rulesflag=0
    \else\vskip \aboverulesep\fi
    \hrule\vspace{0.05cm}\hrule \@height#1\futurelet\@tempa\@endrule}
\def\bottomrule{\noalign{\ifnum0=`}\fi
    \@ifnextchar[{\@botrule}{\@botrule[\lightrulewidth]}}
\def\addlinespace{\noalign{\ifnum0=`}\fi
    \@ifnextchar[{\@addspace}{\@addspace[\defaultaddspace]}}
\def\@addspace[#1]{\ifnum\rulesflag=1\global\rulesflag=0\fi
    \vskip #1\futurelet\@tempa\@endrule}
\def\specialrule#1#2#3{\noalign{
    \ifnum\rulesflag=1\global\rulesflag=0
    \else\vskip #2\fi\hrule \@height#1\vskip #3}}
\def\cmidrule{\noalign{\ifnum0=`}\fi
    \@ifnextchar[{\@cmidrule}{\@cmidrule[\cmidrulewidth]}}
\def\@cmidrule[#1]{\@ifnextchar({\@@cmidrule[#1]}{\@@cmidrule[#1]()}}
\def\@@cmidrule[#1](#2)#3{\@@@cmidrule[#3]{#1}{#2}}
\def\@@@cmidrule[#1-#2]#3#4{\global\@cmidla#1\relax
    \global\advance\@cmidla\m@ne
    \ifnum\@cmidla>0\global\let\@gtempa\@cmidrulea\else
    \global\let\@gtempa\@cmidruleb\fi
    \global\@cmidlb#2\relax
    \global\advance\@cmidlb-\@cmidla
    \global\@cmidrulewidth=#3
    \global\let\cmlkern@l\z@ \global\let\cmlkern@r\z@
    \@tfor\@tempa :=#4\do{\global\expandafter\let
        \csname cmlkern@\@tempa\endcsname\cmidrulekern}%
\ifnum\rulesflag=0\vskip \aboverulesep\fi\ifnum0=`{\fi}\@gtempa
    \noalign{\ifnum0=`}\fi\futurelet\@tempa\@xcmidrule}
\def\@cmidrulea{\multispan\@cmidla&\multispan\@cmidlb
    \unskip\hskip \cmlkern@l\leaders\hrule \@height\@cmidrulewidth\hfill
    \hskip \cmlkern@r\cr}
\def\@cmidruleb{\multispan\@cmidlb
    \unskip\hskip \cmlkern@l\leaders\hrule \@height\@cmidrulewidth\hfill
    \hskip \cmlkern@r\cr}
\def\@xcmidrule{\ifx\@tempa\cmidrule\vskip-\@cmidrulewidth
    \global\rulesflag=1\else
    \ifx\@tempa\morecmidrules\vskip \cmidrulesep
    \global\rulesflag=1\else
    \vskip \belowrulesep\global\rulesflag=0\fi\fi
    \ifnum0=`{\fi}}
\def\morecmidrules{\noalign{\relax}}




%          \newenvironment{AA@abstract}
%          {\list{}{\listparindent 1.5em%
%                \itemindent \listparindent
%                \leftmargin 0.85in%
%                \rightmargin 0.85in
%                \parsep \z@ \@plus \p@}%
%                \item\relax}
%           {\endlist}


%%%%%%%%%%=-ABSTRACT-=%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




\newcommand{\abstract}[1]{\gdef\@abstract{#1}}


\newcommand{\makeabstract}
{
 \section*{Abstract}%
 \@abstract 
}

%%%%%%%%%%=-ACKNOWLEDGEMENTS-=%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


\newif\if@acknowledgments
\@acknowledgmentsfalse
\def\acknowledgments#1{
  \def\theacknowledgments{#1}
  \@acknowledgmentstrue
}

\newif\if@acknowledgment
\@acknowledgmentfalse
\def\acknowledgment#1{
  \def\theacknowledgment{#1}
  \@acknowledgmenttrue
}





%\RequirePackage{setspace}
\if@twocolumn
\else
 \RequirePackage{multicol}
\fi


%%%%%%%%%%=-NOMENCLATURE-=%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newlength\nomenclaturelabelwidth
\setlength\nomenclaturelabelwidth{0.13\hsize}
\newlength\nomenclaturecolumnsep
\setlength\nomenclaturecolumnsep{0.09\hsize}

%                                     %
%                                     {1.5ex \@plus .2ex}%
%                                     {\normalfont\normalsize\bfseries\boldmath}}


\newenvironment{nomenclaturelist}[1]
               {\raggedright\vspace{2.25ex}\noindent{\normalfont\normalsize\em #1}\list{}{
	       \itemsep 0 em
	       \topsep  0.6 em
	       \leftmargin \nomenclaturelabelwidth
	       \rightmargin 0.0 in
	       \parsep 0.0 in
	       \itemindent 0.0 in
	       \labelsep 0.00 in
	       \labelwidth \leftmargin
               \addtolength\labelwidth{-\labelsep}
	       \let\makelabel\nomenclaturelistlabel
	       }}
               {\endlist}
\newcommand*\nomenclaturelistlabel[1]{\hspace\labelsep \normalfont #1 \hfill \mbox{=~~~}}

\newcommand{\nomenclature}[1]{\gdef\@nomenclature{#1}}


\newcommand{\makenomenclature}
{
 \section*{Nomenclature\@mkboth{Nomenclature}{Nomenclature}}%
% \addcontentsline{toc}{section}{Nomenclature}
 \setlength\columnsep{\nomenclaturecolumnsep}

\if@twocolumn
   \@nomenclature
\else
 \begin{multicols}{2}{
   \@nomenclature
 }
 \end{multicols}
\fi


}





%%%%%%%%%%%%%%%%%%%%%% threeparttable.sty from Donald Arseneau  %%%%%%%%%%%%%%%%%%%%%

% MODIFIED BY BERNARD PARENT, 20 APRIL 2002
% threeparttable.sty   (or 3parttable) (or 3parttab on DOS)
% by Donald Arseneau   Updated on May 13, 1999.
% This file may be distributed, modified, and used in other works with just
% one restriction: modified versions must clearly indicate the modification
% (preferably by a name change).
%
% This package facilitates tables with titles (captions) and notes. The
% title and notes are given a width equal to the body of the table (a
% tabular environment).  By itself, a threeparttable does not float, but
% you can put it in a {table} or a {table*} or some other environment.
% (This causes extra typing, but gives more flexibility.)
%
% Inside a threeparttable there should be a caption, followed by a tabular
% environment, possibly followed by a series of itemized "tablenotes".  At
% present, there is nothing automatic about the notes; you must specify the
% identifier in the body of the table ("\tnote{a}") and in the notes below
% ("\item[a]...").  I chose this method because automatic numbering with
% \footnote would be very hard to use, particularly because many tables
% make repeated reference to a single note.  If someone has a suggestion
% for a convenient, elegant, automatic system, I'll listen!  \tnote
% commands can be given in the caption too, and they will *NOT* appear in
% the list of tables.
%
% \begin{table}
%  \begin{threeparttable}
%   \caption{...}
%   \begin{tabular}...% or {tabular*}
%    ...\tnote{1}&....
%    ...
%   \end{tabular}
%   \begin{tablenotes}
%    \item [1] the first note
%    ...
%   \end{tablenotes}
%  \end{threeparttable}
% \end{table}
%
% NOTE: this version has been altered by BERNARD PARENT to take into
%       account the tablecaption captions
%
\edef\endtablenotes % make a scratch macro for restoring catcodes
  {\catcode\string `\string @=\the\catcode\string`\@
   \catcode\string `\string *=\the\catcode\string`\*}
\catcode`\@=11
\catcode`\*=11

\@ifundefined{@tempboxb}{\@nameuse{newbox}\@tempboxb}{}

\newenvironment{threeparttable}{% 3 parts: title, tabular environment, notes
\relax \ifx\\\@centercr \leavevmode \fi
\vbox\bgroup\sloppy
\@ifundefined{@captype}{\def\@captype{table}}{}%
\topsep\z@
\@enumdepth\z@
\global\let\TPT@hsize\@empty
\let\TPT@LA@caption\@caption \let\@caption\TPT@caption
%%%%%%%% ADDITION BY BERNARD PARENT
\let\TPT@LA@tablecaption\@tablecaption \let\@tablecaption\TPT@tablecaption
%%%%%%%% END OF ADDITION
\TPT@hookin\tabular\TPT@LA@tabular \TPT@hookin\tabular*\TPT@LA@tabular*
\let\TPTrlap\relax}%
{\egroup}

\def\TPT@endtab{\everyhbox{}%
\setbox\@tempboxb\lastbox   % grab tabular environment and measure it
\xdef\TPT@hsize{\hsize\the\wd\@tempboxb \parindent 1em
  \noexpand\@parboxrestore}\TPT@hsize\aftergroup\TPT@hsize
\ifx\TPT@docapt\@undefined\else
  \TPT@docapt \vskip.2\baselineskip
\fi \par \box\@tempboxb \prevdepth\z@ }

\def\TPT@hookin#1#2{\let#2#1\def#1{\edef\TPT@evh{{\the\everyhbox}}\everyhbox
  {\let\tabular\TPT@LA@tabular \let\tabular*\TPT@LA@tabular*
  \aftergroup\TPT@endtab \let\TPTrlap\rlap \everyhbox\TPT@evh}#2}}%

\gdef\TPT@hsize{}

\def\TPT@caption#1[#2]#3{\gdef\TPT@docapt
 {\par\global\let\TPT@docapt\@undefined \TPT@LA@caption{#1}[#2]{#3}}%
 \ifx\TPT@hsize\@empty\else \TPT@docapt \fi \ignorespaces}
%%%%%%%%% ADDITION BY BERNARD PARENT
\def\TPT@tablecaption#1[#2]#3{\gdef\TPT@docapt
 {\par\global\let\TPT@docapt\@undefined \TPT@LA@tablecaption{#1}[#2]{#3}}%
 \ifx\TPT@hsize\@empty\else \TPT@docapt \fi \ignorespaces}
%%%%%%%%% END OF ADDITION
\def\tablenotes{\TPT@hsize \list{}{\topsep\z@skip \partopsep\z@skip
\itemsep\z@ \parsep\z@ \itemindent\z@ \leftmargin1.5em
%  for superscript enumeration, use:
\def\makelabel##1{\tnote{##1}\hfil}\labelwidth .5em\labelsep .3em%
%  for on-the-line enumeration use:
% \labelwidth 1em\labelsep .5em%
\relax}}

\def\tnote#1{\protect\TPTrlap{$^{\fam\z@ #1}$}}%
\def\TPTrlap#1{} % notes in caption will disappear in list of tables!


\endtablenotes % restore catcode of @ and * to starting value

\let\endtablenotes\endlist % and assign proper meaning for \endtablenotes!



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Page Layout (Margins and so on)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%\RequirePackage{setspace}

%% Footnotes are always single-spaced.
%%\let\@@footnotetext=\@footnotetext
%%\def\@footnotetext{\begin{spacing}{1}\@@footnotetext\end{spacing}}

\if@conference
  % Set up page layout.
  \setlength{\textheight}{22.86cm} % Height of the main body of the text
  \addtolength{\textheight}{0cm} 
  \setlength{\topmargin}{-1.6cm} % 0.7" margin on top of page
  %\addtolength{\topmargin}{-\paperheight} 
  \setlength{\headsep}{.5in}  % space between header and top of body
  \addtolength{\headsep}{-\headheight} % See The LaTeX Companion, p 85
  \setlength{\footskip}{.5in}  % space between footer and bottom of body
  \setlength{\textwidth}{16.51cm} % width of the body of the text
  \addtolength{\textwidth}{0cm}
  \setlength{\oddsidemargin}{-0.0cm} % 1.25" margin on the left for odd pages
  \setlength{\evensidemargin}{-0.0cm} % 1.25"  margin on the right for even pages
\else
  % Set up page layout.
  \setlength{\textheight}{25.0cm} % Height of the main body of the text
  \addtolength{\textheight}{0cm} 
  \setlength{\topmargin}{-2.8cm} % 0.7" margin on top of page
  %\addtolength{\topmargin}{-\paperheight} 
  \setlength{\headsep}{.5in}  % space between header and top of body
  \addtolength{\headsep}{-\headheight} % See The LaTeX Companion, p 85
  \setlength{\footskip}{.5in}  % space between footer and bottom of body
  \setlength{\textwidth}{17.8cm} % width of the body of the text
  \addtolength{\textwidth}{0cm}
  \if@twoside
    \setlength{\oddsidemargin}{-0.7cm} % 1.25" margin on the left for odd pages
    \setlength{\evensidemargin}{-0.7cm} % 1.25"  margin on the right for even pages
  \else
    \setlength{\oddsidemargin}{-0.7cm} % 1.25" margin on the left for odd pages
    \setlength{\evensidemargin}{-0.7cm} % 1.25"  margin on the right for even pages
  \fi
\fi

\setlength{\columnsep}{0.85cm} % 1.25"  margin on the right for even pages

% Marginal notes
\setlength{\marginparwidth}{0in} % width of marginal notes
\setlength{\marginparsep}{0in} % space between marginal notes and text

% Make each page fill up the entire page. comment this out if you
% prefer.
%\flushbottom


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% FONT SIZE
%%%%%%%%%%%%%%%%
%\renewcommand\normalsize{%
%\scalefont{0.94}} % keep normalsize to 100% of its value or the math fonts resizing won't be effective
\if@ninepoint
\renewcommand\normalsize{%
   \@setfontsize\normalsize\@ixpt\@xipt
   \abovedisplayskip 9\p@ \@plus2\p@ \@minus4\p@
   \abovedisplayshortskip \z@ \@plus3\p@
   \belowdisplayshortskip 6\p@ \@plus3\p@ \@minus3\p@
   \belowdisplayskip \abovedisplayskip
   \let\@listi\@listI}
\fi
\normalsize
\linespread{0.95}
\if@submit
\linespread{1.3}
\fi
\renewcommand\small{\normalsize\scalefont{0.93}}
\renewcommand\footnotesize{\normalsize\scalefont{0.9}}
\renewcommand\scriptsize{\normalsize\scalefont{0.9}}
\renewcommand\tiny{\normalsize\scalefont{0.86}}
\renewcommand\large{\normalsize\scalefont{1.1}}
\renewcommand\Large{\normalsize\scalefont{1.15}}
\renewcommand\LARGE{\normalsize\scalefont{1.4}}
\renewcommand\huge{\normalsize\scalefont{1.7}}
\renewcommand\Huge{\normalsize\scalefont{2.0}}

%\newcommand{\fontsizefigure}{\normalsize\scalefont{0.92}}
%\newcommand{\fontsizetable}{\normalsize\scalefont{0.92}}
\newcommand{\fontsizefigure}{\small}
\newcommand{\fontsizetable}{\small}
\newcommand{\fontsizecaption}{\small}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Bibliography


\renewenvironment{thebibliography}[1]
     {
      \if@acknowledgments
        \section*{Acknowledgments}
        \bgroup
          \theacknowledgments
        \egroup
      \fi
      \if@acknowledgment
        \section*{Acknowledgment}
        \bgroup
          \theacknowledgment
        \egroup
      \fi
     \section*{\refname}%
      \@mkboth{\MakeUppercase\refname}{\MakeUppercase\refname}%
      \list{\@biblabel{\@arabic\c@enumiv}}%
           {\settowidth\labelwidth{\@biblabel{#1}}%
            \leftmargin\labelwidth
            \advance\leftmargin\labelsep
            \setlength{\itemsep}{-\smallskipamount}%
            \@openbib@code
            \usecounter{enumiv}%
            \let\p@enumiv\@empty
            \renewcommand\theenumiv{\@arabic\c@enumiv}\footnotesize}%
      \sloppy
      \clubpenalty4000
      \@clubpenalty \clubpenalty
      \widowpenalty4000%
      \sfcode`\.\@m}
     {\def\@noitemerr
       {\@latex@warning{Empty `thebibliography' environment}}%
      \endlist}


\endinput
%%
%% End of file `aiaa.cls'.
