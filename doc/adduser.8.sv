.\" This file was generated with po4a. Translate the source file.
.\" 
.\" Someone tell emacs that this is an -*- nroff -*- source file.
.\" Copyright 1997, 1998, 1999 Guy Maor.
.\" Adduser and this manpage are copyright 1995 by Ted Hajek,
.\" With much borrowing from the original adduser copyright 1994 by
.\" Ian Murdock.
.\" This is free software; see the GNU General Public License version
.\" 2 or later for copying conditions.  There is NO warranty.
.TH ADDUSER 8 "Version VERSION" "Debian GNU/Linux" 
.SH NAMN
adduser, addgroup \- lägg till en användare eller grupp till systemet
.SH SYNOPSIS
\fBadduser\fP [flaggor] [\-\-home KATALOG] [\-\-shell|\-s SKAL] [\-\-no\-create\-home] 
[\-\-uid ID] [\-\-firstuid ID] [\-\-lastuid ID] [\-\-ingroup GRUPP | \-\-gid ID] 
[\-\-disabled\-password] [\-\-disabled\-login] [\-\-gecos GECOS] användare
.PP
\fBadduser\fP \-\-system [flaggor] [\-\-home KATALOG] [\-\-shell SKAL] 
[\-\-no\-create\-home] [\-\-uid ID] [\-\-group | \-\-ingroup GRUPP | \-\-gid ID] 
[\-\-disabled\-password] [\-\-disabled\-login] [\-\-gecos GECOS] användare
.PP
\fBadduser\fP \-\-group [flaggor] [\-\-gid ID] grupp
.br
\fBaddgroup\fP [flaggor] [\-\-gid ID] grupp
.PP
\fBadduser\fP \-\-group \-\-system [flaggor] [\-\-gid ID] grupp
.br
\fBaddgroup\fP \-\-system [flaggor] [\-\-gid ID] grupp
.PP
\fBadduser\fP [flaggor] användare grupp
.SS "VANLIGA FLAGGOR"
.br
[\-\-quiet] [\-\-debug] [\-\-force\-badname] [\-\-help|\-h] [\-\-version] [\-\-conf FIL]
.SH BESKRIVNING
.PP
\fBadduser\fP och \fBaddgroup\fP lägger till användare och grupper till systemet 
enligt kommandoradens flaggor och konfigurationsinformation i 
\fI/etc/adduser.conf\fP.  De är vänliga gränssnitt till de lågnivåverktyg 
såsom programmen \fBuseradd,\fP \fBgroupadd\fP och \fBusermod\fP, väljer giltiga 
värden för UID och GUI enligt Debians policy, skapar hemkatalogeer med 
skelettkonfiguration, kör egendefinierade skript och andra 
funktioner. \fBadduser\fP och \fBaddgroup\fP kan köras i ett av fem lägen:
.SS "Lägg till en normal användare"
Om startad med ett icke\-flagga\-argument och utan flaggan \fB\-\-system\fP eller 
\fB\-\-group\fP kommer \fBadduser\fP att lägga till en normal användare.

\fBadduser\fP kommer att välja det första tillgängliga UID från omfånget 
som angivits för normala användare i konfigurationsfilen.  UID kan köras 
över med flaggan \fB\-\-uid\fP.

Omfånget som anges i konfigurationsfilen kan köras över med flaggorna 
\fB\-\-firstuid\fP och \fB\-\-lastuid\fP

Som standard ges varje användare i Debian GNU/Linux en motsvarande grupp 
med samma namn och id. Användargrupper tillåter kataloger vara skrivbara 
för grupper som är lätthanterliga genom att placera lämpliga användare 
i nya gruppen, sätta setgid\-biten på katalogen och se till att alla 
användare använder en umask på 002. Om denna funktion är avstängd genom 
att sätta \fBUSERGROUPS\fP till \fIno\fP sätts alla användares GID till 
\fBUSERS_GID\fP.  Användarnas grupper kan också köras över från 
kommandoraden med flaggorna \fB\-\-gid\fP eller \fB\-\-ingroup\fP för att sätta 
grupp genom id eller namn.

\fBadduser\fP kommer att skapa en hemkatalog enligt \fBDHOME\fP, \fBGROUPHOMES\fP och 
\fBLETTERHOMES\fP.  Hemkatalogen kan köras över från kommandoraden med 
flaggan \fB\-\-home\fP och skalet med flaggan \fB\-\-shell\fP. Hemkatalogers 
setgid\-bit är satt om  \fBUSERGROUPS\fP är \fIyes\fP så att alla filer som 
skapas i användarens hemkatalog kommer att ha den korrekta gruppen.

\fBadduser\fP kommer att kopiera filer från \fBSKEL\fP till hemkatalogen och 
fråga efter finger\-information (gecos) och ett lösenord.  Gecos kan också 
sättas med flaggan \fB\-\-gecos\fP. Med flaggan \fB\-\-disabled\-login\fP kommer 
kontot att skapas med stängas av tills ett lösenord är satt. Flaggan 
\fB\-\-disabled\-password\fP kommer inte att sätta ett lösenord men inloggning 
är fortfarande möjlig till exempel genom SSH RSA\-nycklar.

Om filen \fB/usr/local/sbin/adduser.local\fP existerar kommer den att startas 
efter att användarens konto har blivit uppsatt för att göra vissa lokala 
inställningar.  Argumenten som skickas till \fBadduser.local\fP är:
.br
användarnamn uid gid hemkatalog
.br
Miljövariabeln VERBOSE sätts enligt följande regel:
.TP  
0 om \-\-quiet angivs
.TP  
1 om varken \-\-quiet eller \-\-debug är angivna
.TP  
2 om \-\-debug angivs

(Samma gäller för varibeln DEBUG men DEBUG bör inte användas och kommer 
att tas bort i en senare version av adduser.)

.SS "Lägg till en systemanvändare"
Om startad med ett icke\-flagga\-argument och flaggan \fB\-\-system\fP kommer 
\fBadduser\fP att lägga till en systemanvändare. Om en användare med ett UID 
i systemomfånget (eller om uid angivs med den) inte redan existerar kommer 
adduser att avslutas med en varning.

\fBadduser\fP kommer att välja det första tillgängliga UID från omfånget 
som angivits för systemanvändare i konfigurationsfilen.  UID kan köras 
över med flaggan \fB\-\-uid\fP.

Som standard placeras systemanvändare i gruppen \fBnogroup\fP.  För att 
placera den nya systemanvändaren i en redan existerande grupp kan flaggorna 
\fB\-\-gid\fP eller \fB\-\-ingroup\fP användas.  För att placera den nya 
systemanvändaren i en ny grupp med samma ID, använd flaggan \fB\-\-group\fP.

En hemkatalog skapas med samma regler som för normala användare.  Den nya 
systemanvändaren kommer att ha skalet \fI/bin/false\fP (om inte den körs 
över med flaggan \fB\-\-shell\fP) och ha möjligheten för inloggning 
avstängd.  Skelettkonfigurationsfiler kopieras inte.
.SS "Lägg till en användargrupp"
Om \fBadduser\fP kallas upp med flaggan \fB\-\-group\fP och utan flaggan \fB\-\-system\fP 
eller om \fBaddgroup\fP kallas upp respektive kommer en användargrupp att 
läggas till.

Ett GID kommer att väljas från omfånget som angivits för användarnas 
UID i konfigurationsfilen.  GID kan köras över med flaggan \fB\-\-gid\fP.

Gruppen skapas utan några användare.
.SS "Lägg till en systemgrupp"
Om \fBaddgroup\fP kallas upp med flaggan \fB\-\-system\fP kommer en systemgrupp att 
läggas till.

Ett GID kommer att väljas från omfånget som angivits för 
systemanvändarnas UID i konfigurationsfilen.  GID kan köras över med 
flaggan \fB\-\-gid\fP.

Gruppen skapas utan några användare.
.SS "Lägg till en existerande användare till en existerande grupp"
Om startad med två icke\-flaggor\-argument kommer \fBadduser\fP att lägga till 
en existerande användare till en existerande grupp.
.SH FLAGGOR
.TP 
\fB\-\-conf FIL\fP
Använd FIL istället för \fI/etc/adduser.conf\fP.
.TP 
\fB\-\-disabled\-login\fP
Kör inte passwd för att sätta lösenordet.  Användaren kommer inte att 
kunna använda sitt konto tills lösenordet är satt.
.TP 
\fB\-\-disabled\-password\fP
Liknande \-\-disabled\-login men inloggningar är fortfarande möjliga, till 
exempel genom SSH RSA\-nycklar men inte med lösenordautentisering.
.TP 
\fB\-\-force\-badname\fP
Som standard kontrolleras användare och gruppnamn mot ett konfigurerbart 
reguljärt uttryck.  Denna flagga tvingar \fBadduser\fP och \fBaddgroup\fP att 
bara genomföra  en svag kontroll för namnets giltighet.
.TP 
\fB\-\-gecos GECOS\fP
Sätter gecos\-fältet för den nya genereade posten.  adduser kommer inte 
att fråga efter finger\-information om denna flagga anges.
.TP 
\fB\-\-gid ID\fP
När en grupp skapas tvingar denna flagga den nya GID att vara det angivna 
numret.  När en användare skapas kommer denna flagga att sätta 
användaren i den gruppen.
.TP 
\fB\-\-group\fP
När kombinerad med \fB\-\-system\fP kommer en grupp med samma namn och ID som 
systemanvändaren att skapas. Om den inte kombineras med \fB\-\-system\fP kommer 
en grupp med angivet namn att skapas. Detta är standardåtgärden om 
programmet startas som \fBaddgroup\fP.
.TP 
\fB\-\-help\fP
Visa korta instruktioner.
.TP 
\fB\-\-home KATALOG\fP
Använd KATALOG som användarens hemkatalog hellre än det förvalda i 
konfigurationsfilen. Om katalogen inte existerar kommer den skapas och 
skelettfiler kopieras dit.
.TP 
\fB\-\-shell SKAL\fP
Använd SKAL som användarens inloggningsskal hellre än det förvalda i 
konfigurationsfilen.
.TP 
\fB\-\-ingroup GRUPP\fP
Lägg till den nya användaren i GRUPP istället för en användargrupp 
eller den förvalda gruppen definierad av USERS_GID i filen adduser.conf.
.TP 
\fB\-\-no\-create\-home\fP
Skapa inte hemkatalogen även om den inte existerar.
.TP 
\fB\-\-quiet\fP
Visa inte informativa meddelanden, visa endast varningar och fel.
.TP 
\fB\-\-debug\fP
Be verbose, most useful if you want to nail down a problem with adduser.
.TP 
\fB\-\-system\fP
Skapa en systemanvändare.
.TP 
\fB\-\-uid ID\fP
Tvinga det nya användar\-id:t att vara angivet nummer. adduser kommer att 
misslyckas om användar\-id:t redan används.
.TP 
\fB\-\-firstuid ID\fP
Kör över det första UID i omfånget som UID väljs ifrån.
.TP 
\fB\-\-lastuid ID\fP
Kör över det sista UID i omfånget som UID väljs ifrån.
.TP 
\fB\-\-version\fP
Visa version och information om copyright.
.SH FILER
/etc/adduser.conf
.SH "SE OCKSÅ"
adduser.conf(5), deluser(8), useradd(8), groupadd(8), usermod(8), Debian 
Policy 9.2.2.

.SH �VERS�TTARE
Denna manualsida har �versatts av Daniel Nylander <po@danielnylander.se> 
den 25 november 2005.

Om du hittar n�gra felaktigheter i �vers�ttningen, v�nligen skicka ett 
e-postmeddelande till �vers�ttaren eller till e-postlistan
.nh
<\fIdebian\-l10n\-swedish@lists.debian.org\fR>,
.hy

.SH COPYRIGHT
Copyright (C) 1997, 1998, 1999 Guy Maor. Modifieringar av Roland 
Bauerschmidt och Marc Haber.
.br
Copyright (C) 1995 Ted Hajek, med en hel del lånat från ursprungliga 
Debian \fBadduser\fP
.br
Copyright (C) 1994 Ian Murdock.  \fBadduser\fP är fri programvara; se GNU 
General Public Licence version 2 eller senare för villkor för kopiering.  
Det finns \fIingen\fP garanti.
