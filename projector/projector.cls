%% 
%% Copyright 2007, 2008, 2009 Victor Shoup.
%% This program is free software: you can redistribute it and/or modify
%% it under the terms of the GNU General Public License as published by
%% the Free Software Foundation, either version 3 of the License, or
%% (at your option) any later version.

%% Version 2.4

\ProvidesClass{projector}

\LoadClass{article}

\RequirePackage{amsmath}
\RequirePackage{latexsym}
\RequirePackage{url}

\RequirePackage{calc}
\RequirePackage{ifthen}

\RequirePackage[x11names,svgnames]{xcolor}
\RequirePackage{colortbl}
\RequirePackage{graphicx}

\RequirePackage{fancyhdr}
\RequirePackage[pdftex,pdffitwindow,pdfborder={0 0 0}]{hyperref}

\RequirePackage[nomessages]{fp}

\RequirePackage{keyval}
\newif\if@mtpro
\@mtprofalse
\if@compatibility\else
\DeclareOption{mtpro}{\@mtprotrue}
\fi


\ProcessOptions

%%%%% some basics

\newcommand\PROJ@ifeq[4]{%
   \def\PROJ@ONE{#1}\def\PROJ@TWO{#2}%
   \ifx\PROJ@ONE\PROJ@TWO#3\else#4\fi%
}

\newcommand\PROJ@ifundefined[3]{%
   \ifcsname#1\endcsname#3\else#2\fi%
}

\newcommand\PROJ@error[1]{\GenericError{}{#1}{}{}}

\newcommand\PROJ@robust[1]{%
   \ifdefined#1%
      \PROJ@error{\noexpand#1 already defined}%
   \fi%
   \DeclareRobustCommand#1%
}

%\renewcommand\PROJ@robust[1]{\newcommand#1}



%%%%%% style parameters

%% \paramval{name} -- value of parameter

\newcommand\paramval[1]{%
   \PROJ@ifundefined{PROJ@param@@#1}{%
      \PROJ@error{unknown style parameter `\string #1'}%
   }{%
      \csname PROJ@param@@#1\endcsname%
   }%
}


\newcommand\PROJ@defineparam[3]{%
   \ifthenelse{\equal{#1}{def}}{%
      \expandafter\def\csname PROJ@param@@#2\endcsname{#3}%
   }{%
      \ifthenelse{\equal{#1}{edef}}{%
         \expandafter\edef\csname PROJ@param@@#2\endcsname{#3}%
      }{%
         \PROJ@error{unknown definition style `\string #1'}%
      }%
   }%
}

%% \newparam[defstyle]{name}{initval}{hook} 

\newcommand\newparam[4][def]{%
   \PROJ@ifundefined{PROJ@param@@#2}{%
      \expandafter\def\csname PROJ@param@def@@#2\endcsname{#1}%
      \expandafter\def\csname PROJ@param@hook@@#2\endcsname##1{#4}%
      \PROJ@defineparam{#1}{#2}{#3}%
      % hack: init vale = true/false => treat as a flag
      \PROJ@ifeq{#3}{true}{%
         \define@key{PROJ@param}{#2}[true]{\setparam{#2}{##1}}%
      }{%
      \PROJ@ifeq{#3}{false}{%
         \define@key{PROJ@param}{#2}[true]{\setparam{#2}{##1}}%
      }{%
         \define@key{PROJ@param}{#2}{\setparam{#2}{##1}}%
      }}%
   }{%
      \PROJ@error{style parameter `\string #2' already defined}%
   }%
}

\newcommand{\style}[1]{\setkeys{PROJ@param}{#1}}

%% \setparam{name}{value} -- sets name to value and executes associated hook

\newcommand\setparam[2]{%
   \PROJ@ifundefined{PROJ@param@@#1}{%
      \PROJ@error{unknown style parameter `\string #1'}%
   }{%
      \PROJ@defineparam{\csname PROJ@param@def@@#1\endcsname}{#1}{#2}%
      \csname PROJ@param@hook@@#1\endcsname{#2}%
   }%
}

%%% \scaleparam{name}{real number} -- scale numerical parameter

\newcounter{PROJ@tempctr}

\newcommand\scaleparam[2]{%
   \FPmul{\PROJ@tmpparam}{\paramval{#1}}{#2}%
   \FPclip{\PROJ@tmpparam}{\PROJ@tmpparam}%
   \setparam{#1}{\PROJ@tmpparam}%
}


\newcommand\PROJ@fracscale[4]{%
   \FPdiv{\PROJ@scalefactor}{#3}{#4}%
   \setlength{#1}{#2*\real{\PROJ@scalefactor}}%
}


\newcommand\PROJ@scale[3]{\PROJ@fracscale{#1}{#2}{\paramval{#3}}{100}}
\newcommand\PROJ@dscale[4]{\PROJ@scale{#1}{#2}{#3}\PROJ@scale{#1}{#1}{#4}}



%% \dimdiv{\foo}{3pt}{4pt} will assign the string 0.75 to \foo

\newlength{\PROJ@dimrat@numl}
\newlength{\PROJ@dimrat@denl}
\newcounter{PROJ@dimrat@num}
\newcounter{PROJ@dimrat@den}

\newcommand\dimdiv[3]{%
   \setlength{\PROJ@dimrat@numl}{#2}%
   \setlength{\PROJ@dimrat@denl}{#3}%
   \setcounter{PROJ@dimrat@num}{\PROJ@dimrat@numl}%
   \setcounter{PROJ@dimrat@den}{\PROJ@dimrat@denl}%
   \FPdiv{#1}{\thePROJ@dimrat@num}{\thePROJ@dimrat@den}%
   \FPclip{#1}{#1}%
}

%%%%%%%


\newparam[edef]{slide.margin.side}{100}{\PROJ@RefreshLayout}
\newparam[edef]{slide.margin.bot}{100}{\PROJ@RefreshLayout}
\newparam[edef]{slide.margin.top}{100}{\PROJ@RefreshLayout}
\newparam[edef]{slide.margin}{100}{\PROJ@RefreshLayout}
\newparam[edef]{slide.size}{100}{\PROJ@RefreshLayout}
\newparam[edef]{slide.aspect.ratio}{4:3}{\PROJ@RefreshLayout}
\newparam[edef]{foot.margin.side}{100}{\PROJ@RefreshLayout}
\newparam[edef]{foot.margin.bot}{100}{\PROJ@RefreshLayout}
\newparam[edef]{foot.margin.top}{100}{\PROJ@RefreshLayout}
\newparam[edef]{foot.margin}{100}{\PROJ@RefreshLayout}




\newlength{\PROJ@pheight}
\newlength{\PROJ@pwidth}

\newlength{\smargin}
\newlength{\tmargin}
\newlength{\bmargin}
\newlength{\fsmargin}
\newlength{\ftmargin}
\newlength{\fbmargin}
\newlength{\PROJ@fbmargin}
\newlength{\footwidth}

\newlength{\PROJ@targetlen}


\pagestyle{fancy}
\lhead{\PROJ@LeftHeadStuff}
\chead{\PROJ@CenterHeadStuff}
\rhead{\PROJ@RightHeadStuff}
\lfoot{\PROJ@LeftFootStuff}
\cfoot{\PROJ@CenterFootStuff}
\rfoot{\PROJ@RightFootStuff}
\renewcommand{\headrule}{}
\renewcommand{\footrule}{}

\def\PROJ@parseHVaux#1:#2\@{%
   \def\PROJ@HH{#1}%
   \def\PROJ@VV{#2}%
}

\def\PROJ@parseHV{%
   \edef\PROJ@aspect@ratio{\paramval{slide.aspect.ratio}}%
   \expandafter\PROJ@parseHVaux\PROJ@aspect@ratio\@%
}

\newcommand\PROJ@RefreshLayout{%
   \PROJ@dscale{\smargin}{10pt}{slide.margin}{slide.margin.side}%
   \PROJ@dscale{\tmargin}{10pt}{slide.margin}{slide.margin.top}%
   \PROJ@dscale{\bmargin}{10pt}{slide.margin}{slide.margin.bot}%
   \PROJ@dscale{\fsmargin}{2pt}{foot.margin}{foot.margin.side}%
   \PROJ@dscale{\ftmargin}{2pt}{foot.margin}{foot.margin.top}%
   \PROJ@dscale{\fbmargin}{2pt}{foot.margin}{foot.margin.bot}%
   \PROJ@scale{\PROJ@pwidth}{272pt}{slide.size}%
   \PROJ@parseHV%
   \PROJ@fracscale{\PROJ@pheight}{\PROJ@pwidth}{\PROJ@VV}{\PROJ@HH}%
   \setlength{\hoffset}{-1in}%
   \setlength{\voffset}{-1in}%
   \setlength{\oddsidemargin}{\smargin}%
   \setlength{\evensidemargin}{\smargin}%
   \setlength{\headsep}{0pt}%
   \setlength{\headheight}{12pt}%
   \setlength{\topmargin}{\tmargin-\headheight}%
   \setlength{\paperwidth}{\PROJ@pwidth}%
   \setlength{\paperheight}{\PROJ@pheight}%
   \setlength{\pdfpagewidth}{\paperwidth}%
   \setlength{\pdfpageheight}{\paperheight}%
   \setlength{\textwidth}{\paperwidth-2\smargin}%
   \setlength{\footwidth}{\paperwidth-2\fsmargin}
   \setlength{\textheight}{\paperheight-\tmargin-\bmargin}%
   \setlength{\PROJ@fbmargin}{\fbmargin}%
   \ifthenelse{\lengthtest{\bmargin<8.5pt}}{%
      %% HACK: necessary to keep fancyhdr happy%
      \setlength{\footskip}{8.5pt}%
      \addtolength{\PROJ@fbmargin}{8.5pt-\bmargin}%
   }{%
      \setlength{\footskip}{\bmargin}%
   }%
   \setlength{\headwidth}{\paperwidth}%
   \setlength{\PROJ@targetlen}{\smargin}%
   \ifthenelse{\lengthtest{\PROJ@targetlen<30pt}}{%
      \setlength{\PROJ@targetlen}{30pt}%
   }{%
   }%
}

\PROJ@RefreshLayout



%%%%%%%%%%%%%%%%%% basic layout


\newcommand\fixparbox{\PROJ@setskips\raggedright}

%% HACK: restores vertical spacing params and ragged right within
%% a minipage

\def\@minipagerestore{\fixparbox}


\raggedright

\setlength{\vfuzz}{\maxdimen}
\vbadness=10000

\setlength{\hfuzz}{\maxdimen}
\hbadness=10000

\newparam[edef]{list.margin}{100}{\PROJ@refresh@listmargin}
\newparam[edef]{list.label.margin}{100}{\PROJ@refresh@listmargin}

\newcommand\PROJ@refresh@listmargin{%
   \PROJ@scale{\leftmargini}{14pt}{list.margin}%
   \PROJ@scale{\labelsep}{4pt}{list.label.margin}%
}

\PROJ@refresh@listmargin

\def\@listii{%
    \setlength{\parsep}{\PROJ@skipA}%
}

\def\@listiii{}

\def\@listiv{}

\def\@listv{}

\def\@listvi{}


\renewcommand\normalsize{%
   \fontsize{10}{12}\selectfont%
   \def\PROJ@setskips{%
      \setlength{\parskip}{\PROJ@skipB}%
      \setlength{\smallskipamount}{\PROJ@skipA}%
      \setlength{\medskipamount}{\PROJ@skipB}%
      \setlength{\bigskipamount}{\PROJ@skipC}%
      \setlength{\abovedisplayskip}{\PROJ@skipA}%
      \setlength{\abovedisplayshortskip}{\PROJ@skipA}%
      \setlength{\belowdisplayshortskip}{\PROJ@skipA}%
      \setlength{\belowdisplayskip}{\PROJ@skipA}%
   }%
   \PROJ@setskips%
   \def\@listi{%
    \setlength{\leftmargin}{\leftmargini}%
    \setlength{\partopsep}{0pt}%
    \setlength{\topsep}{0pt}%
    \setlength{\parsep}{\PROJ@skipB}%
    \setlength{\itemsep}{0pt}%
   }%
}



\renewcommand\small{%
   \fontsize{9}{11}\selectfont%
   \def\PROJ@setskips{%
      \setlength{\parskip}{\PROJ@skipA}%
      \setlength{\smallskipamount}{\PROJ@skipA}%
      \setlength{\medskipamount}{\PROJ@skipA}%
      \setlength{\bigskipamount}{\PROJ@skipB}%
      \setlength{\abovedisplayskip}{\PROJ@skipA}%
      \setlength{\abovedisplayshortskip}{\PROJ@skipA}%
      \setlength{\belowdisplayshortskip}{\PROJ@skipA}%
      \setlength{\belowdisplayskip}{\PROJ@skipA}%
   }%
   \PROJ@setskips%
   \def\@listi{%
    \setlength{\leftmargin}{\leftmargini}%
    \setlength{\partopsep}{0pt}%
    \setlength{\topsep}{0pt}%
    \setlength{\parsep}{\PROJ@skipA}%
    \setlength{\itemsep}{0pt}%
   }%
}


\renewcommand\footnotesize{%
   \fontsize{8}{9.5}\selectfont%
   \def\PROJ@setskips{%
      \setlength{\parskip}{\PROJ@skipA}%
      \setlength{\smallskipamount}{\PROJ@skipA}%
      \setlength{\medskipamount}{\PROJ@skipA}%
      \setlength{\bigskipamount}{\PROJ@skipA}%
      \setlength{\abovedisplayskip}{\PROJ@skipA}%
      \setlength{\abovedisplayshortskip}{\PROJ@skipA}%
      \setlength{\belowdisplayshortskip}{\PROJ@skipA}%
      \setlength{\belowdisplayskip}{\PROJ@skipA}%
   }%
   \PROJ@setskips%
   \def\@listi{%
    \setlength{\leftmargin}{\leftmargini}%
    \setlength{\partopsep}{0pt}%
    \setlength{\topsep}{0pt}%
    \setlength{\parsep}{\PROJ@skipA}%
    \setlength{\itemsep}{0pt}%
   }%
}


\newlength{\PROJ@skipA}
\newlength{\PROJ@skipB}
\newlength{\PROJ@skipC}

\newparam[edef]{vskip}{100}{\PROJ@RefreshVskip}

\newboolean{PROJ@squeezing}
\setboolean{PROJ@squeezing}{false}


\newcommand\PROJ@RefreshVskip{%
   \PROJ@scale{\PROJ@skipA}{3pt}{vskip}%
   \PROJ@scale{\PROJ@skipB}{5pt}{vskip}%
   \PROJ@scale{\PROJ@skipC}{7pt}{vskip}%
   \ifthenelse{\boolean{PROJ@squeezing}}{%
      \addtolength{\PROJ@skipA}{0pt minus \PROJ@skipA}%
      \addtolength{\PROJ@skipB}{0pt minus \PROJ@skipB}%
      \addtolength{\PROJ@skipC}{0pt minus \PROJ@skipC}%
   }{}%
   \PROJ@setskips%
}

\newcommand{\squeeze}{%
   \setboolean{PROJ@squeezing}{true}%
   \PROJ@RefreshVskip%
}


\def\PROJ@setskips{}
\PROJ@RefreshVskip
\normalsize
\@listi



%%%%%%%%%%%%%%%%%%%%%


\newcommand\PROJ@firstarg[2]{#1}
\newcommand\PROJ@secondarg[2]{#2}

\newboolean{overlaysoffP}
\setboolean{overlaysoffP}{false}
\newcommand\ifoverlaysoff{\PROJ@secondarg}

\newcommand\overlaysoff{%
   \renewcommand\ifoverlaysoff{\PROJ@firstarg}%
   \setboolean{overlaysoffP}{true}%
}



\def\PROJ@not@hidden{0}

\newparam[edef]{hidden}{100}{%
   \FPsub{\PROJ@not@hidden}{100}{#1}%
   \FPmin{\PROJ@not@hidden}{\PROJ@not@hidden}{100}%
   \FPmax{\PROJ@not@hidden}{\PROJ@not@hidden}{0}%
   \FPclip{\PROJ@not@hidden}{\PROJ@not@hidden}%
}



\colorlet{background}{white}
\colorlet{PROJ@fadebg}{white}
\colorlet{PROJ@topbg}{white}
\pagecolor{white}

\colorlet{foreground}{black}
\color{black}

\newboolean{visibleP}
\setboolean{visibleP}{true}

\newcommand{\StackBackground}[1]{%
   \colorlet{PROJ@topbg}{\visfiltered{#1}}%
   \ifvisible{\colorlet{background}{PROJ@topbg}}{}%
}

\def\PROJ@not@fade{100}

\newcommand\fadeamount{0}

\PROJ@robust\fade[1]{%
   \edef\fadeamount{#1}%
   \FPsub{\PROJ@not@fade}{100}{\fadeamount}%
   \FPmin{\PROJ@not@fade}{\PROJ@not@fade}{100}%
   \FPmax{\PROJ@not@fade}{\PROJ@not@fade}{0}%
   \FPclip{\PROJ@not@fade}{\PROJ@not@fade}%
   \colorlet{PROJ@fadebg}{PROJ@topbg}%
   \color{\filtered{foreground}}%
}

\newcommand\visfiltered[1]{#1!\PROJ@not@fade!PROJ@fadebg}

\newcommand\filtered[1]{%
   \ifvisible{\visfiltered{#1}}%
             {\visfiltered{#1}!\PROJ@not@hidden!background}%
}


\newcommand\ifvisible{\PROJ@firstarg}


\newcommand\bgcolor[1]{%
   \colorlet{background}{#1}%
   \colorlet{PROJ@fadebg}{background}%
   \colorlet{PROJ@topbg}{background}%
   \pagecolor{background}%
}

%%%%%%%%%%%%%%%%

\PROJ@robust\record[1]{%
   \ifoverlaysoff{}{%
      \expandafter\xdef\csname PROJ@refresh@tag@@#1\endcsname{\ifvisible{true}{false}}%
   }%
}

\PROJ@robust\refresh[1][@]{%
   \ifoverlaysoff{}{%
      \PROJ@ifundefined{PROJ@refresh@tag@@#1}{%
         \PROJ@error{unknown record tag `\string #1'}%
      }{%
         \ifthenelse{\equal{\csname PROJ@refresh@tag@@#1\endcsname}{true}}{%
            \visible%
         }{%
            \invisible%
         }%
      }%
   }%
}





%%%%%%%%%%%%%%%%

\newcounter{PROJ@overlayVal}
\newcounter{overlaynum}
\newcounter{PROJ@overlayMax}
\newcounter{pausectr}

\newcommand\PROJ@updateMaxOverlays[1]{%
   \ifthenelse{#1 > \value{PROJ@overlayMax}}{\setcounter{PROJ@overlayMax}{#1}}{}%
}


\newcommand{\PROJ@cond}[5]{%
   \ifoverlaysoff{#3}{%
      {\def\p{\value{pausectr}}\setcounter{PROJ@overlayVal}{#1}}%
      \PROJ@updateMaxOverlays{\value{PROJ@overlayVal}}%
      \ifthenelse{#4 \value{overlaynum} #5 \value{PROJ@overlayVal}}{%
         #3%
      }{%
         #2%
      }%
   }%
}

\newcommand\PROJ@condFrom[3]{\PROJ@cond{#1}{#2}{#3}{}{<}}
\newcommand\PROJ@condTo[3]{\PROJ@cond{#1}{#2}{#3}{}{>}}
\newcommand\PROJ@condAt[3]{\PROJ@cond{#1}{#2}{#3}{\NOT}{=}}

%% NOTE: the inclusion of \color{.} prevents "jitters", since the
%% \color command can sometimes affect layout

\newcommand\PROJ@execFrom[2]{\PROJ@condFrom{#1}{#2}{\color{.}}}
\newcommand\PROJ@execTo[2]{\PROJ@condTo{#1}{#2}{\color{.}}}
\newcommand\PROJ@execAt[2]{\PROJ@condAt{#1}{#2}{\color{.}}}

\PROJ@robust\invisible{%
   \ifoverlaysoff{%
      \color{.}%
   }{%
     \renewcommand\ifvisible{\PROJ@secondarg}%
     \setboolean{visibleP}{false}%
     \record{@}%
     \color{\filtered{foreground}}%
   }%
}

\PROJ@robust\visible{%
   \ifoverlaysoff{%
      \color{.}%
   }{%
     \renewcommand\ifvisible{\PROJ@firstarg}%
     \setboolean{visibleP}{true}%
     \record{@}%
     \color{\filtered{foreground}}%
   }%
}




\PROJ@robust\fgcolor[1]{\colorlet{foreground}{#1}\color{\filtered{foreground}}}


\PROJ@robust\hideFrom[1]{\PROJ@execFrom{#1}{\invisible}}
\PROJ@robust\hideTo[1]{\PROJ@execTo{#1}{\invisible}}
\PROJ@robust\hideAt[1]{\PROJ@execAt{#1}{\invisible}}


\PROJ@robust\showFrom[1]{\PROJ@execFrom{#1}{\visible}}
\PROJ@robust\showTo[1]{\PROJ@execTo{#1}{\visible}}
\PROJ@robust\showAt[1]{\PROJ@execAt{#1}{\visible}}


\PROJ@robust\ShowFrom[1]{\invisible\showFrom{#1}}
\PROJ@robust\ShowTo[1]{\invisible\showTo{#1}}
\PROJ@robust\ShowAt[1]{\invisible\showAt{#1}}

\PROJ@robust\HideFrom[1]{\visible\hideFrom{#1}}
\PROJ@robust\HideTo[1]{\visible\hideTo{#1}}
\PROJ@robust\HideAt[1]{\visible\hideAt{#1}}

\PROJ@robust\colorFrom[2]{\PROJ@execFrom{#1}{\fgcolor{#2}}}
\PROJ@robust\colorTo[2]{\PROJ@execTo{#1}{\fgcolor{#2}}}
\PROJ@robust\colorAt[2]{\PROJ@execAt{#1}{\fgcolor{#2}}}

\PROJ@robust\alert{\fgcolor{\paramval{alert.color}}}

\PROJ@robust\alertFrom[1]{\colorFrom{#1}{\paramval{alert.color}}}
\PROJ@robust\alertTo[1]{\colorTo{#1}{\paramval{alert.color}}}
\PROJ@robust\alertAt[1]{\colorAt{#1}{\paramval{alert.color}}}

\newparam[edef]{alert.color}{blue!80!black}{}


\PROJ@robust\fadeFrom[2]{\PROJ@execFrom{#1}{\fade{#2}}}
\PROJ@robust\fadeTo[2]{\PROJ@execTo{#1}{\fade{#2}}}
\PROJ@robust\fadeAt[2]{\PROJ@execAt{#1}{\fade{#2}}}


\newcommand\PauseStep[1][1]{%
   \ifoverlaysoff{}{\addtocounter{pausectr}{#1}}%
}

\newcommand\PauseSet[1]{%
   \ifoverlaysoff{}{\setcounter{pausectr}{#1}}%
}

\PROJ@robust{\pause}[1][1]{\PauseStep[#1]\ShowFrom{\p}}
\newcommand{\pitem}{\pause\item}


%%%%%%%%%%%%




\newcommand\lastslide{%
   \pageref{PROJ@lastslide}%
}

%%%%%%%%%%%

\newparam{foot.text.top.left}{}{}
\newparam{foot.text.top.center}{}{}
\newparam{foot.text.top.right}{}{}
\newparam{foot.text.bot.left}{}{}
\newparam{foot.text.bot.center}{}{}
\newparam{foot.text.bot.right}{}{}

\newparam{foot.format}{}{}

\newlength{\PROJ@headtmp}

\newcommand\PROJ@TypeSetHead[1]{{%
   \settoheight{\PROJ@headtmp}{\overlaysoff\tiny\paramval{foot.format}X}%
   \raisebox{\tmargin-\ftmargin-\PROJ@headtmp}[0pt][0pt]{%
      \overlaysoff%
      \tiny%
      \paramval{foot.format}%
      #1%
}}}

\newcommand\PROJ@TypeSetFoot[1]{{%
   \raisebox{\PROJ@fbmargin}[0pt][0pt]{%
      \overlaysoff%
      \tiny%
      \paramval{foot.format}%
      #1%
      \vspace{0pt}%
}}}



\newcommand\PROJ@RightFootStuff{%
   \ifthenelse{\NOT \value{overlaynum} < \value{PROJ@overlayMax}}{%
       \hyperlink{ArrowAnchor\arabic{PROJ@nextSlideNum}}{\rule{0pt}{\footskip}\hspace*{\PROJ@targetlen}}%
    }{%
       \hyperlink{ArrowAnchor\arabic{slidenum}}{\rule{0pt}{\footskip}\hspace*{\PROJ@targetlen}}%
    }%
   \hspace*{\smargin}%
   \makebox[0pt][r]{\PROJ@TypeSetFoot{\paramval{foot.text.bot.right}}%
   \hspace*{\fsmargin}\hspace*{\smargin}}%
}

\newcommand\PROJ@RightHeadStuff{%
   \makebox[0pt][r]{\PROJ@TypeSetHead{\paramval{foot.text.top.right}}%
   \hspace*{\fsmargin}\hspace*{\smargin}}%
}

\newcommand\PROJ@anchor[1]{%
   \ifthenelse{\NOT \value{overlaynum} < \value{PROJ@overlayMax}}{%
      \hypertarget{#1}{}%
   }{}%
}

\newcommand\PROJ@LeftFootStuff{%
   \PROJ@putboxhook%
   \hspace*{-\smargin}%
   \hyperlink{ArrowAnchor\arabic{PROJ@prevSlideNum}}{\rule{0pt}{\footskip}%
   \hspace*{\PROJ@targetlen}}%
   \PROJ@anchor{ArrowAnchor\arabic{slidenum}}%
   \PROJ@ExecFooter%
   \hspace*{\fsmargin}%
   \hspace*{-\PROJ@targetlen}\PROJ@TypeSetFoot{\paramval{foot.text.bot.left}}%
}

\newcommand\PROJ@LeftHeadStuff{%
   \hspace*{-\smargin}\hspace*{\fsmargin}%
   \PROJ@TypeSetHead{\paramval{foot.text.top.left}}%
}

\newcommand\PROJ@CenterFootStuff{%
   \hspace*{-2\smargin}\PROJ@TypeSetFoot{\paramval{foot.text.bot.center}}%
}

\newcommand\PROJ@CenterHeadStuff{%
   \hspace*{-2\smargin}\PROJ@TypeSetHead{\paramval{foot.text.top.center}}%
}



\newcounter{slidenum}
\newcounter{PROJ@prevSlideNum}
\newcounter{PROJ@nextSlideNum}

\setcounter{slidenum}{0}
\setcounter{PROJ@prevSlideNum}{-1}
\setcounter{PROJ@nextSlideNum}{1}



%% HACK: these are used to fix up funny issues...
%% The "top" code gets rid of an extra parskip that arises
%% if the slide starts with a color or vspace command.

\newcommand\PROJ@FixUpTop{\vspace{-\parskip}}

%%%%%%%%

\newcommand\PROJ@append@aux[3]{\gdef#2{#1#3}}
\newcommand\PROJ@append[2]{\expandafter\PROJ@append@aux\expandafter{#1}{#1}{#2}}

\newcommand\AtBeginSlide{\PROJ@append\PROJ@BeginSlideList}
\newcommand\PROJ@ExecBeginSlide{\PROJ@BeginSlideList}
\let\PROJ@BeginSlideList\@empty

\newcommand\AtBeginOverlay{\PROJ@append\PROJ@BeginOverlayList}
\newcommand\PROJ@ExecBeginOverlay{\PROJ@BeginOverlayList}
\let\PROJ@BeginOverlayList\@empty

\newcommand\AtEndSlide{\PROJ@append\PROJ@EndSlideList}
\newcommand\PROJ@ExecEndSlide{\PROJ@EndSlideList}
\let\PROJ@EndSlideList\@empty

\newcommand\AtEndOverlay{\PROJ@append\PROJ@EndOverlayList}
\newcommand\PROJ@ExecEndOverlay{{\PROJ@EndOverlayList}}
\let\PROJ@EndOverlayList\@empty

\newcommand\PROJ@AtFooter{\PROJ@append\PROJ@FooterList}
\newcommand\PROJ@ExecFooter{\PROJ@FooterList}
\newcommand\PROJ@ClearFooter{\global\let\PROJ@FooterList\@empty}
\PROJ@ClearFooter


\newcommand\ResetCounterAtOverlay[1]{%
  \newcounter{PROJ@saved@@#1}%
  \AtBeginSlide{\setcounter{PROJ@saved@@#1}{\value{#1}}}%
  \AtBeginOverlay{\setcounter{#1}{\value{PROJ@saved@@#1}}}%
}

\ResetCounterAtOverlay{equation}

\newcommand\PROJ@ProcessSlide[1]{%
   \bgroup%
   \pagecolor{background}%
   \stepcounter{slidenum}%
   \stepcounter{PROJ@prevSlideNum}%
   \stepcounter{PROJ@nextSlideNum}%
   \PROJ@ExecBeginSlide%
   \setcounter{PROJ@overlayMax}{1}%
   \setcounter{overlaynum}{0}%
%
   \whiledo{\value{overlaynum} < \value{PROJ@overlayMax}}{%
      %
      \setcounter{PROJ@overlayMax}{1}%
      \stepcounter{overlaynum}%
      \setcounter{pausectr}{1}%
      \setcounter{PROJ@putbox}{0}%
      \record{@}%
      \PROJ@ExecBeginOverlay%
      \PROJ@ClearFooter%
      \ifthenelse{\value{overlaynum} > 1}{%
         %% HACK: supresses "multiply defined labled" warnings
         \def\label##1{}%
         \def\label@in@display##1{}%
      }{}%
%
      \vbox to \textheight{\PROJ@FixUpTop#1}%
%
      \PROJ@ExecEndOverlay%
      \newpage%
   }%
   \PROJ@ExecEndSlide%
   \egroup%
}

%%%%%%%%%%%%%%%%%%%%%% an implementation of "collect body"

% pres@collect@body (from amsmath.sty)  
%   Taken from talk.cls
%   This is a modified version of collect@body, from amsmath.sty,
%   which fixes a limitation in the original (not allowing \par tokens
%   in the argument)
%

\long\def\PROJ@addto@envbody#1{\global\@envbody\@xp{\the\@envbody#1}}
\long\def\PROJ@collect@body#1{%
  \@envbody{\@xp#1\@xp{\the\@envbody}}%
  \edef\process@envbody{\the\@envbody\@nx\end{\@currenvir}}%
  \@envbody\@emptytoks \def\begin@stack{b}%
  \begingroup
  \@xp\let\csname\@currenvir\endcsname\PROJ@collect@@body
  \edef\process@envbody{\@xp\@nx\csname\@currenvir\endcsname}%
  \process@envbody
}
\long\def\PROJ@push@begins#1\begin#2{%
  \ifx\end#2\else b\@xp\PROJ@push@begins\fi
}
\long\def\PROJ@collect@@body#1\end#2{%
  \edef\begin@stack{\PROJ@push@begins#1\begin\end \@xp\@gobble\begin@stack}%
  \ifx\@empty\begin@stack
    \endgroup
    \@checkend{#2}%
    \PROJ@addto@envbody{#1}%
  \else
    \PROJ@addto@envbody{#1\end{#2}}%
  \fi
  \process@envbody % A little tricky! Note the grouping
}

%%% The basic slide environment: is defined using collect@body

\newcounter{PROJ@splus}

\newenvironment{slide}{%
   \setcounter{PROJ@splus}{\value{slidenum}}%
   \stepcounter{PROJ@splus}%
   \typeout{** slide \thePROJ@splus \@currenvline}%
   \PROJ@collect@body\PROJ@ProcessSlide%
}{}




%%% Implementation of slide* ...a real pain
%%% The body is written to a file, and then the file is read as
%%% many times as needed.  
%%% Any chars after "\begin{slide*}" on the same line are also
%%% written to the file.
%%% "\end{slide*}" must appear on a line by itself, possibly
%%% with leading and trailing blanks/tabs
%%% Tabs are preserved.

\begingroup
\catcode`\!=0
\catcode`\[=1
\catcode`\]=2
\let\do\@makeother\dospecials
!xdef!PROJ@TEST[\end{slide*}]
!xdef!PROJ@BLANK[ ]
!endgroup

\begingroup
\catcode`\^^I=12
\xdef\PROJ@TAB{^^I}
\endgroup


\def\PROJ@tail@strip#1#2#3#4\NIL{%
   \def\PROJ@ONE{#3}%
   \ifx\PROJ@ONE\PROJ@BLANK%
      \PROJ@tail@strip@aux{#1}{#2#3}{#4}%
   \else\ifx\PROJ@ONE\PROJ@TAB%
      \PROJ@tail@strip@aux{#1}{#2#3}{#4}%
   \else%
      \PROJ@tail@strip@aux{#1#2#3}{}{#4}%
   \fi\fi%
}

\def\PROJ@tail@strip@aux#1#2#3{%
   \PROJ@ifeq{#3}{}{%
      \gdef\PROJ@stripped{#1}%
   }{%
      \PROJ@tail@strip{#1}{#2}#3\NIL%
   }%
}

\def\PROJ@lead@strip#1#2\NIL{%
   \def\PROJ@ONE{#1}%
   \ifx\PROJ@ONE\PROJ@BLANK%
      \PROJ@lead@strip@aux{#2}%
   \else\ifx\PROJ@ONE\PROJ@TAB%
      \PROJ@lead@strip@aux{#2}%
   \else%
      \PROJ@tail@strip@aux{#1}{}{#2}%
   \fi\fi%
}

\def\PROJ@lead@strip@aux#1{%
   \PROJ@ifeq{#1}{}{%
      \gdef\PROJ@stripped{}%
   }{%
      \PROJ@lead@strip#1\NIL%
   }%
}

\def\PROJ@strip#1{\PROJ@lead@strip@aux{#1}}


\begingroup
\catcode`\^^M=\active
\gdef\PROJ@Scan#1^^M{%
  \PROJ@strip{#1}%
  \ifx\PROJ@stripped\@empty%
  \else%
     \immediate\write\PROJ@OutFile{#1}%
  \fi
  \PROJ@GetLine%
}
\gdef\PROJ@GetLine#1^^M{%
  \PROJ@strip{#1}%
  \ifx\PROJ@stripped\PROJ@TEST%
    \def\PROJ@next{\end{slide*}}%
  \else
    \immediate\write\PROJ@OutFile{#1}%
    \def\PROJ@next{\PROJ@GetLine}%
  \fi%
  \PROJ@next%
}
\endgroup

\newwrite\PROJ@OutFile
\def\PROJ@fname{\jobname.vrb}

\@namedef{slide*}{%
   \setcounter{PROJ@splus}{\value{slidenum}}%
   \stepcounter{PROJ@splus}%
   \typeout{** slide* \thePROJ@splus \@currenvline}%
   \begingroup%
   \immediate\openout\PROJ@OutFile\PROJ@fname%
   \let\do\@makeother\dospecials%
   \catcode`\^^M=\active%      
   \catcode`\^^I=12%      
   \PROJ@Scan%
}

\@namedef{endslide*}{%
   \immediate\closeout\PROJ@OutFile%
   \endgroup%
   \PROJ@ProcessSlide{\input{\jobname.vrb}}%
}


%%%%%% frame stuff



% xplainframe takes args:
%  1: bgcolor
%  2: horizonal overhang 
%  3: above overhang
%  4: below overhang
%  5: above skip
%  6: below skip

%% COMMENT: This was a real pain in the neck to get to work in such 
%% a way that we get a natural parskip around top and bottom, in addition
%% to the usual interlineskip, but without introducing any extra space at
%% the top or bottom of the slide. This seems to work...but why is it so
%% *@$#ing hard?

\newlength{\PROJ@frameaboveovh}
\newlength{\PROJ@framebelowovh}
\newlength{\PROJ@frameaboveskip}
\newlength{\PROJ@framebelowskip}

\newsavebox\PROJ@framebox

\newlength{\PROJ@frameH}
\newlength{\PROJ@frameD}
\newlength{\PROJ@frameT}
\newlength{\PROJ@frameX}

\newenvironment{xplainframe}[6]{%
   \colorlet{PROJ@framebgcolor}{#1}%
   \setlength{\tabcolsep}{#2}%
   \setlength{\PROJ@frameaboveovh}{#3}%
   \setlength{\PROJ@framebelowovh}{#4}%
   \setlength{\PROJ@frameaboveskip}{#5}%
   \setlength{\PROJ@framebelowskip}{#6}%
   \begin{lrbox}{\PROJ@framebox}%
   \begin{tabular}{l}%
   \rowcolor{\filtered{PROJ@framebgcolor}}%
   \begin{minipage}{\textwidth}%
   \PROJ@FixUpTop%
   \StackBackground{PROJ@framebgcolor}%
   \vspace{\PROJ@frameaboveovh}%
}{%
   \par%
   \vspace{\PROJ@framebelowovh}%
   \end{minipage}%
   \end{tabular}%
   \end{lrbox}%
   \par%
   \setlength{\PROJ@frameH}{\ht\PROJ@framebox}%
   \setlength{\PROJ@frameD}{\dp\PROJ@framebox}%
   \setlength{\PROJ@frameT}{\PROJ@frameH}%
   \addtolength{\PROJ@frameT}{\PROJ@frameD}%
   \settoheight{\PROJ@frameX}{X}%
   \bgroup\addtolength{\baselineskip}{\PROJ@frameT-\PROJ@frameX}%
   \vspace{\PROJ@frameaboveskip}%
   \hspace*{-\tabcolsep}%
   \ifthenelse{\equal{\paramval{highlight.shaded}}{true} \AND %
               \boolean{visibleP}}{%
      \def\PROJ@show@box{\PROJ@shadowbox}%
   }{%
      \def\PROJ@show@box{\usebox}%
   }%
   \raisebox{\PROJ@frameD}{\PROJ@show@box{\PROJ@framebox}}%
   \par%
   \egroup%
   \vspace{\PROJ@framebelowskip}%
}

% plainframe takes args:
%  1: bgcolor

\newenvironment{plainframe}[1]{%
   \begin{xplainframe}{#1}{3pt}{3pt}{3pt}{0pt}{0pt}%
}{%
   \end{xplainframe}%
}


% xtitledframe takes args:
%  1: title bgcolor
%  2: title text
%  3: body bgcolor
%  4: horizontal overhang
%  5: above overhang
%  6: below overhang
%  7: above skip
%  8: below skip


\newenvironment{xtitledframe}[8]{%
   \colorlet{PROJ@frametitlebgcolor}{#1}%
   \colorlet{PROJ@framebgcolor}{#3}%
   \setlength{\tabcolsep}{#4}%
   \setlength{\PROJ@frameaboveovh}{#5}%
   \setlength{\PROJ@framebelowovh}{#6}%
   \setlength{\PROJ@frameaboveskip}{#7}%
   \setlength{\PROJ@framebelowskip}{#8}%
   \begin{lrbox}{\PROJ@framebox}%
   \begin{tabular}{l}%
   \rowcolor{\filtered{PROJ@frametitlebgcolor}}%
   \begin{minipage}{\textwidth}%
   \PROJ@FixUpTop%
   \StackBackground{PROJ@frametitlebgcolor}%
   \vspace{\PROJ@frameaboveovh}%
   #2%
   \par%
   \vspace{\PROJ@framebelowovh}%
   \end{minipage}%
   \\%
   \rowcolor{\filtered{PROJ@framebgcolor}}%
   \begin{minipage}{\textwidth}%
   \PROJ@FixUpTop%
   \StackBackground{PROJ@framebgcolor}%
   \vspace{\PROJ@frameaboveovh}%
}{%
   \par%
   \vspace{\PROJ@framebelowovh}%
   \end{minipage}%
   \end{tabular}%
   \end{lrbox}%
   \par%
   \setlength{\PROJ@frameH}{\ht\PROJ@framebox}%
   \setlength{\PROJ@frameD}{\dp\PROJ@framebox}%
   \setlength{\PROJ@frameT}{\PROJ@frameH}%
   \addtolength{\PROJ@frameT}{\PROJ@frameD}%
   \settoheight{\PROJ@frameX}{X}%
   \bgroup\addtolength{\baselineskip}{\PROJ@frameT-\PROJ@frameX}%
   \vspace{\PROJ@frameaboveskip}%
   \hspace*{-\tabcolsep}%
   \ifthenelse{\equal{\paramval{highlight.shaded}}{true} \AND %
               \boolean{visibleP}}{%
      \def\PROJ@show@box{\PROJ@shadowbox}%
   }{%
      \def\PROJ@show@box{\usebox}%
   }%
   \raisebox{\PROJ@frameD}{\PROJ@show@box{\PROJ@framebox}}%
   \par%
   \egroup%
   \vspace{\PROJ@framebelowskip}%
}





% titledframe takes args:
%  1: title bgcolor
%  2: title text
%  3: body bgcolor

\newenvironment{titledframe}[3]{%
   \begin{xtitledframe}{#1}{#2}{#3}{3pt}{3pt}{3pt}{0pt}{0pt}%
}{%
   \end{xtitledframe}%
}



%% Banner commands


%\newparam{banner.format}{\large\fgcolor{blue!80!black}}{}
\newparam{banner.format}{\large\fgcolor{black}}{}
\newparam{banner.env}{center}{}
\newparam{banner.aboveskip}{0pt}{}
\newparam{banner.belowskip}{\smallskipamount}{}

%\newparam{Banner.format}{\large\bf\fgcolor{blue!80!black}}{}
\newparam{Banner.format}{\large\bf\fgcolor{black}}{}
\newparam{Banner.env}{center}{}
\newparam{Banner.aboveskip}{0pt}{}
\newparam{Banner.belowskip}{\medskipamount}{}


%\newparam{BANNER.format}{\Large\bf\fgcolor{blue!80!black}}{}
\newparam{BANNER.format}{\Large\bf\fgcolor{black}}{}
\newparam{BANNER.env}{center}{}
\newparam{BANNER.aboveskip}{0pt}{}
\newparam{BANNER.belowskip}{\bigskipamount}{}

\newcommand{\BANNER}[1]{%
\par%
\vspace{\paramval{BANNER.aboveskip}}%
\begin{\paramval{BANNER.env}}\paramval{BANNER.format}\boldmath#1\end{\paramval{BANNER.env}}%
\par%
\vspace{\paramval{BANNER.belowskip}}%
}

\newcommand{\Banner}[1]{%
\par%
\vspace{\paramval{Banner.aboveskip}}%
\begin{\paramval{Banner.env}}\paramval{Banner.format}\boldmath#1\end{\paramval{Banner.env}}%
\par%
\vspace{\paramval{Banner.belowskip}}%
}

\newcommand{\banner}[1]{%
\par%
\vspace{\paramval{banner.aboveskip}}%
\begin{\paramval{banner.env}}\paramval{banner.format}\boldmath#1\end{\paramval{banner.env}}%
\par%
\vspace{\paramval{banner.belowskip}}%
}


% Theorems and such


\newcommand{\newtheoremframe}[2]{%
   \newenvironment{#1}[1][]{\begin{highlight}[#2 ##1]}{\end{highlight}}%
}

\newcommand{\renewtheoremframe}[2]{%
   \renewenvironment{#1}[1][]{\begin{highlight}[#2 ##1]}{\end{highlight}}%
}


%%%%%



\newparam{highlight.title.format}{\it\fgcolor{white}}{}
\newparam[edef]{highlight.title.bgcolor}{blue!60}{}
\newparam{highlight.body.format}{\fgcolor{black}}{}
\newparam[edef]{highlight.body.bgcolor}{blue!20}{}
\newparam[edef]{highlight.shaded}{true}{}

   

\newenvironment{highlight}[1][\NULL]{%
   \PROJ@ifeq{\NULL}{#1}{%
      \begin{plainframe}{\paramval{highlight.body.bgcolor}}%
      \paramval{highlight.body.format}%
      \def\PROJ@highlightEnd{\end{plainframe}}%
   }{%
      \begin{titledframe}%
      {\paramval{highlight.title.bgcolor}}%
      {\paramval{highlight.title.format}#1}%
      {\paramval{highlight.body.bgcolor}}%
      \paramval{highlight.body.format}%
      \def\PROJ@highlightEnd{\end{titledframe}}%
   }%
}{%
   \PROJ@highlightEnd%
}






%%%%%%% ifthenbox stuff

\newsavebox{\PROJ@BoxA}
\newsavebox{\PROJ@BoxB}

\newlength{\PROJ@wdC}
\newlength{\PROJ@htC}
\newlength{\PROJ@dpC}

\newcommand\PROJ@setmaxlen[3]{%
   \ifthenelse{\lengthtest{#2 < #3}}{%
      \setlength{#1}{#3}%
   }{%
      \setlength{#1}{#2}%
   }%
}

\newcommand\ifthenbox[4][c]{%
   \sbox{\PROJ@BoxA}{#3}%
   \sbox{\PROJ@BoxB}{#4}%
   \PROJ@setmaxlen{\PROJ@wdC}{\wd\PROJ@BoxA}{\wd\PROJ@BoxB}%
   \PROJ@setmaxlen{\PROJ@htC}{\ht\PROJ@BoxA}{\ht\PROJ@BoxB}%
   \PROJ@setmaxlen{\PROJ@dpC}{\dp\PROJ@BoxA}{\dp\PROJ@BoxB}%
   \raisebox{0pt}[\PROJ@htC][\PROJ@dpC]{\makebox[\PROJ@wdC][#1]{%
      \def\n{\value{overlaynum}}%
      \def\p{\value{pausectr}}%
      \ifthenelse{#2}{\usebox{\PROJ@BoxA}}{\usebox{\PROJ@BoxB}}%
   }}%
}



\newcommand{\graphicbox}[2][]{%
      \ifthenbox{\boolean{visibleP}}{\includegraphics[#1]{#2}}{}%
}

%%%%%%% vertical box shifting


\newcommand{\centerbox}[2][0pt]{\raisebox{(\depth-\height)*\real{0.5}+(#1)}{#2}}
\newcommand{\upbox}[2][0pt]{\raisebox{\depth+(#1)}{#2}}
\newcommand{\downbox}[2][0pt]{\raisebox{-\height+(#1)}{#2}}



%%%%%%% colorboxes, etc.

\newcommand{\Colorbox}[2]{{%
   \colorlet{PROJ@boxbgcolor}{#1}%
   \StackBackground{PROJ@boxbgcolor}%
   \colorbox{\filtered{PROJ@boxbgcolor}}{#2}%
}}

\newcommand{\FColorbox}[3]{{%
   \colorlet{PROJ@boxfcolor}{#1}%
   \colorlet{PROJ@boxbgcolor}{#2}%
   \StackBackground{PROJ@boxbgcolor}%
   \fcolorbox{\filtered{PROJ@boxfcolor}}{\filtered{PROJ@boxbgcolor}}{#3}%
}}

\newsavebox{\PROJ@lrbox}

\newparam[edef]{BOX.fwidth}{100}{}
\newparam[edef]{BOX.margin}{100}{}
\newparam[edef]{BOX.bgcolor}{blue!20}{}
\newparam[edef]{BOX.fcolor}{foreground}{}
\newparam[edef]{BOX.framed}{false}{}
\newparam[edef]{BOX.opaque}{false}{}
\newparam[edef]{BOX.shaded}{false}{}
\newparam[edef]{BOX.extended}{false}{}

\newparam{BOX.when}{}{%
   \def\PROJ@box@default@test{\ifthenelse{#1}}%
}
\setparam{BOX.when}{\boolean{true}}



\define@key{PROJ@box}{fwidth}{\def\PROJ@box@fwidth{#1}\def\PROJ@box@framed{true}}
\define@key{PROJ@box}{margin}{\def\PROJ@box@margin{#1}}
\define@key{PROJ@box}{bgcolor}{\def\PROJ@box@bgcolor{#1}\def\PROJ@box@opaque{true}}
\define@key{PROJ@box}{fcolor}{\def\PROJ@box@fcolor{#1}\def\PROJ@box@framed{true}}
\define@key{PROJ@box}{framed}[true]{\def\PROJ@box@framed{#1}}
\define@key{PROJ@box}{opaque}[true]{\def\PROJ@box@opaque{#1}}
\define@key{PROJ@box}{shaded}[true]{\def\PROJ@box@shaded{#1}}
\define@key{PROJ@box}{extended}[true]{\def\PROJ@box@extended{#1}}
\define@key{PROJ@box}{when}{\def\PROJ@box@test{\ifthenelse{#1}}}

\newsavebox{\PROJ@BOX@box}

\newlength{\PROJ@BOX@lh}
\newlength{\PROJ@BOX@ld}
\newlength{\PROJ@BOX@lw}

\newlength{\PROJ@BOX@h}
\newlength{\PROJ@BOX@d}
\newlength{\PROJ@BOX@w}


\newenvironment{BOX}[1][]{%
   \let\PROJ@box@test\PROJ@box@default@test%
   \def\PROJ@box@framed{\paramval{BOX.framed}}%
   \def\PROJ@box@opaque{\paramval{BOX.opaque}}%
   \def\PROJ@box@fwidth{\paramval{BOX.fwidth}}%
   \def\PROJ@box@margin{\paramval{BOX.margin}}%
   \def\PROJ@box@bgcolor{\paramval{BOX.bgcolor}}%
   \def\PROJ@box@fcolor{\paramval{BOX.fcolor}}%
   \def\PROJ@box@shaded{\paramval{BOX.shaded}}%
   \def\PROJ@box@extended{\paramval{BOX.extended}}%
   \setkeys{PROJ@box}{#1}%
   {%
      \def\n{\value{overlaynum}}%
      \def\p{\value{pausectr}}%
      \PROJ@box@test{\gdef\PROJ@box@pass{true}}{\gdef\PROJ@box@pass{false}}%
   }%
   \ifthenelse{\equal{\PROJ@box@shaded}{true} \AND \boolean{visibleP} \AND %
               \equal{\PROJ@box@pass}{true}}{%
      \def\PROJ@show@box{\PROJ@shadowbox}%
   }{%
      \def\PROJ@show@box{\usebox}%
   }%
   \ifthenelse{\equal{\PROJ@box@pass}{true}}{}{%
      \def\PROJ@box@bgcolor{background}%
      \def\PROJ@box@fcolor{background}%
   }%
   \ifthenelse{\equal{\PROJ@box@opaque}{true}}{}{%
      \def\PROJ@box@bgcolor{background}%
   }%
   \colorlet{PROJ@box@bgcol}{\PROJ@box@bgcolor}%
   \colorlet{PROJ@box@fcol}{\PROJ@box@fcolor}%
   \bgroup%
   \StackBackground{PROJ@box@bgcol}%
   \begin{lrbox}{\PROJ@lrbox}%
}{%
   \end{lrbox}%
   \PROJ@fracscale{\fboxrule}{1pt}{\PROJ@box@fwidth}{100}%
   \PROJ@fracscale{\fboxsep}{3pt}{\PROJ@box@margin}{100}%
   \ifthenelse{\equal{\PROJ@box@extended}{true}}{%
      \setlength{\PROJ@BOX@lw}{\fboxsep}%
      \ifthenelse{\equal{\PROJ@box@framed}{true}}{%
         \addtolength{\PROJ@BOX@lw}{\fboxrule}%
      }{}%
      \setlength{\PROJ@BOX@lh}{\ht\PROJ@lrbox}%
      \setlength{\PROJ@BOX@ld}{\dp\PROJ@lrbox}%
      \global\PROJ@BOX@w\PROJ@BOX@lw%
      \global\PROJ@BOX@h\PROJ@BOX@lh%
      \global\PROJ@BOX@d\PROJ@BOX@ld%
   }{}%
   \ifthenelse{\equal{\PROJ@box@framed}{true}}{%
      \global\sbox{\PROJ@BOX@box}{\fcolorbox{\filtered{PROJ@box@fcol}}{\filtered{PROJ@box@bgcol}}{\usebox{\PROJ@lrbox}}}%
   }{%
      \global\sbox{\PROJ@BOX@box}{\colorbox{\filtered{PROJ@box@bgcol}}{\usebox{\PROJ@lrbox}}}%
   }%
   \egroup%
   \ifthenelse{\equal{\PROJ@box@extended}{true}}{%
      \hspace{-\PROJ@BOX@w}%
      \raisebox{0pt}[\PROJ@BOX@h][\PROJ@BOX@d]{%
         \PROJ@show@box{\PROJ@BOX@box}%
      }%
      \hspace{-\PROJ@BOX@w}%
   }{%
      \PROJ@show@box{\PROJ@BOX@box}%
   }%
}



\newparam[edef]{shadow.color}{foreground}{}
\newparam[edef]{shadow.contrast}{100}{}
\newparam[edef]{shadow.fuzz}{100}{}
\newparam[edef]{shadow.hoffset}{100}{}
\newparam[edef]{shadow.voffset}{100}{}
\newparam[edef]{shadow.resolution}{100}{}

\newlength{\PROJ@shadowextent}
\newlength{\PROJ@shadowhoffset}
\newlength{\PROJ@shadowvoffset}


\newcounter{PROJ@shstep}
\newcounter{PROJ@shmax}

\newlength{\PROJ@shlen}
\newlength{\PROJ@shwidth}
\newlength{\PROJ@shheight}
\newlength{\PROJ@shdepth}
\newlength{\PROJ@shtotal}


\newcommand\PROJ@makeshadowbox{%
   \setcounter{PROJ@shstep}{0}%
   \setcounter{PROJ@shmax}{\PROJ@shadownumsteps}%
   \addtocounter{PROJ@shmax}{-1}%
   \whiledo{\value{PROJ@shstep} < \value{PROJ@shmax}}{%
      \stepcounter{PROJ@shstep}%
      \FPeval\PROJ@shadowfrac{clip(thePROJ@shstep/PROJ@shadownumsteps)}%
      \FPeval\PROJ@newcontrast{sin(PROJ@shadowfrac*FPpi/2)}%
      \FPeval\PROJ@newcontrast{PROJ@newcontrast*PROJ@newcontrast}%
      \FPeval\PROJ@newfade{clip(100 - PROJ@shadowcontrast*PROJ@newcontrast*(100 - fadeamount))}%
      \FPeval\PROJ@shadowsize{clip(1-PROJ@shadowfrac)}%
      \setlength{\PROJ@shlen}{\PROJ@shadowextent * \real{\PROJ@shadowsize}}%
      {\fade{\PROJ@newfade}\fgcolor{\PROJ@shadowcolor}%
      \raisebox{-\PROJ@shlen}[0pt][0pt]{\makebox[0pt][l]{\hspace{-\PROJ@shlen}\rule{\PROJ@shwidth+\PROJ@shlen*\real{2}}{\PROJ@shtotal+\PROJ@shlen*\real{2}}}}}}%
   \FPeval\PROJ@newfade{clip(100 - PROJ@shadowcontrast*(100 - fadeamount))}%
   {\fade{\PROJ@newfade}\fgcolor{\PROJ@shadowcolor}%
   \rule{\PROJ@shwidth}{\PROJ@shtotal}}%
}

\newcommand\PROJ@shadowbox[1]{%
   \edef\PROJ@shadowcolor{\paramval{shadow.color}}%
   \edef\PROJ@tmpval{\paramval{shadow.contrast}}%
   \FPeval\PROJ@shadowcontrast{0.15*PROJ@tmpval/100}%
   \PROJ@scale{\PROJ@shadowextent}{2pt}{shadow.fuzz}%
   \PROJ@scale{\PROJ@shadowhoffset}{2pt}{shadow.hoffset}%
   \PROJ@scale{\PROJ@shadowvoffset}{2pt}{shadow.voffset}%
   \edef\PROJ@tmpval{\paramval{shadow.resolution}}%
   \FPeval\PROJ@tmpval{max(trunc(10*PROJ@tmpval/100,0),0)}%
   \edef\PROJ@shadownumsteps{\PROJ@tmpval}%
%
   \setlength{\PROJ@shwidth}{\wd#1}%
   \setlength{\PROJ@shheight}{\ht#1}%
   \setlength{\PROJ@shdepth}{\dp#1}%
   \setlength{\PROJ@shtotal}{\PROJ@shheight+\PROJ@shdepth}%
   \raisebox{-\PROJ@shadowvoffset-\PROJ@shdepth}[0pt][0pt]{%
      \makebox[0pt][l]{\hspace{\PROJ@shadowhoffset}%
                       \PROJ@makeshadowbox}}%
   \usebox{#1}%
}





%%%%%%% lists and stuff

\newparam{enum.format}{}{}

\newparam{enum.label.1}{\N\arabic.}{\PROJ@enumi@refresh}
\newparam{enum.label.2}{\N\alph.}{\PROJ@enumii@refresh}
\newparam{enum.label.3}{\N\roman)}{\PROJ@enumiii@refresh}
\newparam{enum.label.4}{\N\Alph.}{\PROJ@enumiv@refresh}

\newsavebox{\PROJ@enum@tempbox}

\def\PROJ@enumi@set#1{\gdef\PROJ@enum@tmp{#1{enumi}}}
\newcommand\PROJ@enumi@refresh{%
  {\def\A{}\def\B{}\def\C{}%
   \def\N{\PROJ@enumi@set}%
   \gdef\PROJ@enum@tmp{}%
   \overlaysoff%
   \sbox{\PROJ@enum@tempbox}{\paramval{enum.label.1}}}%
   \let\theenumi\PROJ@enum@tmp%
}
\def\PROJ@enumii@set#1{\gdef\PROJ@enum@tmp{#1{enumii}}}
\newcommand\PROJ@enumii@refresh{%
  {\def\A{}\def\B{}\def\C{}%
   \def\N{\PROJ@enumii@set}%
   \gdef\PROJ@enum@tmp{}%
   \overlaysoff%
   \sbox{\PROJ@enum@tempbox}{\paramval{enum.label.2}}}%
   \let\theenumii\PROJ@enum@tmp%
}
\def\PROJ@enumiii@set#1{\gdef\PROJ@enum@tmp{#1{enumiii}}}
\newcommand\PROJ@enumiii@refresh{%
  {\def\A{}\def\B{}\def\C{}%
   \def\N{\PROJ@enumiii@set}%
   \gdef\PROJ@enum@tmp{}%
   \overlaysoff%
   \sbox{\PROJ@enum@tempbox}{\paramval{enum.label.3}}}%
   \let\theenumiii\PROJ@enum@tmp%
}
\def\PROJ@enumiv@set#1{\gdef\PROJ@enum@tmp{#1{enumiv}}}
\newcommand\PROJ@enumiv@refresh{%
  {\def\A{}\def\B{}\def\C{}%
   \def\N{\PROJ@enumiv@set}%
   \gdef\PROJ@enum@tmp{}%
   \overlaysoff%
   \sbox{\PROJ@enum@tempbox}{\paramval{enum.label.4}}}%
   \let\theenumiv\PROJ@enum@tmp%
}

\PROJ@enumi@refresh
\PROJ@enumii@refresh
\PROJ@enumiii@refresh
\PROJ@enumiv@refresh

\newparam{item.format}{}{}

\renewcommand{\labelenumi}{{%
   \def\N##1{\theenumi}%
   \paramval{enum.format}%
   \paramval{enum.label.1}%
}}

\renewcommand{\labelenumii}{{%
   \def\A{\theenumi}%
   \def\N##1{\theenumii}%
   \paramval{enum.format}%
   \paramval{enum.label.2}%
}}

\renewcommand{\labelenumiii}{{%
   \def\A{\theenumi}%
   \def\B{\theenumii}%
   \def\N##1{\theenumiii}%
   \paramval{enum.format}%
   \paramval{enum.label.3}%
}}

\renewcommand{\labelenumiv}{{%
   \def\A{\theenumi}%
   \def\B{\theenumii}%
   \def\B{\theenumiii}%
   \def\N##1{\theenumiv}%
   \paramval{enum.format}%
   \paramval{enum.label.3}%
}}


\newparam{enum.sep.1}{}{}
\newparam{enum.sep.2}{}{}
\newparam{enum.sep.3}{.}{}
\newparam{enum.sep.4}{)}{}

\renewcommand\p@enumi{\paramval{enum.sep.1}}
\renewcommand\p@enumii{\p@enumi\theenumi\paramval{enum.sep.2}}
\renewcommand\p@enumiii{\p@enumii\theenumii\paramval{enum.sep.3}}
\renewcommand\p@enumiv{\p@enumiii\theenumiii\paramval{enum.sep.4}}

\newparam{item.label.1}{\(\bullet\)}{}
\newparam{item.label.2}{\(\circ\)}{}
\newparam{item.label.3}{\(\cdot\)}{}
\newparam{item.label.4}{-}{}

\renewcommand\labelitemi{\paramval{item.format}\paramval{item.label.1}}
\renewcommand\labelitemii{\paramval{item.format}\paramval{item.label.2}}
\renewcommand\labelitemiii{\paramval{item.format}\paramval{item.label.3}}
\renewcommand\labelitemiv{\paramval{item.format}\paramval{item.label.4}}

%%%%%%%%%%%%%%%%%%%%%%%


\newcommand\DefineSpecialEncoding[1]{%
   \def\PROJ@special@tmp{PROJ@special@@\expandafter\@gobble\string#1}%
   \newcommand#1[1]{%
      \csname PROJ@special@@\expandafter\@gobble\string#1\endcsname{\arabic{##1}}%
   }%
   \PROJ@MakeSpecialAlphaHelper%
}

\newcommand\PROJ@MakeSpecialAlphaHelper[9]{%
   \expandafter\DeclareRobustCommand%
      \csname\PROJ@special@tmp\endcsname[1]{%
      \ifthenelse{##1=1}{#1}{%
      \ifthenelse{##1=2}{#2}{%
      \ifthenelse{##1=3}{#3}{%
      \ifthenelse{##1=4}{#4}{%
      \ifthenelse{##1=5}{#5}{%
      \ifthenelse{##1=6}{#6}{%
      \ifthenelse{##1=7}{#7}{%
      \ifthenelse{##1=8}{#8}{%
      \ifthenelse{##1=9}{#9}{##1}}}}}}}}}%
   }%
}


%%%%%%%%%%%%%%

\newcommand\targetslide[2][]{%
   \PROJ@ifeq{#1}{}{%
      \PROJ@AtFooter{\PROJ@anchor{#2}}%
   }{%
      {\def\p{\value{pausectr}}\setcounter{PROJ@overlayVal}{#1}}%
      \ifoverlaysoff{}{\PROJ@updateMaxOverlays{\value{PROJ@overlayVal}}}%
      \ifthenelse{\value{overlaynum} = \value{PROJ@overlayVal}}{%
         \hypertarget{#2}{}%
      }{}%
   }%
}

%%%%%%%%%%%%%%%%

\newcommand{\trimslide}[1][1]{%
   \ifoverlaysoff{}{\addtocounter{PROJ@overlayMax}{-#1}}%
}

%%%%%%%%%%%%%%%%%%%

\newcommand\Tag[1][\NULL]{%
   \PROJ@ifeq{\NULL}{#1}{%
      \stepcounter{equation}%
      \ifvisible{%
         \tag*{\visible(\theequation)}%
      }{%
         \tag*{\invisible(\theequation)}%
      }%
   }{%
      \ifvisible{%
         \tag*{\visible#1}%
      }{%
         \tag*{\invisible#1}%
      }%
   }%
}

\newcommand\TagRef[1]{{\overlaysoff\ref{#1}}}
      
%%%%%%%%%%%%%%%%%%%


\newcounter{PROJ@savepause}
\xglobal\colorlet{PROJ@RowColor}{white}

%% Logic: an explicit column color trumps an explicit row color

\newcommand\Col[1][\NULL]{%
   \refresh%
   \PROJ@ifeq{\NULL}{#1}{%
      \xglobal\colorlet{PROJ@CellColor}{PROJ@RowColor}%
      \def\PROJ@havecol{false}%
   }{%
      \xglobal\colorlet{PROJ@CellColor}{#1}%
      \def\PROJ@havecol{true}%
   }%
   \xglobal\colorlet{PROJ@FCellColor}{\filtered{PROJ@CellColor}}%
   \cellcolor{PROJ@FCellColor}%
}


\newcommand\Row[1][background]{%
   \xglobal\colorlet{PROJ@RowColor}{#1}%
   \ifthenelse{\equal{\PROJ@havecol}{true}}{%
   }{%
      \xglobal\colorlet{PROJ@CellColor}{PROJ@RowColor}%
   }%
   \xglobal\colorlet{PROJ@FCellColor}{\filtered{PROJ@CellColor}}%
   \cellcolor{PROJ@FCellColor}%
}

\newcommand\Cell[1]{%
   \colorlet{PROJ@CellColor}{#1}%
   \xglobal\colorlet{PROJ@FCellColor}{\filtered{PROJ@CellColor}}%
   \cellcolor{PROJ@FCellColor}%
}

\newcommand\Panel[1]{%
   {\StackBackground{PROJ@CellColor}#1}%
   \record{@}%
}


\newcommand\SaveP{\setcounter{PROJ@savepause}{\value{pausectr}}}
\newcommand\ResP{\PauseSet{\value{PROJ@savepause}}}



%%%%%%%%%% putbox stuff

\newcounter{PROJ@putbox}
\newcounter{PROJ@maxputbox}
\newcounter{PROJ@i}
\newlength{\PROJ@puth}
\newlength{\PROJ@putv}

\setcounter{PROJ@maxputbox}{-1}

\newsavebox{\PROJ@tempsavebox}

\newcommand\putbox[3]{%
   \setlength{\PROJ@puth}{#1}%
   \setlength{\PROJ@putv}{#2}%
   \ifthenelse{\value{PROJ@putbox} > \value{PROJ@maxputbox}}{%
      \stepcounter{PROJ@maxputbox}%
      \expandafter\newsavebox\csname PROJ@putbox@@\arabic{PROJ@maxputbox}\endcsname
   }{}%
   \sbox{\PROJ@tempsavebox}{#3}%
   \global\sbox{\csname PROJ@putbox@@\arabic{PROJ@putbox}\endcsname}{%
      \raisebox{\PROJ@putv}{%
         \hbox to 0pt{\hspace{\PROJ@puth}%
            \hbox{\usebox{\PROJ@tempsavebox}}% 
         }%
      }%
   }%
   \stepcounter{PROJ@putbox}%
}

\newcommand\PROJ@putboxhook{%
   \setcounter{PROJ@i}{0}%
   \whiledo{\value{PROJ@i} < \value{PROJ@putbox}}{%
      \raisebox{\footskip}[0pt][0pt]{\usebox{\csname PROJ@putbox@@\arabic{PROJ@i}\endcsname}}%
      \stepcounter{PROJ@i}%
   }%
}




%%%%%%%%%%%%%% Stripe stuff



\newparam[edef]{Stripe.margin}{100}{}
\newparam[edef]{Stripe.bgcolor}{blue!60}{}
\newparam{Stripe.env}{center}{}
\newparam{Stripe.format}{\bf\large\fgcolor{white}}{}

\newsavebox{\PROJ@StripeBox}

\newlength{\PROJ@StripeMargin}
\newlength{\PROJ@StripeSkip}
\newlength{\PROJ@StripeMin}
\newlength{\PROJ@StripeMax}


\newcommand\Stripe[1]{%
   \PROJ@scale{\PROJ@StripeMargin}{10pt}{Stripe.margin}%
   \def\PROJ@StripeEnv{\paramval{Stripe.env}}%
   \def\PROJ@StripeFormat{\paramval{Stripe.format}}%
   \def\PROJ@StripeBgcolor{\paramval{Stripe.bgcolor}}%
   \sbox{\PROJ@StripeBox}{%
   \colorlet{PROJ@StripeBg}{\PROJ@StripeBgcolor}%
   \StackBackground{PROJ@StripeBg}%
   \PROJ@StripeFormat%
   \begin{minipage}[b]{\paperwidth-2\PROJ@StripeMargin}%
   \begin{\PROJ@StripeEnv}%
   #1%
   \end{\PROJ@StripeEnv}%
   \end{minipage}%
   }%
%
%  height and depth of box are set to prevent "jitters"
%
   \settoheight{\PROJ@StripeMin}{\PROJ@StripeFormat X}%
   \setlength{\PROJ@StripeMax}{\PROJ@StripeMin + \PROJ@StripeMargin*\real{0.75}}%
   \ifthenelse{\lengthtest{\ht\PROJ@StripeBox<\PROJ@StripeMax}}{%
      \setlength{\ht\PROJ@StripeBox}{\PROJ@StripeMin}%
   }{}%
%
   \setlength{\PROJ@StripeMax}{\PROJ@StripeMargin*\real{0.75}}%
   \ifthenelse{\lengthtest{\dp\PROJ@StripeBox<\PROJ@StripeMax}}{%
      \setlength{\dp\PROJ@StripeBox}{0pt}%
   }{}%
%
   \sbox{\PROJ@StripeBox}{%
      \setlength{\fboxsep}{\PROJ@StripeMargin}%
      \Colorbox{\PROJ@StripeBgcolor}{\usebox{\PROJ@StripeBox}}%
   }%
%
   \sbox{\PROJ@StripeBox}{\downbox{\usebox{\PROJ@StripeBox}}}%
   \putbox{-\smargin}{\textheight+\tmargin}{\usebox{\PROJ@StripeBox}}%
   \setlength{\PROJ@StripeSkip}{\dp\PROJ@StripeBox - \tmargin + \PROJ@StripeMargin}%
   \vspace{\PROJ@StripeSkip}%
}




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fonts
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
    \DeclareMathSymbol{0}{\mathalpha}{operators}{`0}\DeclareMathSymbol{1}{\mathalpha}{operators}{`1}\DeclareMathSymbol{2}{\mathalpha}{operators}{`2}\DeclareMathSymbol{3}{\mathalpha}{operators}{`3}\DeclareMathSymbol{4}{\mathalpha}{operators}{`4}\DeclareMathSymbol{5}{\mathalpha}{operators}{`5}\DeclareMathSymbol{6}{\mathalpha}{operators}{`6}\DeclareMathSymbol{7}{\mathalpha}{operators}{`7}\DeclareMathSymbol{8}{\mathalpha}{operators}{`8}\DeclareMathSymbol{9}{\mathalpha}{operators}{`9}}
  \else
    \AtEndOfClass{
      \RequirePackage{txfonts}
      \RequirePackage{amssymb}
      \let\wtilde\tilde
      \let\wbar\bar
      \let\what\hat
      \let\XL\displaystyle
      \let\mathbold\bf
      \let\overcbrace\overbrace
      \let\undercbrace\underbrace
    }
 \fi




\AtEndDocument{


%% HACK:  depends on some internal logic of the hyperref package.
\immediate\write\@auxout{\string
   \newlabel{PROJ@lastslide}{{}{\arabic{slidenum}}{}{ArrowAnchor\arabic{slidenum}}{}}}


} %% AtEndDocument


