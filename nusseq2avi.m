function nusseq2avi(optsdataset)

actions = dir(optsdataset.seqdata);
actions(1:2) = [];
sz = [240 NaN];

for i=1:length(actions)
    
    if(~exist([optsdataset.folder '/' actions(i).name],'dir'))
        mkdir([optsdataset.folder '/' actions(i).name])
    end
    
    list = dir(fullfile(optsdataset.seqdata,actions(i).name,'*.seq'));
    for j=1:length(list)
        
        filename = fullfile(optsdataset.folder,actions(i).name,[list(j).name(1:end-4) '.avi']);
        tempdir = fullfile(optsdataset.seqdata,actions(i).name,[num2str(j) '_lock']);
        if(exist(filename,'file'))
            continue;
        elseif(exist(tempdir,'dir'))
            continue;
        else
            mkdir(tempdir)
        end
                
        disp(['currently processing - ' num2str(j) ' in action ' actions(i).name])    
        seqfilename = fullfile(optsdataset.seqdata,actions(i).name,list(j).name);
        nus_convertseqtoavi(seqfilename,filename,sz,tempdir);
        if(exist(tempdir,'dir'))
            rmdir(tempdir, 's')
        end
    end
end
end

function nus_convertseqtoavi(seqfilename,filename,sz,tempdir)
info = seqIo( seqfilename, 'getInfo' );
Is = seqIo(seqfilename, 'toImgs', tempdir);

myObj = VideoWriter(filename);
myObj.FrameRate = info.fps;
open(myObj)
list = dir(fullfile(tempdir,'*.*'));
list = list(~ismember({list.name}, {'.','..'}));
for j=1:info.numFrames
    Img = imread(fullfile(tempdir,list(j).name));
    I = imresize(Img,sz,'nearest');
    writeVideo(myObj,I);
end
close(myObj);
end
