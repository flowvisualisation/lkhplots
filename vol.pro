
fname='test'
cgps_open, fname+'.eps', /encapsulated, /color, tt_font='Times'
v = VOLUME(vx3, RENDER_EXTENTS=0, $
  ; HINTS = 3, $
   /AUTO_RENDER, $
   RGB_TABLE0=33, AXIS_STYLE=2, $
   RENDER_QUALITY=2, BACKGROUND_COLOR='gray', $
   DEPTH_CUE=[0, 2], /PERSPECTIVE, $
   ;VOLUME_LOCATION=[-20, -20, -20] * 0.528, $
   VOLUME_DIMENSIONS=[2.0, 2.0, 1.0] )

cgps_close, /jpeg,  Width=1100, /nomessage
   end
