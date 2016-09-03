function [ dx,dy ] = getbest( a,b0 )

if (size(a,1)>=100)
    [tmpx, tmpy] = getbest(imresize(a,0.5),imresize(b0,0.5));
    th = 2;
    margin = th + 2*max(abs(tmpx),abs(tmpy));
    n = size(b0,1);
    m = size(b0,2);
    b = zeros(n+margin*2,m+margin*2);
    b(margin+1:margin+n,margin+1:margin+m) = b0(:,:);
    offy = int32(size(a,1)/6); offx = int32(size(a,2)/6);
    %offy=int32(1);offx=int32(1);
    a = a(offy:size(a,1)-offy+1,offx:size(a,2)-offx+1);
    maxi = 0;
    for i = tmpx*2-th : tmpx*2+th;
        for j = tmpy*2-th : tmpy*2+th;
            %disp([i,j,offy,offx,margin]);
            tmp = corr2(a, b(i+offy+margin:i+offy+margin+size(a,1)-1,...
                j+offx+margin:j+offx+margin+size(a,2)-1));
            if maxi < tmp
                maxi = tmp;
                dx = i;
                dy = j;
            end;
        end;
    end;
else
    th = int32(size(b0,1)/20);
    n = size(b0,1);
    m = size(b0,2);
    b = zeros(n+th*2,m+th*2);
    b(th+1:th+n,th+1:th+m) = b0(:,:);
    offy = int32(size(a,1)/6); offx = int32(size(a,2)/6);
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
    %hFig = figure;
    %hAx  = axes;
    %imshow(b,'Parent', hAx);
    %imrect(hAx, [xoffset+1, yoffset+1, size(a,2), size(a,1)]);
    dx = int32(yoffset-th);
    dy = int32(xoffset-th);
end;
disp([size(a,1),dx,dy]);
end

