{smcl}
{* *! version 0.3  04apr2015}{...}
{findalias asfradohelp}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] help" "help help"}{...}
{viewerjumpto "Syntax" "examplehelpfile##syntax"}{...}
{viewerjumpto "Description" "examplehelpfile##description"}{...}
{viewerjumpto "Options" "examplehelpfile##options"}{...}
{viewerjumpto "Remarks" "examplehelpfile##remarks"}{...}
{viewerjumpto "Examples" "examplehelpfile##examples"}{...}
{title:Title}

{phang}
{bf:colorcor} {hline 2} Create colored correlation matrices 


{marker syntax}{...}
{title:Syntax}

{p 8 17 2}
{cmdab:colorcor}
[{varlist}]
{ifin}
[{cmd:,} {it:options}]

{synoptset 20 tabbed}{...}
{synopthdr}
{synoptline}
{syntab:Main}
{synopt:{opt N:onsig}}highlight non-significant correlations. {p_end}
{synoptline}
{p2colreset}{...}

{marker description}{...}
{title:Description}

{pstd}
{cmd:colorcor} Shows the Pearson correlation coefficients for the variables specified in {varlist}. The output is a graph, where dark red indicates a coefficient of -1 and dark green indicates a coefficient of 1.  



{marker options}{...}
{title:Options}

{dlgtab:Main}

{phang}
{opt nonsig} indicate correlations that are not significant (p-value>0.05).


{marker examples}{...}
{title:Examples}

{cmd}
    . webuse auto
    . colorcor mpg rep78 headroom trunk
{cmd}

{cmd}
    . webuse auto
    . colorcor mpg rep78 headroom trunk,nonsig(blue)


{dlgtab:Author}

{txt} 
	Hans Henrik Sievertsen 
	The Danish National Centre for Social Research 
	Copenhagen - Denmark 
	{browse "mailto:hhs@sfi.dk":hhs@sfi.dk}



