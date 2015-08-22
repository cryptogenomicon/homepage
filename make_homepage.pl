#! /usr/bin/perl

# Usage:
#  ./make_homepage.pl F22B7 > foo.html
#  [view it to see if you like it; if so:]
#  mv foo.html index.html

#  short text to show:            url to link to (or 0)     
@embed_me = (
  "sean eddy's home page.",      0,
  "contact info.",               "contact.html",
  "lab home page.",              "http://selab.janelia.org/",
  "obtaining reprints & lab publications.", "http://selab.janelia.org/publications.html",
  "hmmer.",                       "http://hmmer.janelia.org/",
  "pfam.",                        "http://pfam.janelia.org/",
  "infernal.",                    "http://infernal.janelia.org/",
  "rfam.",                        "http://rfam.janelia.org/",
  "biological sequence analysis.","http://selab.janelia.org/cupbook.html",
  "my links.",                   "mylinks.html",
  "cv.",                         "cv.pdf",
);


print <<EOF;
<html> <head>
<title>Sean's home page</title>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=ISO-8859-1">
<META NAME="ROBOTS" CONTENT="NOFOLLOW">
</head>

<!-- the look is ripped off from jwz. (www.jwz.org) --!>
<!-- The DNA sequence is real.                      --!>
<link rel="stylesheet" href="dnamatrix.css" type="text/css">

<body>
<pre>
EOF

$totlines = 300;
$nlines = 1;
while (<>) {

    if (/^\s*(\d+):\s+(\S+)\s+(\d+)/) {
	$left_coord    = $1;
	$sequence_line = $2;
	$right_coord   = $3;
    } else { next; }
    
    if ($nlines % 2 == 0 && $#embed_me > 0) {
      # Embed links.
      #    
	$link = shift(@embed_me);
	$url  = shift(@embed_me);
	$textlen = length($link);
	
	if ($url) { $embedtext = "<b><a href=\"$url\">$link</a></b>"; }
	else      { $embedtext = "<b><font color=\"#00ff00\">$link</font></b>"; }

	$which_base = int(rand $nres-$textlen);
	substr $sequence_line, $which_base, $textlen, $embedtext;
    } else {
      # Sow confusion.
      #
	$nres = length($sequence_line);
	@bases = split(//, $sequence_line);

	$which_base = int(rand $nres);
	$bases[$which_base] = "<b>$bases[$which_base]</b>";
	
	$which_base = int(rand $nres);
	$bases[$which_base] = "<b><font color=\"#00ff00\">$bases[$which_base]</font></b>";

	$sequence_line = join '', @bases;
}
    printf("%5d %s %-5d\n", $left_coord, $sequence_line, $right_coord);
    $nlines++;
    if ($nlines >= $totlines) { last; }
}



print <<EOF;
  
</pre>
</body> </html>
EOF
