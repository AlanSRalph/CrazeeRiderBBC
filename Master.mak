\\
\\ Crazee Rider BBC
\\
\\ (C) Kevin Edwards 1987-2018
\\

objstrt%	=&E00
objend%		=&5800	\ End of code, where the Downloader is positioned
objexec%	=&6300	\ Execution address when loaded to &1900 rather than &E00 ( objend% + &1900-&E00 )
modu%		=&400
dowsize%	=&B00
sceaddr%	=&800+modu%+(objend%-objstrt%)+dowsize%

	INCLUDE "src\CONST.6502"
	INCLUDE "src\ZPWORK.6502"
	INCLUDE "src\ABSWORK.6502"
 
	\\ Module Code block ( &960 - &CFF )
	ORG &960
	INCLUDE "src\MODULE.6502"

	\\ Main Code block - source files assembled in the same order as the original
	ORG objstrt%
	INCLUDE "src\INIT.6502"
	INCLUDE "src\SPRITES.6502"
	INCLUDE "src\BIKES.6502"
	INCLUDE "src\OBIKES.6502"
	INCLUDE "src\OBIKES2.6502"
	INCLUDE "src\OBIKES3.6502"
	INCLUDE "src\OBIKES4.6502"
	INCLUDE "src\ROUT1.6502"
	INCLUDE "src\ROUT2.6502"
	INCLUDE "src\ROUT3.6502"
	INCLUDE "src\ROAD1.6502"
	INCLUDE "src\KERB.6502"
	INCLUDE "src\CTRACK.6502"
	INCLUDE "src\UPDATE.6502"
	INCLUDE "src\MROAD.6502"
	INCLUDE "src\TRACK1.6502"
	INCLUDE "src\MINI.6502"
	INCLUDE "src\MUSIC1.6502"
	INCLUDE "src\ROFFSET.6502"
	INCLUDE "src\KERBGRA.6502"
	INCLUDE "src\HIGH.6502"
	INCLUDE "src\END.6502"
	INCLUDE "src\ENDB.6502"
	INCLUDE "src\END2.6502"
	
	objcodeend = P%
	PRINT"Code start  = ",~objstrt%
	PRINT"End of code = ",~objcodeend-1
	PRINT"Length      = ",~objcodeend-objstrt%,"    (",objcodeend-objstrt%,") bytes"
	PRINT"Bytes left  = ",~objend%-objcodeend,"   (",objend%-objcodeend,") bytes"


\\ From Master2
\\ *SAVE ":2.O.MODULE" 6600+3A0 FFFF0960 FFFF0960
\\ *L.:2.O.DOWN 6A00
\\ *SAVE GAME 2000 6D4B FFFF6300 FFFF1900

	\\ Output Object code binaries to the image
	SAVE "O.MODULE", &960, &960 + &3A0, &960, &960

	\\ Include the Downloader binary at its GENUINE load address
	ORG objend%
	INCBIN "O.DOWN"
	
	PRINT "Saving GAME ", ~objstrt%, ~objend% + &400, ~objexec%, ~&1900
	SAVE "GAME", objstrt%, objend% + &400, objexec%, &1900


	\\ Save Main Basic Loader ( gets tokenised first )
	PUTBASIC "bas_extra\LOADER.bas.txt","$.L"

	\\ Put Panel file into final image - see bas_extra\LOADER.bas.txt
	PUTFILE "object\O.NEWPANL", "O.NEWPANL", &7880, &7880

	\\ Copy the Loader into the disk image - generated by the pre-build step
\\	PUTFILE "LoadGam", "$.LoadGam", &700, &700

	\\ Loading screen
	\\	PUTFILE "src\CRSCREEN.IMG", "$.CRSCR", &5800