a = imread('result_2/01112v.jpg');
n = size(a,1);
m = size(a,2);
bx=1;by=1;ex=n;ey=m;
best=n+m;
dev = 40; maxi = 100;
portion = 20;
for i = 1 : n/portion;
    cnt = 0;
    for j = 1 : m;
        if std(double(a(i,j,:))) > dev || max(double(a(i,j,:))) < maxi; cnt=cnt+1; end;
    end;
    if cnt * 3 > m && bx >= i-1; bx = i; else break;end;
end;
for i = n : -1 : n-n/portion;
    cnt = 0;
    for j = 1 : m;
        if std(double(a(i,j,:))) > dev || max(double(a(i,j,:))) < maxi; cnt=cnt+1; end;
    end;
    if cnt * 3 > m && ex <= i+1; ex = i; else break;end;
end;
best=0;
for j = 1 : m/portion
    cnt = 0;
    for i = 1 : n
        if std(double(a(i,j,:))) > dev || max(double(a(i,j,:))) < maxi; cnt=cnt+1; end;
    end;
    if cnt * 3 > n && by >= j-1; by = j; else break;end;
end;
for j = m : -1 : m-m/portion
    cnt = 0;
    for i = 1 : n
        if std(double(a(i,j,:))) > dev || max(double(a(i,j,:))) < maxi; cnt=cnt+1; end;
    end;
    if cnt * 3 > n && ey <= j+1; ey = j; else break;end;
end;
a = a(bx:ex,by:ey,:);
imshow(a);
imwrite(a,'result_2/01112v_cut.jpg');