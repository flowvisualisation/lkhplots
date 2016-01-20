
 al_legend,['1','22','333','4444'],linestyle=indgen(4),corners=corners 
                      ; BOGUS LEGEND---FIRST TIME TO REPORT CORNERS 
          xydims = [corners[2]-corners[0],corners[3]-corners[1]] 
                      ; SAVE WIDTH AND HEIGHT 
          chdim=[!d.x_ch_size/float(!d.x_size),!d.y_ch_size/float(!d.y_size)] 
                      ; DIMENSIONS OF ONE CHARACTER IN NORMALIZED COORDS 
          pos = [!x.window[1]-chdim[0]-xydims[0] $ 
                      ,!y.window[0]+chdim[1]+xydims[1]] 
                       ;pos = [!x.window[1]-chdim[0]-xydims[0],!y.window[1]-xydims[1]]
                      ; CALCULATE POSITION FOR LOWER RIGHT 
          cgplot,findgen(10) ; SIMPLE PLOT; YOU DO WHATEVER YOU WANT HERE. 
          al_legend,['1','22','333','4444'],linestyle=indgen(4),pos=pos , /normal
                      ; REDO THE LEGEND IN LOWER RIGHT CORNER
                      end
