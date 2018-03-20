
v=videoinput('winvideo', 1, 'YUY2_640x480');
v.FramesPerTrigger=1;
preview(v);
start(v);
pause(2.0);
 I=getdata(v);
imwrite(I,'C:\Users\HP\Desktop\keyboard.jpg'); %filepath
Igray = rgb2gray(I);
 BW = im2bw(Igray,0.567);
 imshow(BW);
st = regionprops(not(BW), 'BoundingBox', 'Area', 'Centroid' ); 
disp(st);
disp(length(st)); 
x=0;              % x is the serial number of centroid
fileID = fopen('centroid.txt','w');
 
for k = 1 : length(st)
    if(st(k).Area>500&&st(k).Area<15000)   
        thisBB = st(k).BoundingBox;
        rectangle('Position', [thisBB(1),thisBB(2),thisBB(3),thisBB(4)],...     % st(k).Bounding Box = X Y W H
            'EdgeColor','r','LineWidth',2 )
        centroids=st(k).Centroid;
        hold on
        plot(centroids(:,1),centroids(:,2), 'b*') %blue color
        x=x+1;
        fprintf('Centroid number= %g ',k)
        fprintf('Sno= %g',x);
        disp(st(k).Centroid);   
        x_centroid(k) = st(k).Centroid(1); 
        y_centroid(k) = st(k).Centroid(2);
        fprintf(fileID,'%d %d %8.4f %8.4f\r\n',x,k,x_centroid(k),y_centroid(k));
        hold off
    end
end
fclose(fileID);
delete(v); 
 prompt = 'Proceed to Step 2? [Y/N] Check the output. Number of detected centroids should be 53 \n';
str = input(prompt,'s');
if (str=='Y')
    secondpart()
end

