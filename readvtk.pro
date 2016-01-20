pro readvtk,filename,pfact
COMMON SHARE1,nx,ny,nz,nvar,nscalars
COMMON SHARE2,x,y,z
COMMON SHARE3,time,dt,gamm1,isocs
COMMON SHARE4,d,e,p,vx,vy,vz,bx,by,bz,s,phi
; -----------------------------------------
; pfact = gamm1 for adiabatic
; pfact = isocs for isothermal
; leave out parameter to use existing value
; -----------------------------------------
;
; Read header information, which is assumed
; to be (roughly) in the following form:
;
; # vtk DataFile Version 3.0
; Really cool Athena data at time = 0.000000e+00
; BINARY
; DATASET STRUCTURED_POINTS
; DIMENSIONS 257 257 513
; ORIGIN -5.000000e-02 -5.000000e-02 -1.000000e-01
; SPACING 3.906250e-04 3.906250e-04 3.906250e-04
; CELL_DATA 33554432
; SCALARS density float
; LOOKUP_TABLE default
; (array of dim[nx,ny,nz])
; VECTORS velocity float
; (array of dim[3,nx,ny,nz])
; SCALARS total_energy float
; LOOKUP_TABLE default
; (array of dim[nx,ny,nz])
; VECTORS cell-centered-B float
; (array of dim[3,nx,ny,nz])
;
; There are differences in the VTK files output from
; different versions of Athena and also join_vtk_dump!

string = ' '
string_array=STRARR(8)
ndata = LONARR(3)

openr,1,filename
; read line 1 (do nothing)
readf,1,string
readf,1,string
string_array=STRSPLIT(string,' ',count=cnt,/EXTRACT)
print, string, cnt
if (cnt eq 9) then begin
  reads,string_array[4],time
  print,"Time:", time
end
; read lines 3,4 (do nothing)
readf,1,string
readf,1,string
; read line 5, get dimensions
readf,1,string
string_array=STRSPLIT(string,' ',/EXTRACT)
reads,string_array[1],nxs
reads,string_array[2],nys
reads,string_array[3],nzs
nx = LONG(nxs)-1
ny = LONG(nys)-1
nz = LONG(nzs)-1
if (ny eq 0) then ny=1
if (nz eq 0) then nz=1
print,"nx,ny,nz:",nx,ny,nz
; read line 6, get origin
readf,1,string
string_array=STRSPLIT(string,' ',/EXTRACT)
reads,string_array[1],x0
reads,string_array[2],y0
reads,string_array[3],z0
print,"x0,y0,z0:",x0,y0,z0
; read line 7, get grid spacing
readf,1,string
string_array=STRSPLIT(string,' ',/EXTRACT)
reads,string_array[1],dx
reads,string_array[2],dy
reads,string_array[3],dz
print,"dx,dy,dz:",dx,dy,dz
; read line 8, do nothing
readf,1,string

nvar = 0
isothermal = 1
mhd = 0
while (not eof(1)) do begin
  readf,1,string
  print, string
  block = matchsechead(string)
  if ((block le 0) and (not eof(1))) then begin
    readf,1,string
    block = matchsechead(string)
  end
  if ((block le 0) and (not eof(1))) then begin
    print,"Unexpected file format"
    stop
  end else begin
    print,string
    if (block lt 20) then begin
      ; SCALARS block
      if (block eq 11) then begin
        readscalarblock,1,d
        nvar = nvar + 1
      end else if (block eq 12) then begin
        readscalarblock,1,e
        isothermal = 0
        nvar = nvar + 1
      end else if (block eq 13) then begin
        readscalarblock,1,p
        isothermal = 0
        nvar = nvar + 1
      end else begin
        readscalarblock,1
        print,"Data from unrecognized SCALARS block not stored."
      end
    end else if (block lt 30) then begin
      ; VECTORS block
      if (block eq 21) then begin
        readvectblock,1,vx,vy,vz
        print, 'i read velocity 21'
        nvar = nvar + 3
      end else if (block eq 22) then begin
        readvectblock,1,vx,vy,vz
        print, 'i read velocity 22'
        nvar = nvar + 3
        vx = vx/d
        vy = vy/d
        vz = vz/d
      end else if (block eq 23) then begin
        readvectblock,1,bx,by,bz
        print, 'i read bfield 22'
        mhd = 1
        nvar = nvar + 3
      end else begin
        readvectblock,1
        print,"Data from unrecognized VECTORS block not stored."
      end
    end else begin
      print,"Unrecognized block type!"
      stop
    end
  end
endwhile

close,1

if (isothermal eq 0) then begin
  if (mhd eq 0) then begin
    print,"Assuming adiabatic hydro"
  end else begin
    print,"Assuming adiabatic MHD"
  end
end else begin
  if (mhd eq 0) then begin
    print,"Assuming isothermal hydro"
  end else begin
    print,"Assuming isothermal MHD"
  end
end

if (isothermal eq 0) then begin
  if (N_Elements(pfact) eq 1) then gamm1 = pfact
  if (N_Elements(gamm1) eq 0) then begin
    print,"Pressure not set because gamm1 undefined!"
  end else begin
    print,"Pressure set assuming gamm1=",gamm1
    if (mhd eq 0) then begin
      p=gamm1*(e-0.5*d*(vx^2+vy^2+vz^2))
    end else begin
      p=gamm1*(e-0.5*d*(vx^2+vy^2+vz^2)-0.5*(bx^2+by^2+bz^2))
    end
  end
end else begin
  if (N_Elements(pfact) eq 1) then isocs = pfact
  if (N_Elements(isocs) eq 0) then begin
    print,"Pressure not set because isocs undefined!"
  end else begin
    print,"Pressure set assuming isocs=",isocs
    p=isocs*isocs*d
  end
end

END
;------------------------------------------------------------------------------
