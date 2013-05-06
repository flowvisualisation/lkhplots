
little_endian = (BYTE(1, 0, 1))[0]
   IF (little_endian) THEN $
      Print, "I'm little endian." ELSE $
      Print, "I'm big endian."
end
