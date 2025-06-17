
cam = webcam();


faceDetector = vision.CascadeObjectDetector('FrontalFaceCART');
eyeDetector = vision.CascadeObjectDetector('EyePairBig');
mouthDetector = vision.CascadeObjectDetector('Mouth'); 

drowsy = false;
blinkCount = 0;
yawnCount = 0;


figure('Name', 'Drowsiness Detection', 'NumberTitle', 'off');
hImage = imshow(zeros(480, 640, 3, 'uint8')); 

while true
    
    frame = snapshot(cam);
    
    
    grayFrame = rgb2gray(frame);
    
   
    faceBbox = step(faceDetector, grayFrame);
    
    
    if ~isempty(faceBbox)
        roi = faceBbox(1, :); 
        eyeBbox = step(eyeDetector, grayFrame(roi(2):roi(2)+roi(4), roi(1):roi(1)+roi(3), :));
        mouthBbox = step(mouthDetector, grayFrame(roi(2):roi(2)+roi(4), roi(1):roi(1)+roi(3), :));
        
       
        rectangle('Position', faceBbox(1, :), 'LineWidth', 2, 'EdgeColor', 'r');
        
        if ~isempty(eyeBbox)
            rectangle('Position', eyeBbox(1, :), 'LineWidth', 2, 'EdgeColor', 'g');
            
            
            if eyeBbox(1, 4) < 10  
                blinkCount = blinkCount + 1;
                if blinkCount > 5  
                    drowsy = true;
                end
            else
                blinkCount = 0;  
                if drowsy  
                    drowsy = false;  
                    disp('Drowsiness status cleared.');  
                end
            end
        end
        
        if ~isempty(mouthBbox)
          
            mouthHeight = mouthBbox(1, 4);
            if mouthHeight > 20 
                yawnCount = yawnCount + 1;
                if yawnCount > 5  
                    drowsy = true;
                end
            else
                yawnCount = 0;  
                if drowsy  
                    drowsy = false;  
                    disp('Drowsiness status cleared.');  
                end
            end
            
            
            rectangle('Position', mouthBbox(1, :), 'LineWidth', 2, 'EdgeColor', 'b');
        end
    end
    
    
    set(hImage, 'CData', frame);
    drawnow;
    
    
    if drowsy
        disp('Drowsiness detected!');
    end
end
