clear;clc

% add path of Piotr Dollar's toolbox
addpath(genpath('/home/tranlaman/Desktop/cv-workspace/mytoolbox/toolbox'));

% initalize optsdataset
optsdataset.seqdata = '/home/tranlaman/Public/data/video/Olympic_Sports/';
optsdataset.folder = '/home/tranlaman/Public/data/video/Olympic_Sports_avi/';
%seq2avi(optsdataset)
nusseq2avi(optsdataset)