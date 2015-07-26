--[[
@title Motion Detect Lua Script
]]

a=6         -- columns to split picture into 
b=6         -- rows to split picture into 
c=1         -- measure mode (Y,U,V R,G,B) <96> U=0, Y=1, V=2, R=3, G=4, B=5
d=300000    -- timeout (mSec) 
e=200       -- comparison interval (msec) 
f=0         -- threshold (difference in cell to trigger detection)
g=1         -- draw grid (0=no, 1=yes)   
h=0         -- not used in LUA 
i=0         -- region masking mode: 0=no regions, 1=include, 2=exclude
j=0         --      first column
k=0         --      first row
l=0         --      last column
m=0         --      last row
n=0         -- optional parameters  (1=shoot immediate)
o=2         -- pixel step
p=500       -- triggering delay (msec) 

y=0
firstshoot = 0

function deleteimages()
  dir = os.listdir("A/DCIM", false) --'true' shows also . and ..
  count = table.getn(dir)
  for ii=1, count do
    fullname = "A/DCIM/" .. dir[ii]
    print(" " .. fullname)
    imagedir = os.listdir(fullname, false) --'true' shows also . and ..
    imagecount = table.getn(imagedir)
    for ga=1, imagecount do
      if(imagedir[ga] ~= nil) then
        if(string.match(imagedir[ga], "jpg")) then
          print("remove file " .. fullname .. "/".. imagedir[ga])
          os.remove(fullname .. "/" .. imagedir[ga])
        end
        if(string.match(imagedir[ga], "JPG")) then
          print("remove file " .. fullname .. "/".. imagedir[ga])
          os.remove(fullname .. "/" .. imagedir[ga])
        end
        if(string.match(imagedir[ga], "dng")) then
          print("remove file " .. fullname .. "/".. imagedir[ga])
          os.remove(fullname .. "/" .. imagedir[ga])
        end
        if(string.match(imagedir[ga], "DNG")) then
          print("remove file " .. fullname .. "/".. imagedir[ga])
          os.remove(fullname .. "/" .. imagedir[ga])
        end
      end
    end
  end
end

repeat

y = y+1
print(" count " .. y)
if(y % 30==4) then
  if(firstshoot==0) then
    firstshoot=1
    shoot()
  end
  zones = md_detect_motion( a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p)
  if( zones > 0 ) then
    if(md_get_cell_val(1,1)>=10) then
      shoot()
    end
  end
end
if(y > 120) then
  y=0
end

if(y ==2 ) then
  deleteimages()
end

sleep(60000) --1 xhour   
   
   
until (false)