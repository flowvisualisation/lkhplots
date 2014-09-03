
FUNCTION logticks_exp, axis, index, value
   ; Determine the base-10 exponent
   exponent   = LONG( ALOG10( value ) )
   ; Construct the tickmark string based on the exponent
   tickmark = '10!E' + STRTRIM( STRING( exponent ), 2 ) + '!N'
   ; Return the formatted tickmark string
   RETURN, tickmark
END
