INCLUDE Irvine32.inc
includelib Winmm.lib

PlaySound PROTO,
    pszsound:PTR byte,hmod:DWORD,fdwsound:DWORD
.data
    bonus byte ".\bonus.wav",0
    clicksound byte ".\click.wav",0
    oversound byte ".\gameover.wav",0
    hitsound byte ".\hit.wav",0
    menusound byte ".\overall.wav",0
    pickdropsound byte ".\pickdrop.wav",0
    soundEnabled byte 1
    gamename byte "          _________               ________                                       _______             _________ ", 0ah
              byte "          |       |  |        |  /             |         |         |         |  /       \  |       | |       |", 0ah
              byte "          |       |  |        |  |             |         |         |         | |         | |       | |       | ", 0ah
              byte "          |       |  |        |   \_________   |_________|         |_________| |         | |       | |       |", 0ah
              byte "          |_______|  |        |             \  |         |         |         | |         | |       | |_______|", 0ah   
              byte "          |       \  |        |             |  |         |         |         | |         | |       | |       \", 0ah
              byte "          |        \  \______/    _________/   |         |         |         |  \_______/   \_____/  |        \", 0
    gameovermsg   byte "           _______        ________                  ________               _______                    ________     _________  ", 0ah
                  byte "          /       \      |        |     |\     /|  |        |             /       \   \          /   |        |    |       |", 0ah
                  byte "         |         |     |        |     |  \  / |  |        |            |         |   \        /    |        |    |       |", 0ah
                  byte "         |               |________|     |   \/  |  |________|            |         |    \      /     |________|    |_______|", 0ah
                  byte "         |      ___      |        |     |       |  |                     |         |     \    /      |             |        \ ", 0ah
                  byte "         |     |   |     |        |     |       |  |                     |         |      \  /       |             |         \ ", 0ah
                  byte "          \___/    |     |        |     |       |  |________              \_______/        \/        |________     |          \", 0
    option1 byte "                                              1. new game",0
    option2 byte "                                              2. Continue game",0
    option3 byte "                                              3. difficulty Level",0
    option4 byte "                                              4. Leader Board",0
    option5 byte "                                              5. Instructions",0
    option6 byte "                                              6. Exit",0
    menumsg byte "                                             Select an option (1-6): ",0
    invalidmsg byte "                                          Invalid choice! Press any key to continue...",0
    difficultymsg byte "                                               Current difficulty: ",0
    easylevel byte "Easy",0
    mediumlevel byte "Medium",0
    hardlevel byte "Hard",0
    difficultyoptions byte "                                              1. Easy",0Dh,0Ah,"                                              2. Medium",0Dh,0Ah,"                                              3. Hard",0Dh,0Ah,"                                              Select difficulty: ",0
    taxicolormsg byte "                                              SELECT TAxI COLOR",0
    redcolor byte "                                              1. Red taxi",0
    yellowcolor byte "                                              2. yellow taxi",0  
    randomcolor byte "                                              3. random Color",0
    selectcolormsg byte "                                              Choose taxi color (1-3): ",0
    currentcolormsg byte "                                               Current taxi: ",0
    redcolormsg byte "Red taxi",0
    yellowcolormsg byte "yellow taxi",0
    playernamemsg byte "                                              Enter your playername: ",0
    playername byte 4 DUP(0)
    gamemodemsg byte "                                              SELECT GAME MODE",0
    mode1 byte "                                              1. Career Mode",0
    mode2 byte "                                              2. time Mode",0
    mode3 byte "                                              3. Endless Mode",0
    selectmodemsg byte "                                              Select game mode (1-3): ",0
    currentmodemsg byte "                                               Current Mode: ",0
    careermode byte "Career Mode",0
    timemode byte "time Mode",0
    infinitymode byte "Endless Mode",0
    instructionmsg byte "=== RUSH HOUR GAME INSTRUCTIONS ===",0Dh,0Ah
                  byte "1. Arrow Keys for taxi movement",0Dh,0Ah
                  byte "2. Press space to pickup the passenger",0Dh,0Ah
                  byte "3. D is the destinationination where the passenger is to be dropped off",0Dh,0Ah
                  byte "4. Space to drop the passenger",0Dh,0Ah
                  byte "5. Avoid trees, building and npc cars",0Dh,0Ah
                  byte "6. CCollect bonuses",0Dh,0Ah
                  byte "8. Press P to pause",0Dh,0Ah
                  byte "9. Press esc to return",0Dh,0Ah,0
    leaderboardmsg byte "TOP 10 SCORES",0
    notleaderboard byte "No scores yet! play some games first.",0
    highscorefile byte "highscores.txt",0
    filehandle DWORD ?
    gameInstructions byte "Arrow Keys: move | Space: pickup/drop | P: Pause | ESC: Menu",0
    pausedmsg byte "GAME PAUSED",0Dh,0Ah,"Press P to resume or ESC to quit",0
    timemsg byte "time: ",0
    deliveriesmsg byte "deliveries: ",0
    collisionmsg byte "collision: ",0
    bonusmsg byte "bonus collected",0
    currentdifficulty byte 1
    currentcolor byte 1
    currentmode byte 1
    gamesaved byte 0
    playernameentered byte 0
    gameactive byte 1
    gamespeed DWORD 100
    npcspeed DWORD 20
    boardsize=400
    board byte boardsize DUP('.')
    taxix byte 2
    taxiy byte 2
    previousx byte 2
    previousy byte 2
    buildingsymbol byte '#'
    treesymbol byte 'T'
    bonussymbol byte '$'
    maxpassengers=5
    passengeractive byte maxpassengers DUP(0)
    passengerx byte maxpassengers DUP(0)
    passengery byte maxpassengers DUP(0)
    destinationx byte maxpassengers DUP(0)
    destinationy byte maxpassengers DUP(0)
    currentpassenger byte -1
    totalpassengers byte 0
    deliveriesmade byte 0
    maxnpccars=8
    npcactive byte maxnpccars DUP(0)
    npcx byte maxnpccars DUP(0)
    npcy byte maxnpccars DUP(0)
    npcdirection byte maxnpccars DUP(0)
    npcsymbol byte 'C'
    maxtrees=10
    treex byte maxtrees DUP(0)
    treey byte maxtrees DUP(0)
    maxbonus=5
    bonusactive byte maxbonus DUP(0)
    bonusx byte maxbonus DUP(0)
    bonusy byte maxbonus DUP(0)
    score DWORD 0
    scoremsg byte "score: ",0
    initialtime DWORD 120
    gametimer DWORD 0
    npcmovetimer DWORD 0
    maxscores=10
    highscoress DWORD maxscores DUP(0)
    highscoresnames byte maxscores*4 DUP(0)
.code
main PROC
    call randomize
    call loadleaderboard
    call playmenusound
    call mainMenu
    exit
main ENDP
;sound
PlaySoundfile PROC
    pushad
    INVOKE PlaySound,edx,NULL,1
    popad
    ret
PlaySoundfile ENDP
playbonussound PROC
    cmp soundEnabled,1
    jne skipbonussound
    pushad
    mov edx,OFFSET bonus
    call PlaySoundfile
    popad
skipbonussound:
    ret
playbonussound ENDP
playpickdropsound PROC
    cmp soundEnabled,1
    jne skippickdropsound
    pushad
    mov edx,OFFSET pickdropsound
    call PlaySoundfile
    popad
skippickdropsound:
    ret
playpickdropsound ENDP
playclicksound PROC
    cmp soundEnabled,1
    jne skipClicksound
    pushad
    mov edx,OFFSET clicksound
    call PlaySoundfile
    popad
skipClicksound:
    ret
playclicksound ENDP
playgameoversound PROC
    cmp soundEnabled,1
    jne skipgameoversound
    pushad
    mov edx,OFFSET oversound
    call PlaySoundfile
    popad
skipgameoversound:
    ret
playgameoversound ENDP
playhitsound PROC
    cmp soundEnabled,1
    jne skiphitsound
    pushad
    mov edx,OFFSET hitsound
    call PlaySoundfile
    popad
skiphitsound:
    ret
playhitsound ENDP
playmenusound PROC
    cmp soundEnabled,1
    jne skipmenusound
    pushad
    mov edx,OFFSET menusound
    call PlaySoundfile
    popad
skipmenusound:
    ret
playmenusound ENDP
;leaderboard
loadleaderboard PROC
    mov edx,OFFSET highscorefile
    call OpenInputfile
    cmp eax,INVALID_HANDLE_VALUE
    je createnewfile
    
    mov filehandle, eax
    mov edx,OFFSET highscoress
    mov ecx,maxscores*4
    call ReadFromfile
    mov edx,OFFSET highscoresnames
    mov ecx,maxscores*4
    call ReadFromfile
    mov eax,filehandle
    call Closefile
    ret
createnewfile:
    mov edx,OFFSET highscorefile
    call CreateOutputfile
    mov filehandle, eax
    call Closefile
    ret
loadleaderboard ENDP
Saveleaderboard PROC
    mov edx,OFFSET highscorefile
    call CreateOutputfile
    mov filehandle,eax
    
    mov edx,OFFSET highscoress
    mov ecx,maxscores*4
    call Writetofile
    
    mov edx,OFFSET highscoresnames
    mov ecx,maxscores*4
    call Writetofile
    
    mov eax,filehandle
    call Closefile
    ret
Saveleaderboard ENDP
updateleaderboard PROC
    mov esi,0
    mov ecx,maxscores
checkscoreloop:
    mov eax,score
    cmp eax,highscoress[esi*4]
    jg insertnewscore
    inc esi
    loop checkscoreloop
    ret
insertnewscore:
    mov edi,maxscores-1
shiftscoresloop:
    cmp edi,esi
    jle shiftnamesloop
    mov eax,edi
    sub eax,1
    mov ebx,highscoress[eax*4]
    mov highscoress[edi*4],ebx
    
    dec edi
    jmp shiftscoresloop
    
shiftnamesloop:
    mov edi,maxscores-1
shiftnames:
    cmp edi,esi
    jle insertnewEntry
    mov eax,edi
    sub eax,1
    
    mov ebx,DWORD PTR highscoresnames[eax*4]
    mov DWORD PTR highscoresnames[edi*4], ebx
    
    dec edi
    jmp shiftnames
insertnewEntry:
    mov eax,score
    mov highscoress[esi*4],eax
    
    mov al,playername[0]
    mov highscoresnames[esi*4],al
    mov al,playername[1]
    mov highscoresnames[esi*4+1],al
    mov al,playername[2]
    mov highscoresnames[esi*4+2],al
    mov byte PTR highscoresnames[esi*4+3],' '
    
    call Saveleaderboard
    ret
updateleaderboard ENDP
;menu
mainMenu PROC
menuloop:
    call Clrscr
    mov eax,lightCyan
    call SetTextColor
    mov edx,OFFSET gamename
    call WriteString
    call Crlf
    call Crlf
    call Crlf
    call Crlf
    call Crlf
    mov eax,white
    call SetTextColor
    mov edx,OFFSET option1
    call WriteString
    call Crlf
    
    mov edx,OFFSET option2
    call WriteString
    call Crlf
    
    cmp gamesaved,1
    jne showOption3
    mov eax,green
    call SetTextColor
showOption3:
    mov edx,OFFSET option3
    call WriteString
    call Crlf
    
    mov eax,white
    call SetTextColor
    mov edx,OFFSET option4
    call WriteString
    call Crlf
    
    mov edx,OFFSET option5
    call WriteString
    call Crlf
    
    mov edx,OFFSET option6
    call WriteString
    call Crlf
    call Crlf
    
    mov edx,OFFSET difficultymsg
    call WriteString
    call displaydifficulty
    call Crlf
    
    mov edx,OFFSET currentcolormsg
    call WriteString
    call displaytaxiColor
    call Crlf
    
    mov edx,OFFSET currentmodemsg
    call WriteString
    call displaygameMode
    call Crlf
    call Crlf
    
    mov edx,OFFSET menumsg
    call WriteString
    
    call ReadChar
    call WriteChar
    call Crlf
    
    cmp al,'1'
    je startnewgame
    cmp al,'2'
    je continuegame
    cmp al,'3'
    je changedifficulty
    cmp al,'4'
    je viewleaderboard
    cmp al,'5'
    je showInstructions
    cmp al,'6'
    je exitProgram
    
    mov edx,OFFSET invalidmsg
    call WriteString
    call ReadChar
    jmp menuloop
startnewgame:
    call playclicksound
    call GetplayerName
    call SelecttaxiColor
    call SelectgameMode
    call initializegame
    mov gamesaved,1
    call maingameloop
    jmp menuloop
continuegame:
    call playclicksound
    cmp gamesaved,1
    jne noSavedgame
    call maingameloop
    jmp menuloop
noSavedgame:
    mov edx,OFFSET invalidmsg
    call WriteString
    call ReadChar
    jmp menuloop
changedifficulty:
    call playclicksound
    call ChangedifficultyMenu
    jmp menuloop
viewleaderboard:
    call playclicksound
    call Showleaderboard
    jmp menuloop
showInstructions:
    call playclicksound
    call ShowInstructions
    jmp menuloop
exitProgram:
    call playclicksound
    ret
mainMenu ENDP
GetplayerName PROC
    call Clrscr
    mov eax,yellow
    call SetTextColor
    mov edx,OFFSET gamename
    call WriteString
    call Crlf
    call Crlf
    call Crlf
    call Crlf
    call Crlf
    mov edx,OFFSET playernamemsg
    call WriteString
    mov ecx,3
    mov esi,OFFSET playername
playernameInputloop:
    call ReadChar
    call playclicksound
    call WriteChar
    mov [esi],al
    inc esi
    loop playernameInputloop
    mov byte PTR [esi],0
    mov playernameentered,1
    call Crlf
    ret
GetplayerName ENDP
SelecttaxiColor PROC
    call Clrscr
    mov eax,yellow
    call SetTextColor
    mov edx,OFFSET gamename
    call WriteString
    call Crlf
    call Crlf
    call Crlf
    call Crlf
    call Crlf
    mov edx,OFFSET taxicolormsg
    call WriteString
    call Crlf
    call Crlf
    mov eax,white
    call SetTextColor
    mov edx,OFFSET redcolor
    call WriteString
    call Crlf
    mov edx,OFFSET yellowcolor
    call WriteString
    call Crlf
    mov edx,OFFSET randomcolor
    call WriteString
    call Crlf
    call Crlf
    mov edx,OFFSET selectcolormsg
    call WriteString
    call ReadChar
    call WriteChar
    call Crlf
    cmp al,'1'
    je setRedColor
    cmp al,'2'
    je setyellowColor
    cmp al,'3'
    je setrandomColor
    mov currentcolor,1
    call playclicksound
    ret
setRedColor:
    mov currentcolor,1
    call playclicksound
    ret
setyellowColor:
    mov currentcolor,2
    call playclicksound
    ret
setrandomColor:
    mov eax,2
    call randomRange
    add eax,1
    mov currentcolor,al
    call playclicksound
    ret
SelecttaxiColor ENDP
SelectgameMode PROC
    call Clrscr
    mov eax,lightGreen
    call SetTextColor
    mov edx,OFFSET gamename
    call WriteString
    call Crlf
    call crlf
    mov edx,OFFSET gamemodemsg
    call WriteString
    call Crlf
    call Crlf
    mov eax,white
    call SetTextColor
    mov edx,OFFSET mode1
    call WriteString
    call Crlf
    mov edx,OFFSET mode2
    call WriteString
    call Crlf
    
    mov edx,OFFSET mode3
    call WriteString
    call Crlf
    call Crlf
    
    mov edx,OFFSET selectmodemsg
    call WriteString
    
    call ReadChar
    call WriteChar
    call Crlf
    
    cmp al,'1'
    je setCareerMode
    cmp al,'2'
    je settimeMode
    cmp al,'3'
    je setEndlessMode
    
    mov currentmode,1
    call playclicksound
    ret
setCareerMode:
    mov currentmode,1
    call playclicksound
    ret
settimeMode:
    mov currentmode,2
    call playclicksound
    ret
setEndlessMode:
    mov currentmode,3
    call playclicksound
    ret
SelectgameMode ENDP
displaytaxiColor PROC
    cmp currentcolor,1
    jne showyellowtaxi
    mov eax,lightRed
    call SetTextColor
    mov edx,OFFSET redcolormsg
    call WriteString
    ret
showyellowtaxi:
    mov eax,yellow
    call SetTextColor
    mov edx,OFFSET yellowcolormsg
    call WriteString
    ret
displaytaxiColor ENDP
displaygameMode PROC
    cmp currentmode,1
    jne checktimeMode
    mov eax,lightGreen
    call SetTextColor
    mov edx,OFFSET careermode
    call WriteString
    ret
checktimeMode:
    cmp currentmode,2
    jne showEndlessMode
    mov eax,lightBlue
    call SetTextColor
    mov edx,OFFSET timemode
    call WriteString
    ret
showEndlessMode:
    mov eax,lightMagenta
    call SetTextColor
    mov edx,OFFSET infinitymode
    call WriteString
    ret
displaygameMode ENDP
displaydifficulty PROC
    mov eax,yellow
    call SetTextColor
    cmp currentdifficulty,1
    jne checkMedium
    mov edx,OFFSET easylevel
    call WriteString
    ret
checkMedium:
    cmp currentdifficulty,2
    jne checkHard
    mov edx,OFFSET mediumlevel
    call WriteString
    ret
checkHard:
    mov edx,OFFSET hardlevel
    call WriteString
    ret
displaydifficulty ENDP
ChangedifficultyMenu PROC
    call Clrscr
    mov eax,lightCyan
    call SetTextColor
    mov edx,OFFSET gamename
    call WriteString
    call Crlf
    call Crlf
    call Crlf
    call Crlf
    call Crlf
    mov edx,OFFSET difficultyoptions
    call WriteString
    call ReadChar
    call WriteChar
    call Crlf
    cmp al,'1'
    je setEasy
    cmp al,'2'
    je setMedium
    cmp al,'3'
    je setHard
    mov edx,OFFSET invalidmsg
    call WriteString
    call ReadChar
    ret
setEasy:
    mov currentdifficulty,1
    call playclicksound
    ret
setMedium:
    mov currentdifficulty,2
    call playclicksound
    ret
setHard:
    mov currentdifficulty,3
    call playclicksound
    ret
ChangedifficultyMenu ENDP
Showleaderboard PROC
    call Clrscr
    mov eax,lightCyan
    call SetTextColor
    mov edx,OFFSET leaderboardmsg
    call WriteString
    call Crlf
    call Crlf
    
    mov eax,white
    call SetTextColor
    mov eax,highscoress[0]
    cmp eax,0
    jne displayscores
    mov edx,OFFSET notleaderboard
    call WriteString
    jmp donedisplaying
displayscores:
    mov esi,0
    mov ecx,maxscores
displayscoreloop:
    mov eax,highscoress[esi*4]
    cmp eax,0
    je nextscoreEntry
    mov eax,esi
    add eax,1
    call WriteDec
    mov al,'.'
    call WriteChar
    mov al,' '
    call WriteChar
    mov al,highscoresnames[esi*4]
    call WriteChar
    mov al,highscoresnames[esi*4+1]
    call WriteChar
    mov al,highscoresnames[esi*4+2]
    call WriteChar
    mov al,' '
    call WriteChar
    mov al,'-'
    call WriteChar
    mov al,' '
    call WriteChar
    mov eax,highscoress[esi*4]
    call WriteDec
    call Crlf
nextscoreEntry:
    inc esi
    loop displayscoreloop
donedisplaying:
    call Crlf
    call ReadChar
    ret
Showleaderboard ENDP
ShowInstructions PROC
    call Clrscr
    mov eax, lightCyan
    call SetTextColor
    mov edx, OFFSET instructionmsg
    call WriteString
    call Crlf
    call Crlf
    call ReadChar
    ret
ShowInstructions ENDP
;game
initializegame PROC
    mov taxix,2
    mov taxiy,2
    mov previousx,2
    mov previousy,2
    mov score,0
    mov currentpassenger,-1
    mov deliveriesmade,0
    mov initialtime,60
    mov gameactive,1
    mov gametimer,0
    mov gamespeed,100
    mov npcspeed,20
    mov npcmovetimer,0
    mov ecx,boardsize
    mov esi,0
    mov al,'.'
initializeBoardloop:
    mov board[esi],al
    inc esi
    loop initializeBoardloop
    mov ecx,20
    mov esi,0
createtopBorder:
    mov board[esi],'#'
    mov board[esi+380],'#'
    inc esi
    loop createtopBorder
    mov ecx,18
    mov esi,20
createSideBorders:
    mov board[esi],'#'
    mov board[esi+19],'#'
    add esi, 20
    loop createSideBorders
    mov ecx, 15
addrandomBuildings:
    call AddrandomBuilding
    loop addrandomBuildings
    mov ecx,maxtrees
addtrees:
    call Addrandomtree
    loop addtrees
    mov ecx,maxnpccars
addnpcs:
    call Addrandomnpc
    loop addnpcs
    mov ecx,maxbonus
addbonuses:
    call Addrandombonus
    loop addbonuses
    call initializepassengers
    ret
initializegame ENDP
AddrandomBuilding PROC
    push ecx
tryrandomposition:
    mov eax,18
    call randomRange
    add eax,2
    mov bl,al
    mov eax,18
    call randomRange
    add eax,2
    mov bh,al
    movzx eax,bh
    mov edx,20
    mul edx
    movzx edx,bl
    add eax,edx
    cmp board[eax],'#'
    je tryrandomposition
    cmp bl,2
    jne placenewBuilding
    cmp bh,2
    je tryrandomposition
placenewBuilding:
    mov board[eax],'#'
    pop ecx
    ret
AddrandomBuilding ENDP
Addrandomtree PROC
    push ecx
trytreeposition:
    mov eax,18
    call randomRange
    add eax,2
    mov bl,al
    mov eax,18
    call randomRange
    add eax,2
    mov bh,al
    movzx eax,bh
    mov edx,20
    mul edx
    movzx edx,bl
    add eax,edx
    cmp board[eax],'#'
    je trytreeposition
    cmp board[eax],'T'
    je trytreeposition
    cmp bl,2
    jne placenewtree
    cmp bh,2
    je trytreeposition
placenewtree:
    mov board[eax],'T'
    mov eax,maxtrees
    sub eax,ecx
    mov treex[eax],bl
    mov treey[eax],bh
    pop ecx
    ret
Addrandomtree ENDP
Addrandomnpc PROC
    push ecx
trynpcposition:
    mov eax,18
    call randomRange
    add eax,2
    mov bl,al
    mov eax,18
    call randomRange
    add eax,2
    mov bh,al
    movzx eax,bh
    mov edx,20
    mul edx
    movzx edx,bl
    add eax,edx
    cmp board[eax],'#'
    je trynpcposition
    cmp board[eax],'T'
    je trynpcposition
    cmp board[eax],'C'
    je trynpcposition
    cmp bl,2
    jne placenewnpc
    cmp bh,2
    je trynpcposition
placenewnpc:
    mov board[eax],'C'
    mov eax,maxnpccars
    sub eax,ecx
    mov npcactive[eax],1
    mov npcx[eax],bl
    mov npcy[eax],bh
    mov eax,4
    call randomRange
    mov ebx,maxnpccars
    sub ebx,ecx
    mov npcdirection[ebx],al
    pop ecx
    ret
Addrandomnpc ENDP
Addrandombonus PROC
    push ecx
trybonusposition:
    mov eax,18
    call randomRange
    add eax,2
    mov bl,al
    mov eax,18
    call randomRange
    add eax,2
    mov bh,al
    movzx eax,bh
    mov edx,20
    mul edx
    movzx edx,bl
    add eax,edx
    cmp board[eax],'#'
    je trybonusposition
    cmp board[eax],'T'
    je trybonusposition
    cmp board[eax],'C'
    je trybonusposition
    cmp board[eax],'$'
    je trybonusposition
    cmp bl,2
    jne placenewbonus
    cmp bh,2
    je trybonusposition
placenewbonus:
    mov board[eax],'$'
    mov eax,maxbonus
    sub eax,ecx
    mov bonusactive[eax],1
    mov bonusx[eax],bl
    mov bonusy[eax],bh
    pop ecx
    ret
Addrandombonus ENDP
initializepassengers PROC
    mov eax,3
    call randomRange
    add eax,3
    mov totalpassengers,al
    movzx ecx,totalpassengers
    mov esi,0
initializepassengerloop:
    mov passengeractive[esi],1
    call FindValidpassengerposition
    mov passengerx[esi],al
    mov passengery[esi],ah
    call FindValidDestinationposition
    mov destinationx[esi],al
    mov destinationy[esi],ah
    inc esi
    loop initializepassengerloop
    ret
initializepassengers ENDP
FindValidpassengerposition PROC
findpassengerposition:
    mov eax,18
    call randomRange
    add eax,2
    mov bl,al
    mov eax,18
    call randomRange
    add eax,2
    mov bh,al
    movzx eax,bh
    mov edx,20
    mul edx
    movzx edx,bl
    add eax,edx
    cmp board[eax],'#'
    je findpassengerposition
    cmp board[eax],'T'
    je findpassengerposition
    cmp board[eax],'C'
    je findpassengerposition
    cmp board[eax],'$'
    je findpassengerposition
    cmp bl,2
    jne validpassengerSpot
    cmp bh,2
    je findpassengerposition
validpassengerSpot:
    mov al,bl
    mov ah,bh
    ret
FindValidpassengerposition ENDP
FindValidDestinationposition PROC
findDestinationposition:
    mov eax,18
    call randomRange
    add eax,2
    mov bl,al
    mov eax,18
    call randomRange
    add eax,2
    mov bh,al
    movzx eax,bh
    mov edx,20
    mul edx
    movzx edx,bl
    add eax,edx
    cmp board[eax],'#'
    je findDestinationposition
    cmp board[eax],'T'
    je findDestinationposition
    cmp board[eax],'C'
    je findDestinationposition
    mov al,passengerx[esi]
    cmp bl,al
    jne validDestinationSpot
    mov al,passengery[esi] 
    cmp bh,al
    je findDestinationposition
validDestinationSpot:
    mov al,bl
    mov ah,bh
    ret
FindValidDestinationposition ENDP
;collision
checkcollision PROC
    movsx eax,taxix
    add eax,ebx
    movsx edx,taxiy
    add edx,ecx
    mov esi,edx
    imul esi,20
    add esi,eax
    mov al,board[esi]
    cmp al,'#'
    je buildingcollision
    cmp al,'T'
    je treecollision
    cmp al,'C'
    je carcollision
    cmp al,'$'
    je bonusCollection
    clc
    ret
buildingcollision:
    stc
    ret
treecollision:
    cmp currentcolor,1
    jne yellowtreePenalty
    sub score,2
    jmp showtreecollision
yellowtreePenalty:
    sub score,4
showtreecollision:
    call ShowcollisionMessage
    stc
    ret
carcollision:
    cmp currentcolor,1
    jne yellowCarPenalty
    sub score,3
    jmp showCarcollision
yellowCarPenalty:
    sub score,2
showCarcollision:
    call ShowcollisionMessage
    stc
    ret
bonusCollection:
    add score,10
    mov board[esi],'.'
    call ShowbonusMessage
    clc
    ret
checkcollision ENDP
ShowcollisionMessage PROC
    pushad
    call playhitsound
    mov dh,32
    mov dl,2
    call Gotoxy
    mov eax,lightRed+(red*16)
    call SetTextColor
    mov edx,OFFSET collisionmsg
    call WriteString
    mov eax,lightRed
    call SetTextColor
    mov eax,2
    call WriteDec
    mov eax, 800
    call delay
    mov dh,32
    mov dl,2
    call Gotoxy
    mov ecx,35
    mov al,' '
clearMessageloop:
    call WriteChar
    loop clearMessageloop
    popad
    ret
ShowcollisionMessage ENDP
ShowbonusMessage PROC
    pushad
    call playbonussound
    mov dh,32
    mov dl,2
    call Gotoxy
    mov eax,yellow+(green*16)
    call SetTextColor
    mov edx,OFFSET bonusmsg
    call WriteString
    mov eax,800
    call delay
    mov dh,32
    mov dl,2
    call Gotoxy
    mov ecx,35
    mov al,' '
clearbonusmsg:
    call WriteChar
    loop clearbonusmsg
    popad
    ret
ShowbonusMessage ENDP
;npc casr
movenpcs PROC
    inc npcmovetimer
    mov eax,npcmovetimer
    cmp eax,npcspeed
    jl skipnpcmovement
    mov npcmovetimer,0
    push esi
    push edi
    mov esi,0
npcloop:
    cmp esi,maxnpccars
    jge allnpcsmoved
    cmp npcactive[esi],1
    jne nextnpc
    movzx ebx,npcx[esi]
    movzx ecx,npcy[esi]
    push ebx
    push ecx
    mov eax,ecx
    mov edx,20
    mul edx
    add eax,ebx
    cmp board[eax],'C'
    jne skipclear
    mov board[eax],'.'
    mov dh,cl
    add dh,11
    mov dl,bl
    shl dl,1
    add dl,2
    call Gotoxy
    mov eax,ecx
    mov edx,20
    mul edx
    add eax,ebx
    mov al,board[eax]
    cmp al,'#'
    je redrawoldBuilding
    cmp al,'T'
    je redrawoldtree
    cmp al,'$'
    je redrawoldbonus
    jmp redrawoldroad
redrawoldBuilding:
    mov eax,white+(gray*16)
    call SetTextColor
    mov al,'#'
    call WriteChar
    mov al,'#'
    call WriteChar
    jmp skipclear
redrawoldtree:
    mov eax,lightGreen+(green*16)
    call SetTextColor
    mov al,'^'
    call WriteChar
    mov eax,brown
    call SetTextColor
    mov al,'|'
    call WriteChar
    jmp skipclear
redrawoldbonus:
    mov eax,yellow+(yellow*16)
    call SetTextColor
    mov al,'*'
    call WriteChar
    mov eax,yellow
    call SetTextColor
    mov al,'$'
    call WriteChar
    jmp skipclear
redrawoldroad:
    mov eax,gray+(white*16)
    call SetTextColor
    mov al,'.'
    call WriteChar
    mov al,' '
    call WriteChar
skipclear:
    pop ecx
    pop ebx
    movzx edx,npcdirection[esi]
    cmp dl,0
    je moveright
    cmp dl,1
    je moveleft
    cmp dl,2
    je moveDown
    jmp moveUp
moveright:
    inc bl
    cmp bl,18
    jle checknewPos
    mov bl,2
    jmp checknewPos
moveleft:
    dec bl
    cmp bl,2
    jge checknewPos
    mov bl,18
    jmp checknewPos
moveDown:
    inc cl
    cmp cl,18
    jle checknewPos
    mov cl,2
    jmp checknewPos
moveUp:
    dec cl
    cmp cl,2
    jge checknewPos
    mov cl,18
checknewPos:
    push ebx
    push ecx
    movzx eax,cl
    mov edx,20
    mul edx
    movzx edx,bl
    add eax,edx
    mov dl,board[eax]
    pop ecx
    pop ebx
    cmp dl,'#'
    je changedirection
    cmp dl,'T'
    je changedirection
    cmp dl,'C'
    je changedirection
    cmp bl,taxix
    jne positionValid
    cmp cl,taxiy
    je changedirection
positionValid:
    mov npcx[esi],bl
    mov npcy[esi],cl
    movzx eax,cl
    mov edx,20
    mul edx
    movzx edx,bl
    add eax,edx
    mov board[eax],'C'
    mov dh,cl
    add dh,11
    mov dl,bl
    shl dl,1
    add dl,2
    call Gotoxy
    mov eax,lightGray+(gray*16)
    call SetTextColor
    mov al,'['
    call WriteChar
    mov al,']'
    call WriteChar
    jmp nextnpc
changedirection:
    push esi
    push ebx
    push ecx
    mov edi,4
trynewdirection:
    push edi
    mov eax,4
    call randomRange
    mov npcdirection[esi],al
    pop edi
    push edi
    mov bl,npcx[esi]
    mov cl,npcy[esi]
    movzx edx,npcdirection[esi]
    cmp dl,0
    je testright
    cmp dl,1
    je testleft
    cmp dl,2
    je testDown
    jmp testUp
testright:
    inc bl
    cmp bl,18
    jle testPos
    mov bl,2
    jmp testPos
testleft:
    dec bl
    cmp bl,2
    jge testPos
    mov bl,18
    jmp testPos
testDown:
    inc cl
    cmp cl,18
    jle testPos
    mov cl,2
    jmp testPos
testUp:
    dec cl
    cmp cl,2
    jge testPos
    mov cl,18
testPos:
    push ebx
    push ecx
    movzx eax,cl
    mov edx,20
    mul edx
    movzx edx,bl
    add eax,edx
    mov dl,board[eax]
    pop ecx
    pop ebx
    cmp dl,'#'
    je tryNextDir
    cmp dl,'T'
    je tryNextDir
    cmp dl,'C'
    je tryNextDir
    cmp bl,taxix
    jne directionFound
    cmp cl,taxiy
    je tryNextDir
directionFound:
    mov npcx[esi],bl
    mov npcy[esi],cl
    movzx eax,cl
    mov edx,20
    mul edx
    movzx edx,bl
    add eax,edx
    mov board[eax],'C'
    mov dh,cl
    add dh,11
    mov dl,bl
    shl dl,1
    add dl,2
    call Gotoxy
    mov eax,lightGray+(gray*16)
    call SetTextColor
    mov al,'['
    call WriteChar
    mov al,']'
    call WriteChar
    pop edi
    pop ecx
    pop ebx
    pop esi
    jmp nextnpc
tryNextDir:
    pop edi
    dec edi
    jnz trynewdirection
    pop ecx
    pop ebx
    mov npcx[esi],bl
    mov npcy[esi],cl
    movzx eax,cl
    mov edx,20
    mul edx
    movzx edx,bl
    add eax,edx
    mov board[eax],'C'
    pop esi
nextnpc:
    inc esi
    jmp npcloop
allnpcsmoved:
    pop edi
    pop esi
    mov eax,white+(black*16)
    call SetTextColor
skipnpcmovement:
    ret
movenpcs ENDP
;speed high
checkspeedincrease PROC
    mov al,deliveriesmade
    test al,1
    jnz nospeedincrease
    cmp npcspeed,5
    jle nospeedincrease
    dec npcspeed
    cmp currentcolor,2
    jne nospeedincrease
    cmp gamespeed,50
    jle nospeedincrease
    sub gamespeed,10
nospeedincrease:
    ret
checkspeedincrease ENDP
;passenger
checkpassengeratposition PROC
    pushad
    mov edx,0
checkeachpassenger:
    cmp passengeractive[edx],1
    jne nextpassengercheck
    mov al,passengerx[edx]
    cmp al,bl
    jne nextpassengercheck
    mov al,passengery[edx] 
    cmp al,cl
    jne nextpassengercheck
    popad
    stc
    ret
nextpassengercheck:
    inc edx
    cmp edx,maxpassengers
    jl checkeachpassenger
    popad
    clc
    ret
checkpassengeratposition ENDP
checkDestinationatposition PROC
    pushad
    cmp currentpassenger,-1
    je noDestinationFound
    mov edx,0
    mov dl,currentpassenger
    mov al,destinationx[edx]
    cmp al,bl
    jne noDestinationFound
    mov al,destinationy[edx] 
    cmp al,cl
    jne noDestinationFound
    popad
    stc
    ret
noDestinationFound:
    popad
    clc
    ret
checkDestinationatposition ENDP
checkpassengeratoldposition PROC
    pushad
    mov edx,0
checkoldpassengerPos:
    cmp passengeractive[edx],1
    jne nextoldpassenger
    mov al,passengerx[edx]
    cmp al,bl
    jne nextoldpassenger
    mov al,passengery[edx] 
    cmp al,cl
    jne nextoldpassenger
    popad
    stc
    ret
nextoldpassenger:
    inc edx
    cmp edx,maxpassengers
    jl checkoldpassengerPos
    popad
    clc
    ret
checkpassengeratoldposition ENDP
checkDestinationatoldposition PROC
    pushad
    cmp currentpassenger,-1
    je nooldDestination
    mov edx,0
    mov dl,currentpassenger
    mov al,destinationx[edx]
    cmp al,bl
    jne nooldDestination
    mov al,destinationy[edx] 
    cmp al,cl
    jne nooldDestination
    popad
    stc
    ret
nooldDestination:
    popad
    clc
    ret
checkDestinationatoldposition ENDP
;draw
  drawinitialscreen PROC
    call Clrscr
    mov eax,lightCyan
    call SetTextColor
    mov edx,OFFSET gamename
    call WriteString
    call Crlf
    mov dl,0
    mov dh,8
    call Gotoxy
    mov eax,yellow
    call SetTextColor
    mov edx,OFFSET scoremsg
    call WriteString
    mov eax,score
    call WriteDec
    cmp currentmode,2
    jne checkCareerMode
    mov dl,20
    mov dh,8
    call Gotoxy
    mov eax,lightBlue
    call SetTextColor
    mov edx,OFFSET timemsg
    call WriteString
    mov eax,initialtime
    call WriteDec
    jmp showgameInstructions
checkCareerMode:
    cmp currentmode,1
    jne showgameInstructions
    mov dl,20
    mov dh,8
    call Gotoxy
    mov eax,lightGreen
    call SetTextColor
    mov edx,OFFSET deliveriesmsg
    call WriteString
    movzx eax,deliveriesmade
    call WriteDec
    mov al,'/'
    call WriteChar
    movzx eax,totalpassengers
    call WriteDec    
showgameInstructions:
    mov dl,0
    mov dh,9
    call Gotoxy
    mov eax,white
    call SetTextColor
    mov edx,OFFSET gameInstructions
    call WriteString
    call Crlf
    mov dl,0
    mov dh,10
    call Gotoxy
    mov eax,lightCyan
    call SetTextColor
    mov al,'+'
    call WriteChar
    mov ecx,40
drawtopBorder:
    mov al,'='
    call WriteChar
    loop drawtopBorder
    mov al,'+'
    call WriteChar
    call Crlf
    mov ecx, 0
drawRowloop:
    push ecx
    mov eax,lightCyan
    call SetTextColor
    mov al,'|'
    call WriteChar
    mov al,' '
    call WriteChar
    mov ebx,0
drawColloop:
    movzx edx,taxix
    cmp ebx,edx
    jne nottaxiposition
    movzx edx,taxiy
    cmp ecx,edx
    jne nottaxiposition
    call drawEnhancedtaxi
    jmp nextBoardCell
nottaxiposition:
    push ebx
    push ecx
    call checkpassengeratposition
    pop ecx
    pop ebx
    jc drawpassengerHere
    push ebx
    push ecx
    call checkDestinationatposition
    pop ecx
    pop ebx
    jc drawDestinationHere
    mov eax,ecx
    mov edx,20
    mul edx
    add eax,ebx
    mov al,board[eax]
    cmp al,'#'
    je drawEnhancedBuilding
    cmp al,'T'
    je drawEnhancedtree
    cmp al,'C'
    je drawEnhancednpc
    cmp al,'$'
    je drawEnhancedbonus
    jmp drawEnhancedroad
drawEnhancedBuilding:
    mov eax,white+(gray*16)
    call SetTextColor
    mov al,'#'
    call WriteChar
    mov al,'#'
    call WriteChar
    jmp nextBoardCell
drawEnhancedtree:
    mov eax,lightGreen+(green*16)
    call SetTextColor
    mov al,'^'
    call WriteChar
    mov eax,brown
    call SetTextColor
    mov al,'|'
    call WriteChar
    jmp nextBoardCell
drawEnhancednpc:
    mov eax,lightGray+(gray*16)
    call SetTextColor
    mov al,'['
    call WriteChar
    mov al,']'
    call WriteChar
    jmp nextBoardCell
drawEnhancedbonus:
    mov eax,yellow+(yellow*16)
    call SetTextColor
    mov al,'*'
    call WriteChar
    mov eax,yellow
    call SetTextColor
    mov al,'$'
    call WriteChar
    jmp nextBoardCell
drawEnhancedroad:
    mov eax,gray+(white*16)
    call SetTextColor
    mov al,'.'
    call WriteChar
    mov al,' '
    call WriteChar
    jmp nextBoardCell
drawpassengerHere:
    mov eax,white+(lightBlue*16)
    call SetTextColor
    mov al,'P'
    call WriteChar
    mov eax,lightBlue
    call SetTextColor
    mov al,' '
    call WriteChar
    jmp nextBoardCell
drawDestinationHere:
    mov eax,white+(green*16)
    call SetTextColor
    mov al,'D'
    call WriteChar
    mov eax,lightGreen
    call SetTextColor
    mov al,' '
    call WriteChar
    jmp nextBoardCell
nextBoardCell:
    inc ebx
    cmp ebx,20
    jl drawColloop
    mov eax,lightCyan
    call SetTextColor
    mov al,' '
    call WriteChar
    mov al,'|'
    call WriteChar
    call Crlf
    pop ecx
    inc ecx
    cmp ecx,20
    jl drawRowloop
    mov eax,lightCyan
    call SetTextColor
    mov al,'+'
    call WriteChar
    mov ecx,40
drawBottomBorder:
    mov al,'='
    call WriteChar
    loop drawBottomBorder
    mov al,'+'
    call WriteChar
    call Crlf
    mov al,taxix
    mov previousx,al
    mov al,taxiy
    mov previousy,al
    mov eax,white+(black*16)
    call SetTextColor
    ret
drawinitialscreen ENDP
drawEnhancedtaxi PROC
    cmp currentcolor,1
    jne drawyellowEnhancedtaxi
    mov eax,yellow+(lightRed*16)
    call SetTextColor
    mov al,'<'
    call WriteChar
    mov al,'>'
    call WriteChar
    ret
drawyellowEnhancedtaxi:
    mov eax,black+(yellow*16)
    call SetTextColor
    mov al,'<'
    call WriteChar
    mov al,'>'
    call WriteChar
    ret
drawEnhancedtaxi ENDP
;taxi position
  updatetaxiposition PROC
    mov dh,previousy
    add dh,11
    mov dl,previousx
    shl dl,1
    add dl,2
    call Gotoxy
    movzx eax,previousy
    mov edx,20
    mul edx
    movzx edx,previousx
    add eax,edx
    push ebx
    push ecx
    mov bl,previousx
    mov cl,previousy
    call checkpassengeratoldposition
    pop ecx
    pop ebx
    jc drawoldpassenger
    push ebx
    push ecx
    mov bl,previousx
    mov cl,previousy
    call checkDestinationatoldposition
    pop ecx
    pop ebx
    jc drawoldDestination
    mov al,board[eax]
    cmp al,'#'
    je redrawBuilding
    cmp al,'T'
    je redrawtree
    cmp al,'C'
    je redrawnpc
    cmp al,'$'
    je redrawbonus
    jmp redrawroad
redrawBuilding:
    mov eax,white+(gray*16)
    call SetTextColor
    mov al,'#'
    call WriteChar
    mov al,'#'
    call WriteChar
    jmp drawnewtaxiPos
redrawtree:
    mov eax,lightGreen+(green*16)
    call SetTextColor
    mov al,'^'
    call WriteChar
    mov eax,brown
    call SetTextColor
    mov al,'|'
    call WriteChar
    jmp drawnewtaxiPos
redrawnpc:
    mov eax,lightGray+(gray*16)
    call SetTextColor
    mov al,'['
    call WriteChar
    mov al,']'
    call WriteChar
    jmp drawnewtaxiPos
redrawbonus:
    mov eax,yellow+(yellow*16)
    call SetTextColor
    mov al,'*'
    call WriteChar
    mov eax,yellow
    call SetTextColor
    mov al,'$'
    call WriteChar
    jmp drawnewtaxiPos
redrawroad:
    mov eax,gray+(white*16)
    call SetTextColor
    mov al,'.'
    call WriteChar
    mov al,' '
    call WriteChar
    jmp drawnewtaxiPos
drawoldpassenger:
    mov eax,white+(lightBlue*16)
    call SetTextColor
    mov al,'P'
    call WriteChar
    mov eax,lightBlue
    call SetTextColor
    mov al,' '
    call WriteChar
    jmp drawnewtaxiPos
drawoldDestination:
    mov eax,white+(green*16)
    call SetTextColor
    mov al,'D'
    call WriteChar
    mov eax,lightGreen
    call SetTextColor
    mov al,' '
    call WriteChar
drawnewtaxiPos:
    mov dh,taxiy
    add dh,11
    mov dl,taxix
    shl dl,1
    add dl,2
    call Gotoxy
    call drawEnhancedtaxi
    mov al,taxix
    mov previousx,al
    mov al,taxiy
    mov previousy,al
    mov eax,white+(black*16)
    call SetTextColor
    mov dh,35
    mov dl,0
    call Gotoxy
    ret
updatetaxiposition ENDP
;user input
handleInput PROC
    call ReadKey
    jz noInputDetected
    cmp ah,48h
    je movetaxiUp
    cmp ah,50h
    je movetaxiDown
    cmp ah,4Bh
    je movetaxileft
    cmp ah,4Dh
    je movetaxiright
    cmp al,' '
    je handleSpaceAction
    cmp al,'p'
    je pauseThegame
    cmp al,'P'
    je pauseThegame
    cmp al,1Bh
    je exitThegame
    jmp noInputDetected
movetaxiUp:
    mov al,taxiy
    cmp al,1
    jle noInputDetected
    mov ebx,0
    mov ecx,-1
    call checkcollision
    jc noInputDetected
    dec taxiy
    jmp inputWasProcessed
movetaxiDown:
    mov al,taxiy
    cmp al,18
    jge noInputDetected
    mov ebx,0
    mov ecx,1
    call checkcollision
    jc noInputDetected
    inc taxiy
    jmp inputWasProcessed
movetaxileft:
    mov al,taxix
    cmp al,1
    jle noInputDetected
    mov ebx,-1
    mov ecx,0
    call checkcollision
    jc noInputDetected
    dec taxix
    jmp inputWasProcessed
movetaxiright:
    mov al,taxix
    cmp al,18
    jge noInputDetected
    mov ebx,1
    mov ecx,0
    call checkcollision
    jc noInputDetected
    inc taxix
    jmp inputWasProcessed
handleSpaceAction:
    call handlepickupdropoff
    jmp inputWasProcessed
pauseThegame:
    call Pausegame
    cmp eax,1
    je exitThegame
    jmp inputWasProcessed
exitThegame:
    mov eax,1
    ret
inputWasProcessed:
    mov eax,2
    ret
noInputDetected:
    mov eax,0
    ret
handleInput ENDP
Pausegame PROC
    pushad
    call Clrscr
    mov eax,yellow
    call SetTextColor
    mov edx,OFFSET pausedmsg
    call WriteString
pausegameloop:
    call ReadKey
    jz pausegameloop
    cmp al,'p'
    je resumeThegame
    cmp al,'P'
    je resumeThegame
    cmp al,1Bh
    je exittomainMenu
    jmp pausegameloop
resumeThegame:
    popad
    call drawinitialscreen
    mov eax,0
    ret
exittomainMenu:
    popad
    mov eax,1
    ret
Pausegame ENDP
;pick n drop
handlepickupdropoff PROC
    cmp currentpassenger,-1
    je trytopickup
    jmp trytodropoff
trytopickup:
    mov edx,0
pickupSearchloop:
    cmp passengeractive[edx],1
    jne nextpickupcheck
    mov al,passengerx[edx]
    movzx ebx,taxix
    cmp al,bl
    jne nextpickupcheck
    mov al,passengery[edx]
    movzx ecx,taxiy
    cmp al,cl
    jne nextpickupcheck
    mov passengeractive[edx],2
    mov currentpassenger,dl
    call playpickdropsound 
    call drawinitialscreen
    ret
nextpickupcheck:
    inc edx
    cmp edx,maxpassengers
    jl pickupSearchloop
    ret
trytodropoff:
    movzx edx,currentpassenger
    mov al,destinationx[edx]
    movzx ebx,taxix
    cmp al,bl
    jne dropofffailed
    mov al,destinationy[edx]
    movzx ecx,taxiy
    cmp al,cl
    jne dropofffailed
    mov passengeractive[edx],0
    mov currentpassenger,-1
    add score,10
    inc deliveriesmade
    call playpickdropsound 
    call checkspeedincrease
    cmp currentmode,1
    jne checkForEndlessMode
    mov al,deliveriesmade
    cmp al,totalpassengers
    jl dropoffsuccessful
    mov gameactive,0
    call playgameoversound
    call drawinitialscreen
    call Clrscr
    mov eax,lightGreen
    call SetTextColor
    call crlf
    call crlf
    call crlf
    call crlf
    call crlf
    call crlf
    call crlf
    call crlf
    mov edx,OFFSET gameovermsg
    call WriteString
    call Crlf
    jmp updateleaderboardnow
checkForEndlessMode:
    cmp currentmode,3
    jne dropoffsuccessful
    mov al,deliveriesmade
    cmp al,totalpassengers
    jl dropoffsuccessful
    call initializepassengers
    mov deliveriesmade,0    
dropoffsuccessful:
    call drawinitialscreen
    ret    
dropofffailed:
    ret
updateleaderboardnow:
    call updateleaderboard    
    call ReadChar
    ret
handlepickupdropoff ENDP
;score update
updatestatsdisplay PROC
    pushad
    mov dl,0
    mov dh,8
    call Gotoxy
    mov eax,yellow
    call SetTextColor
    mov edx,OFFSET scoremsg
    call WriteString
    mov eax,score
    call WriteDec
    mov al,' '
    mov ecx,10
clearscorescore:
    call WriteChar
    loop clearscorescore
    cmp currentmode,2
    jne checkCareerModestats
    mov dl,20
    mov dh,8
    call Gotoxy
    mov eax,lightBlue
    call SetTextColor
    mov edx,OFFSET timemsg
    call WriteString
    mov eax,initialtime
    call WriteDec
    mov al,' '
    mov ecx,10
cleartimescore:
    call WriteChar
    loop cleartimescore
    jmp donestatsupdate
checkCareerModestats:
    cmp currentmode,1
    jne donestatsupdate
    mov dl,20
    mov dh,8
    call Gotoxy
    mov eax,lightGreen
    call SetTextColor
    mov edx,OFFSET deliveriesmsg
    call WriteString
    movzx eax,deliveriesmade
    call WriteDec
    mov al,'/'
    call WriteChar
    movzx eax,totalpassengers
    call WriteDec
    mov al,' '
    mov ecx,10
cleardeliveriesscore:
    call WriteChar
    loop cleardeliveriesscore
donestatsupdate:
    mov eax,white+(black*16)
    call SetTextColor
    popad
    ret
updatestatsdisplay ENDP
;npc update
updatenpcsonscreen PROC
    pushad
    mov esi, 0
updateeachnpc:
    cmp esi,maxnpccars
    jge doneupdatingnpcs
    cmp npcactive[esi],1
    jne skipthisnpc
    movzx ebx,npcx[esi]
    movzx ecx,npcy[esi]
    mov dh,cl
    add dh,11
    mov dl,bl
    shl dl,1
    add dl,2
    call Gotoxy
    mov eax,lightGray+(gray*16)
    call SetTextColor
    mov al,'['
    call WriteChar
    mov al,']'
    call WriteChar    
skipthisnpc:
    inc esi
    jmp updateeachnpc    
doneupdatingnpcs:
    popad
    ret
updatenpcsonscreen ENDP 
;main game
maingameloop PROC
    call drawinitialscreen
    mov gametimer,0   
gamemainloop:
    cmp gameactive,0
    je exitgameloop
    cmp currentcolor,2
    jne normalspeed
    mov eax,gamespeed
    sub eax,20
    jmp applydelay
normalspeed:
    mov eax,gamespeed
applydelay:
    call delay
    inc gametimer
    cmp currentmode, 2
    jne skiptimecountdown
    mov eax, gametimer
    cmp eax, 10
    jl skiptimecountdown
    mov gametimer, 0
    cmp initialtime, 0
    jle timeover
    dec initialtime
    call updatestatsdisplay
skiptimecountdown:
    call movenpcs
    call handleInput
    cmp eax,0
    je continuegameloop
    cmp eax,1
    je exitgameloop
    cmp eax,2
    je taxihasmoved
continuegameloop:
    call updatestatsdisplay
    jmp gamemainloop
taxihasmoved:
    call updatetaxiposition
    call updatestatsdisplay
    jmp gamemainloop
timeover:
    mov gameactive,0
    call playgameoversound
    call drawinitialscreen
    call Clrscr
    mov eax,lightRed
    call SetTextColor
    call crlf
    call crlf
    call crlf
    call crlf
    call crlf
    call crlf
    call crlf
    call crlf
    mov edx,OFFSET gameovermsg
    call WriteString
    call Crlf
    call updateleaderboard
    call ReadChar
    jmp exitgameloop
exitgameloop:
    ret
maingameloop ENDP
END main



