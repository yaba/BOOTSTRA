IF %MODE%==CLEAN GOTO :EOF

IF x%1==xAX GOTO :AX
CALL ISREG16 %1
IF %RESULT%==1 GOTO :REG16
CALL ISREG8 %1
IF %RESULT%==1 GOTO :REG8
ECHO Expected register (IP=%IP%)

:REG16
CALL CMRM16 %2
CALL RPN! _%IP%_2+_%DISPBYTES%+
SET IP=%RESULT%
IF %MODE%==COUNT GOTO :EOF
IF NOT %DISPBYTES%==1 GOTO :NOCHECK1
CALL IS8SIGN %3
IF %RESULT%==1 GOTO :NOCHECK1
ECHO Byte displacement truncated (IP=%IP%)
:NOCHECK1
CALL EMITBYTE 135
CALL CREG16 %1
CALL RPN! _%MRM%_%REG%_8*+
CALL EMITBYTE %RESULT%
IF %DISPBYTES%==1 CALL EMITBYTE %3
IF %DISPBYTES%==2 CALL EMITWORD %3
GOTO :EOF

:REG8
CALL CMRM8 %2
CALL RPN! _%IP%_2+_%DISPBYTES%+
SET IP=%RESULT%
IF %MODE%==COUNT GOTO :EOF
IF NOT %DISPBYTES%==1 GOTO :NOCHECK2
CALL IS8SIGN %3
IF %RESULT%==1 GOTO :NOCHECK2
ECHO Byte displacement truncated (IP=%IP%)
:NOCHECK2
CALL EMITBYTE 134
CALL CREG8 %1
CALL RPN! _%MRM%_%REG%_8*+
CALL EMITBYTE %RESULT%
IF %DISPBYTES%==1 CALL EMITBYTE %3
IF %DISPBYTES%==2 CALL EMITWORD %3
GOTO :EOF

:AX
CALL RPN! _%IP%_1+
SET IP=%RESULT%
IF %MODE%==COUNT GOTO :EOF
CALL CREG16 %2
CALL RPN! _144_%REG%+
CALL EMITBYTE %RESULT%

:EOF
