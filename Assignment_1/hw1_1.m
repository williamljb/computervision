a = imread('crayons_mosaic.bmp');
n = size(a,1);
m = size(a,2);
b = zeros(n,m,3);
for i = 1 : n
    for j = 1 : m
        tmp = 3-(mod(i,2) + mod(j,2));
        for k = 1 : 3
            if k == tmp
                b(i,j,k) = a(i,j);
                continue;
            end
            s = 0.0;
            num = 0.0;
            for dx = -1 : 1
                if i+dx<=0 || i+dx>n
                    continue;
                end
                for dy = -1 : 1
                    if j+dy<=0 || j+dy>m
                        continue;
                    end
                    if 3-(mod(i+dx,2) + mod(j+dy,2)) == k
                        s = s + double(a(i+dx, j+dy));
                        num = num + 1;
                    end
                end
            end
            b(i,j,k) = s / num;
        end
    end
end
b = uint8(b);
imwrite(b,'result.jpg');
c = imread('crayons.jpg');
diff = (sum(b,3)-sum(c,3)).^2;
imshow(diff,[min(min(diff)), 900]);
disp(max(max(diff)));disp(sum(sum(diff))/n/m);
