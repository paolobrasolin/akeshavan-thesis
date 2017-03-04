% Document class developed by Paolo Brasolin <paolo.brasolin@gmail.com>
% for anisa Keshavan.

% Require correct TeX format.
\NeedsTeXFormat{LaTeX2e}

% Declare what we're up to.
\ProvidesClass{uscf}[2016/02/26]

% The basic document class we build upon.
\LoadClass[
  oneside,
  12pt
]{scrbook}

% Use Times New Roman (surrogate).
\RequirePackage[T1]{fontenc}
\RequirePackage{newtxmath,newtxtext}

% Set the document language (for hyphenation & conventions).
\RequirePackage[english]{babel}

% Set up the page geometry.
\RequirePackage[
  letterpaper,
  margin=1in,
  footskip=.4in,
  % showframe
]{geometry}

% No paragraph indents; use paragraph spacing.
\RequirePackage{parskip}

% Double line spacing.
\RequirePackage{setspace}
\doublespacing

% Place page numbers.
\usepackage{scrpage2}
\pagestyle{scrheadings}
\clearscrheadfoot
\cofoot[\pagemark]{\pagemark}
\cefoot[\pagemark]{\pagemark}

% Customize toc depth and numbered headings depth.
% \setcounter{tocdepth}{1}
% \setcounter{secnumdepth}{1}

% Make headers font serif.
\addtokomafont{disposition}{\rmfamily}

% Activate invisible hyperlinks.
\RequirePackage[
  hidelinks
]{hyperref}
% \renewcommand\UrlFont{}

% Useful to define custom macros.
% \RequirePackage{xparse}
% \RequirePackage{etoolbox}

% Bare minimum to write math.
\RequirePackage{mathtools}
\RequirePackage{amssymb}

% Customize lists.
\RequirePackage{enumitem}

% Utilities for floating figures/tables.
\RequirePackage{float}

% Baseline decent-looking tables.
\RequirePackage{booktabs}

% Hooks to append/prepend code to document.
% \AfterEndPreamble{}
% \AtBeginDocument{}
% \AtEndDocument{}

% Bibliography configuration.
\RequirePackage[
]{biblatex}

% Usefol for re-including the signed and scanned pages.
\RequirePackage{pdfpages}

% Increase typographical beauty.
\RequirePackage{microtype}

\endinput
