.\" This file was generated with po4a. Translate the source file.
.\" 
.\" Someone tell emacs that this is an -*- nroff -*- source file.
.\" Copyright 1997, 1998, 1999 Guy Maor.
.\" Adduser and this manpage are copyright 1995 by Ted Hajek,
.\" With much borrowing from the original adduser copyright 1994 by
.\" Ian Murdock.
.\" This is free software; see the GNU General Public License version
.\" 2 or later for copying conditions.  There is NO warranty.
.TH DELUSER 8 "Version VERSION" "Debian GNU/Linux" 
.SH NAMN
deluser, delgroup \- ta bort en användare eller grupp från systemet
.SH SYNOPSIS
\fBdeluser\fP [options] [\-\-remove\-home] [\-\-home KATALOG] [\-\-remove\-all\-files] 
[\-\-backup] [\-\-backup\-to] användare
.PP
\fBdeluser\fP \-\-group [flaggor] grupp
.br
\fBdelgroup\fP [flaggor] [\-\-only\-if\-empty] grupp
.PP
\fBdeluser\fP [flaggor] användare grupp
.SS "VANLIGA FLAGGOR"
.br
[\-\-quiet] [\-\-system] [\-\-help] [\-\-version] [\-\-conf FIL]
.SH BESKRIVNING
.PP
\fBdeluser\fP och \fBdelgroup\fP tar bort användare och grupper från systemet 
enligt flaggorna på kommandoraden och konfigurationsinformation i 
\fI/etc/deluser.conf\fP och \fI/etc/adduser.conf\fP.  De är vänligare 
gränssnitt till programmen \fBuserdel\fP och \fBgroupdel\fP, tar bort hemkatalog 
enligt flagga eller även alla filer på systemet som ägs av den användare 
som ska tas bort, kör egendefinierade skript och andra funktioner.  
\fBdeluser\fP och \fBdelgroup\fP kan köras i ett av tre lägen:
.SS "Ta bort en normal användare"
Om startad med ett icke\-flagga\-argument och utan flaggan \fB\-\-group\fP kommer 
\fBdeluser\fP att ta bort en normal användare.

Som standard kommer \fBdeluser\fP att ta bort användaren utan att ta bort 
hemkatalog, post\-spool eller alla andra filer på systemet som ägs av 
användaren. Ta bort hemkatalogen och post\-spool kan göras genom flaggan 
\fB\-\-remove\-home\fP. Om flaggan \fB\-\-home\fP anges kommer deluser bara att ta bort 
användaren om den angivna katalogen till flaggan \fB\-\-home\fP stämmer för 
användarens riktiga hemkatalog.

Flaggan \fB\-\-remove\-all\-files\fP tar bort alla filer på systemet som ägs av 
användaren. Notera att om du aktiverar båda flaggorna kommer 
\fB\-\-remove\-home\fP inte att ha någon effekt därför att alla filer inklusive 
hemkatalogen och post\-spoolen redan täcks in av flaggan 
\fB\-\-remove\-all\-files\fP.

Om du vill säkerhetskopiera alla filerna före de tas bort kan du aktivera 
flaggan \fB\-\-backup\fP som kommer att skapa en fil kallad 
användare.tar(.gz|.bz2) i den katalog som angivits med flaggan 
\fB\-\-backup\-to\fP (standard är till nuvarande katalog). Båda flaggorna för 
borttagning och säkerhetskopiering kan också aktiveras som standard i 
konfigurationsfilen /etc/deluser.conf. Se \fBdeluser.conf(5)\fP för detaljer.

Om filen \fB/usr/local/sbin/deluser.local\fP existerar kommer den att startas 
efter att användarkontot har tagits bort för att göra vissa lokala 
inställningar.  Argumenten som skickas till \fBdeluser.local\fP är:
.br
användarnamn uid gid hemkatalog

.SS "Ta bort en grupp"
Om \fBdeluser\fP startas upp med flagan \fB\-\-group\fP eller om \fBdelgroup\fP startas 
kommer en grupp att tas bort.

Varning: Om några användare har gruppen som ska tas bort som primär grupp 
kan inte gruppen tas bort.

Om flaggan \fB\-\-only\-if\-empty\fP anges kommer gruppen inte att tas bort om den 
har medlemmar kvar.

.SS "Ta bort en användare från en specifik grupp"
Om startad med två icke\-flaggor\-argument kommer \fBdeluser\fP att ta bort en 
användare från en specifik grupp.
.SH FLAGGOR
.TP 
\fB\-\-conf FIL\fP
Använd FIL istället för \fI/etc/deluser.conf\fP.
.TP 
\fB\-\-group\fP
Ta bort en grupp. Detta är standardåtgärden om programmet startas som 
\fIdelgroup\fP.
.TP 
\fB\-\-help\fP
Visa korta instruktioner.
.TP 
\fB\-\-quiet\fP
Visa inte förloppsmeddelanden.
.TP 
\fB\-\-system\fP
Ta endast bort om användare/grupp är en systemanvändare/grupp. Detta 
förhindrar oavsiktliga borttagningar av icke\-systemanvändare/grupper. Om 
användaren inte existerar kommer ingen felkod att returneras. Denna flagga 
är huvudsakligen för användning av Debians pakethanteringsskript.
.TP 
\fB\-\-version\fP
Visa version och information om copyright.
.SH FILER
/etc/deluser.conf
.SH "SE OCKSÅ"
deluser.conf(5), adduser(8), userdel(8), groupdel(8)

.SH �VERS�TTARE
Denna manualsida har �versatts av Daniel Nylander <po@danielnylander.se> 
den 25 november 2005.

Om du hittar n�gra felaktigheter i �vers�ttningen, v�nligen skicka ett 
e-postmeddelande till �vers�ttaren eller till e-postlistan
.nh
<\fIdebian\-l10n\-swedish@lists.debian.org\fR>,
.hy

.SH COPYRIGHT
Copyright (C) 2000 Roland Bauerschmidt. Modifieringar (C) 2004 Marc Haber.  
Denna manualsida och programmet deluser är baserade på adduser som är:
.br
Copyright (C) 1997, 1998, 1999 Guy Maor.
.br
Copyright (C) 1995 Ted Hajek, med en hel del lånat från ursprungliga 
Debian \fBadduser\fP
.br
Copyright (C) 1994 Ian Murdock.  \fBdeluser\fP är fri programvara; se GNU 
General Public Licence version 2 eller senare för villkor för kopiering.  
Det finns \fIingen\fP garanti.
