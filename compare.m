function [] = compare(centX,centY,A)
x2=centX;
y2=centY;
dis=zeros(53,1);   
for p=1:53
    x1=(A(p,3)); 
    y1=(A(p,4));
    fprintf('x1=%8.4f y1=%8.4f x2=%8.4f y2=%8.4f',x1,y1,x2,y2)
    dis(p)=(sqrt((x2-x1).^2+(y2-y1).^2));
    %distance(p)=dis.^(1/2);
 
end
 
disp(dis);  %storing distance in array 'distance'
 
%% Search to find shortest distance, Linear Search
 
num=0;
short=dis(1);  %assuming
for i=1:53
    if(dis(i)<short)
        short=dis(i);
        num=i;
    end
end
 
fprintf('Serial Number=%g Centroid number= %g Shortest Distance= %g',A(num,1),A(num,2),short); 
 
%% Compare the key pressed and show it
       % SNo. KeyValue
keyMap ={1,'Tab';
        2,'CapsLock';     %we are using cell ie, {} instead of char array [] to put strings in this array
        3,'Shift';        % char array[] allows only for identical sized matrix.
        4,'1';
        5,'Q';
        6,'2';
        7,'A';
        8,'Z';
        9,'W';
        10,'S';
        11,'3';
        12,'X';
        13,'E';
        14,'D';
        15,'4';
        16,'C';
        17,' ';
        18,'R';
        19,'F';
        20,'5';
        21,'V';
        22,'T';
        23,'G';
        24,'6';
        25,'B';
        26,'Y';
        27,'H';
        28,'7';
        29,'N';
        30,'U';
        31,'J';
        32,'8';
        33,'M';
        34,'I';
        35,'K';
        36,'9';
        37,'<';         38,'O';         39,'L';         40,'0';         41,'>';
        42,'P';
        43,';';
        44,'-';
        45,'?';
        46,'[';
        47,'@';
        48,'+';
        49,'Shift' ;
        50,']';
        51,'#';
        52,'Backspace' ;
        53,'\n'};
 
 keypress=keyMap(num,2);  %this returns a cell that is the Key Name as specified aboce
 fprintf('\nKey Pressed is');
 fileID = fopen('output.txt','a');
 fprintf(fileID,'%s',keypress{1});  %keypress{1} to access contents of the 1-D cell
 disp(keypress);
end