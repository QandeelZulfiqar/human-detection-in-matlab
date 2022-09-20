close all;
clear all;
filename='A2V2.mp4';
hVideoSrc=VideoReader(filename);
hVPlayer=vision.VideoPlayer;
i=1;
while hasFrame(hVideoSrc)
    frame=readFrame(hVideoSrc);
    imshow(frame);
    
    %[hog1, visualization] = extractHOGFeatures(frame);
    %hold on
    %plot(visualization);
    
    peopleDetector=vision.PeopleDetector;
    [bboxes, score]=peopleDetector(frame);
    if(sum(sum(bboxes))~=0)
        frame1=insertObjectAnnotation(frame,'rectangle',bboxes,score);
        %imshow(frame1);
        FaceDetect = vision.CascadeObjectDetector;
        Fbboxes = FaceDetect(frame1);
        Face=insertObjectAnnotation(frame1,'rectangle',Fbboxes,'Face');
        imshow(Face);    
    end
    step(hVPlayer,frame);
end
release(hVPlayer);