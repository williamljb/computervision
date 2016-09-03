a = imread('data/01112v.jpg');
%remove white
maxicolor = 255;
th = maxicolor * 0.3;
mid = maxicolor / 2;
ratio = 255.0 / maxicolor;
for ox = 5 : size(a,1); 
    for oy = 5 : size(a,2)/10;
        if abs(a(ox,oy)-mid)<th break;end;
    end;
    if abs(a(ox,oy)-mid)<th break;end;
end;
for ex = size(a,1)-5 : -1 : 1;
    for ey = size(a,2)-5 : -1 : size(a,2)-size(a,2)/10;
        if abs(a(ex,ey)-mid)<th break;end;
    end;
    if abs(a(ex,ey)-mid)<th break;end;
end;
a = a(ox:ex,oy:ey);
%imshow(a);
n = uint32(size(a,1)/3);
m = size(a,2);
b = a(1:n,:);g = a(n+1:2*n,:);r = a(2*n+1:size(a,1),:);
ref = g;
res = uint16(zeros(n,m,3));
tic;
[xr,yr] = getbest(ref, r);disp([xr,yr]);
[xb,yb] = getbest(ref, b);disp([xb,yb]);
[xg,yg] = getbest(ref, g);disp([xg,yg]);
toc;
for i = int32(1) : int32(n)
    for j = int32(1) : int32(m)
        if (i+xr>0&&i+xr<=size(r,1)&&j+yr>0&&j+yr<=m);res(i,j,1) = r(i+xr,j+yr);end;
        if (i+xg>0&&i+xg<=n&&j+yg>0&&j+yg<=m);res(i,j,2) = g(i+xg,j+yg);end;
        if (i+xb>0&&i+xb<=n&&j+yb>0&&j+yb<=m);res(i,j,3) = b(i+xb,j+yb);end;
    end
end
res0 = uint8(res.*ratio);
imshow(res0);
imwrite(res0,'result_2/01112v.jpg');