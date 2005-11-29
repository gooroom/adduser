.\" This file was generated with po4a. Translate the source file.
.\" 
.\" Hey, Emacs!  This is an -*- nroff -*- source file.
.\" Adduser and this manpage are copyright 1995 by Ted Hajek
.\" This is free software; see the GNU General Public Lisence version 2
.\" or later for copying conditions.  There is NO warranty.
.TH adduser.conf 5 "Version VERSION" "Debian GNU/Linux" 
.SH NAMN
/etc/adduser.conf \- konfigurationsfil för \fBadduser(8)\fP och \fBaddgroup(8)\fP.
.SH BESKRIVNING
Filen \fI/etc/adduser.conf\fP innehåller standardvärden för programmen 
\fBadduser(8)\fP , \fBaddgroup(8)\fP , \fBdeluser(8)\fP och \fBdelgroup(8)\fP.  Varje 
rad innehåller ett enstaka värdespar i formatet \fIflagga\fP = 
\fIvärde\fP. Citattecken eller apostrofer är tillåtna runt värdet såväl 
som mellanslag runt likamed\-tecknet.  Kommentarsrader måste påbörjas med 
ett #\-tecken.

Giltiga konfigurationsflaggor är:
.TP 
\fBDSHELL\fP
Inloggningsskalet som ska användas för alla nya 
användare. Standardvärdet är satt till \fI/bin/bash\fP.
.TP 
\fBDHOME\fP
Katalogen i vilken nya hemkataloger ska skapas i.  Standardvärde är 
\fI/home\fP.
.TP 
\fBGROUPHOMES\fP
Om denna är satt till \fIyes\fP kommer hemkataloger att skapas som 
\fI/home/[gruppnamn]/användare\fP.  Standardvärde är \fIno\fP.
.TP 
\fBLETTERHOMES\fP
Om denna är satt till \fIyes\fP kommer hemkataloger som skapas att ha en extra 
katalog inlagd som är första bokstaven för inloggningsnamnet.  Till 
exempel: \fI/home/a/användare\fP.  Standardvärde är \fIno\fP.
.TP 
\fBSKEL\fP
Katalogen från vilken skelettkonfigurationsfiler för användare ska 
kopias.  Standardvärde är \fI/etc/skel\fP.
.TP 
\fBFIRST_SYSTEM_UID\fP and \fBLAST_SYSTEM_UID\fP
ange ett omfång av UID från vilka systemanvändarnas UID kan dynamiskt 
allokeras. Standardvärde är \fI100\fP \- \fI999\fP.
.TP 
\fBFIRST_UID\fP and \fBLAST_UID\fP
ange ett omfång av UID från vilka normala användares UID kan dynamiskt 
allokeras. Standardvärde är \fI1000\fP \- \fI29999\fP.
.TP 
\fBUSERGROUPS\fP
Om denna är satt till \fIyes\fP kommer varje skapad användare att ges sin 
egna grupp att använda. Om denna är \fIno\fP kommer varje skapad användare 
att placeras i gruppen vars GID är \fBUSERS_GID\fP (se nedan).  Standardvärde 
är \fIyes\fP.
.TP 
\fBUSERS_GID\fP
Om \fBUSERGROUPS\fP är \fIno\fP, så är \fBUSERS_GID\fP det GID som angivs för 
alla användare som skapas.  Standardvärde är \fI100\fP.
.TP 
\fBDIR_MODE\fP
Om satt till ett giltigt värde (exempelvis 0755 eller 755) kommer kataloger 
som skapas att ha den angivna rättigheten satt. Om inte kommer 0755 att 
användas som standardvärde.
.TP 
\fBSETGID_HOME\fP
Om denna är satt till \fIyes\fP kommer hemkataloger för användare med sin 
egna grupp ( \fIUSERGROUPS=yes\fP ) att ha setgid\-biten satt. Detta var 
standardinställningen för adduser version << 3.13. Tyvärr har det 
några nackdelar så vi gör inte det längre som standard. Om du vill ha 
det oavsett kan du fortfarande aktivera det här.
.TP 
\fBQUOTAUSER\fP
Om satt till ett icke\-tomt värde kommer nya användare att få diskkvoten 
kopierad från den användare.  Standardvärde är tom.
.TP 
\fBNAME_REGEX\fP
Användarnamn kontrolleras mot detta reguljära uttryck. Om namnet inte 
matchar detta kommer skapandet att vägras om inte \-\-force\-badname är 
satt. Med \-\-force\-badname satt kommer bara svaga kontroller att 
utföras. Standardvärdet är det mest konservativa ^[a\-z][\-a\-z0\-9]*$.
.SH FILER
\fI/etc/adduser.conf\fP
.SH "SE OCKSÅ"
adduser(8), addgroup(8), deluser(8), delgroup(8)

.SH �VERS�TTARE
Denna manualsida har �versatts av Daniel Nylander <po@danielnylander.se> 
den 25 november 2005.

Om du hittar n�gra felaktigheter i �vers�ttningen, v�nligen skicka ett 
e-postmeddelande till �vers�ttaren eller till e-postlistan
.nh
<\fIdebian\-l10n\-swedish@lists.debian.org\fR>,
.hy

