function [ dx,dy ] = getbest( a,b0 )

th = int32(size(b0,1)/20);
n = size(b0,1);
m = size(b0,2);
b = zeros(n+th*2,m+th*2);
b(th+1:th+n,th+1:th+m) = b0(:,:);
offy = int32(size(a,1)/6); offx = int32(size(a,2)/6);
offy=1;offx=1;
a = a(offy:size(a,1)-offy+1,offx:size(a,2)-offx+1);
%imshowpair(a,b,'montage');
c = normxcorr2(a,b);
%figure, surf(c), shading flat
sa1 = size(a,1);
sa2 = size(a,2);
maxi = 0;
for i = sa1+offy-1 : sa1+offy-1+th*2;
    for j = sa2+offx-1 : sa2+offx-1+th*2;
        if c(i,j) > maxi
            maxi = c(i,j);
            ypeak = i;
            xpeak = j;
        end;
    end;
end;
%[ypeak, xpeak] = find(c==max(c(:)));
yoffset = ypeak-size(a,1)-offy+1;
xoffset = xpeak-size(a,2)-offx+1;
disp([xpeak,ypeak,xoffset,yoffset]);
%hFig = figure;
%hAx  = axes;
%imshow(b,'Parent', hAx);
%imrect(hAx, [xoffset+1, yoffset+1, size(a,2), size(a,1)]);
dx = int32(yoffset-th);
dy = int32(xoffset-th);
end

