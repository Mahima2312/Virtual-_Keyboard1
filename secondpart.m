function [] = secondpart()
%% Initialization
redThresh = 0.2; 
vidDevice = imaq.VideoDevice('winvideo', 1, 'YUY2_640x480', ... 
                    'ROI', [1 1 640 480], ...
                    'ReturnedColorSpace', 'rgb');               
vidInfo = imaqhwinfo(vidDevice); 
hblob = vision.BlobAnalysis('AreaOutputPort', false,...
                                'CentroidOutputPort', true,...
                                'BoundingBoxOutputPort', true', ...
                                'MinimumBlobArea', 800, ...
                                'MaximumBlobArea', 3000, ...
                                'MaximumCount', 10);
hshapeinsRedBox = vision.ShapeInserter('BorderColor', 'Custom', ...
                                        'CustomBorderColor', [1 0 0],... 
                                        'Fill', true, ...
                                        'FillColor', 'Custom', ...
                                        'CustomFillColor', [1 0 0], ...
                                        'Opacity', 0.4);
htextins = vision.TextInserter('Text', 'Number of Red Object: %2d', ...
                                    'Location',  [7 2], ...
                                    'Color', [1 0 0], ... // red color
                                    'FontSize', 12);
htextinsCent = vision.TextInserter('Text', '+      X:%4d, Y:%4d', ... % set text for centroid
                                    'LocationSource', 'Input port', ...
                                    'Color', [1 1 0], ... // yellow color
                                    'FontSize', 14);
hVideoIn = vision.VideoPlayer('Name', 'Final Video', ... % Output video player
                                'Position', [100 100 vidInfo.MaxWidth+20 vidInfo.MaxHeight+30]);
nFrame = 0; % Frame number initialization
 
filename = 'centroid.txt';
delimiterIn = ' ';
format long g;  
A = importdata(filename,delimiterIn);
 
%% Processing Loop
while(nFrame < 300)
    pause(0.5);
    rgbFrame = step(vidDevice); % Acquire single frame
    diffFrame = imsubtract(rgbFrame(:,:,1), rgb2gray(rgbFrame));
    diffFrame = medfilt2(diffFrame, [3 3]); 
    binFrame = im2bw(diffFrame, redThresh);
    [centroid, bbox] = step(hblob, binFrame);
    centroid = (centroid); 
    rgbFrame(1:20,1:165,:) = 0; 
    vidIn = step(hshapeinsRedBox, rgbFrame, bbox);
    for object = 1:1:length(bbox(:,1)) 
        centX = centroid(object,1);
        centY = centroid(object,2);
        disp(centX);
        disp(centY);
        vidIn = step(htextinsCent, vidIn, [uint16(centX) uint16(centY)], [uint16(centX-6) uint16(centY-9)]);  %required to convert in this format for next step
        compare(centX,centY,A)
    end
    vidIn = step(htextins, vidIn, uint8(length(bbox(:,1)))); 
    step(hVideoIn, vidIn); 
    pause(0.25);
    nFrame = nFrame+1;
    %end

release(hVideoIn); 
release(vidDevice);
end