.\" This file was generated with po4a. Translate the source file.
.\" 
.\" Hey, Emacs!  This is an -*- nroff -*- source file.
.\" Adduser and this manpage are copyright 1995 by Ted Hajek
.\" This is free software; see the GNU General Public Lisence version 2
.\" or later for copying conditions.  There is NO warranty.
.TH deluser.conf 5 "Version VERSION" "Debian GNU/Linux" 
.SH NAMN
/etc/deluser.conf \- konfigurationsfil för \fBdeluser(8)\fP och \fBdelgroup(8)\fP.
.SH BESKRIVNING
Filen \fI/etc/deluser.conf\fP innehåller standardvärden för programmen 
\fBdeluser(8)\fP och \fBdelgroup(8)\fP.  Varje flagga tas emot i formatet 
\fIflagga\fP = \fIvärde\fP.  Citattecken och apostrofer tillåts runt värdet.  
Kommentarsrader måste ha ett #\-tecken i början av raden.

deluser(8) och delgroup(8) läser också från /etc/adduser.conf.

Giltiga konfigurationsflaggor är:
.TP 
\fBREMOVE_HOME\fP
Tar bort hemkatalogen och post för användaren. Värdet kan vara 0 eller 1.
.TP 
\fBREMOVE_ALL_FILES\fP
Tar bort alla filer på systemet som ägs av användaren. Om denna flagga 
är aktiverad har \fBREMOVE_HOME\fP ingen effekt. Värdet kan vara 0 eller 1.
.TP 
\fBBACKUP\fP
Om \fBREMOVE_HOME\fP eller \fBREMOVE_ALL_FILES\fP är aktiverade kommer alla filer 
att säkerhetskopieras före de tas bort. Den säkerhetskopierade filen 
skapas i formatet användarnamn.tar(.gz|.bz2) i den katalog som angivits med 
flaggan \fBBACKUP_TO\fP. Komprimeringsmetoden som väljs är den bästa som 
finns tillgänglig.  Värdet kan vara 0 eller 1.
.TP 
\fBBACKUP_TO\fP
Om \fBBACKUP\fP är aktiverad anger \fBBACKUP_TO\fP katalogen din säkerhetskopian 
skrivs till. Standardvärde är nuvarande katalog.
.TP 
\fBNO_DEL_PATHS\fP
En list på reguljära uttryck, separerade med mellanslag. Alla filer som 
ska tas bort om hemkataloger ska tas bort eller borttagning av filer ägda 
av en användare som ska tas bort kontrolleras mot varje av dessa reguljära 
uttryck. Om en matchning upptäcks kommer filen inte att tas 
bort. Standardvärde är en lista av systemkataloger, endast /home gäller.
.SH FILER
\fI/etc/deluser.conf\fP
.SH "SE OCKSÅ"
deluser(8), delgroup(8), adduser.conf(5)
.SH �VERS�TTARE
Denna manualsida har �versatts av Daniel Nylander <po@danielnylander.se> 
den 25 november 2005.

Om du hittar n�gra felaktigheter i �vers�ttningen, v�nligen skicka ett 
e-postmeddelande till �vers�ttaren eller till e-postlistan
.nh
<\fIdebian\-l10n\-swedish@lists.debian.org\fR>,
.hy

