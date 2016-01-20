
FUNCTION matchsechead,string

if (string eq "SCALARS density float") then begin
  return,11
end else if (string eq "VECTORS velocity float") then begin
  return,21
end else if (string eq "VECTORS momentum float") then begin
  return,22
end else if (string eq "SCALARS total_energy float") then begin
  return,12
end else if (string eq "SCALARS pressure float") then begin
  return,13
end else if (string eq "VECTORS cell_centered_B float") then begin
  return,23
end else if (strpos(string, "SCALARS") ne -1) then begin
  return,10
end else if (strpos(string, "VECTORS") ne -1) then begin
  return,20
end else if (string eq "") then begin
  return,0
end else begin
  return,-1
end

END
