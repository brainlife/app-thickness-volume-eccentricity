function [] = eccentricityVolumeThickness()

if ~isdeployed
    disp('loading path')

    %for IU HPC
    addpath(genpath('/N/u/brlife/git/jsonlab'))
    addpath(genpath(pwd)) 
end

addpath(genpath(pwd))

% Set top directory
topdir = pwd;

% Load configuration file
config = loadjson('config.json');

colors = distinguishable_colors(6);
hemi = {'lh','rh'};
fovealbins = [1,2,3,4,5];
fovealbinnames = {'zero_to_one','zero_to_two','zero_to_three','zero_to_four','zero_to_five'};

% load surfaces
lh.eccen = gifti(fullfile('lh.benson14_eccen.surf.gii'));
rh.eccen = gifti(fullfile('rh.benson14_eccen.surf.gii'));
lh.volume = gifti(fullfile('lh.volume.surf.gii'));
rh.volume = gifti(fullfile('rh.volume.surf.gii'));
lh.thickness = gifti(fullfile('lh.thickness.surf.gii'));
rh.thickness = gifti(fullfile('rh.thickness.surf.gii'));

%% foveal
for ii = 1:length(fovealbins)
    binName = fovealbinnames{ii};
    
    % index
    lh.fovealIndx.(binName) = find(lh.eccen.cdata <= fovealbins(ii));
    rh.fovealIndx.(binName) = find(rh.eccen.cdata <= fovealbins(ii));
    
    % volume
    lh.vol.foveal.(binName).data = lh.volume.cdata(lh.fovealIndx.(binName));
    lh.vol.foveal.(binName).data = lh.vol.foveal.(binName).data(lh.vol.foveal.(binName).data > 0);
    lh.vol.foveal.(binName).max = nanmax(lh.vol.foveal.(binName).data);
    lh.vol.foveal.(binName).mean = nanmean(lh.vol.foveal.(binName).data);
    jsonStruct.lh.vol.foveal.(binName).mean = nanmean(lh.vol.foveal.(binName).data);
    lh.vol.foveal.(binName).sd = nanstd(lh.vol.foveal.(binName).data);
   
    rh.vol.foveal.(binName).data = rh.volume.cdata(rh.fovealIndx.(binName));
    rh.vol.foveal.(binName).data = rh.vol.foveal.(binName).data(rh.vol.foveal.(binName).data > 0);
    rh.vol.foveal.(binName).max = nanmax(rh.vol.foveal.(binName).data);
    rh.vol.foveal.(binName).mean = nanmean(rh.vol.foveal.(binName).data);
    jsonStruct.rh.vol.foveal.(binName).mean = nanmean(rh.vol.foveal.(binName).data);
    rh.vol.foveal.(binName).sd = nanstd(rh.vol.foveal.(binName).data);
    
    %thickness
    lh.thick.foveal.(binName).data = lh.thickness.cdata(lh.fovealIndx.(binName));
    lh.thick.foveal.(binName).data = lh.thick.foveal.(binName).data(lh.thick.foveal.(binName).data > 0);
    lh.thick.foveal.(binName).max = nanmax(lh.thick.foveal.(binName).data);
    lh.thick.foveal.(binName).mean = nanmean(lh.thick.foveal.(binName).data);
    jsonStruct.lh.thick.foveal.(binName).mean = nanmean(lh.thick.foveal.(binName).data);
    lh.thick.foveal.(binName).sd = nanstd(lh.thick.foveal.(binName).data);
    
    rh.thick.foveal.(binName).data = rh.thickness.cdata(rh.fovealIndx.(binName));
    rh.thick.foveal.(binName).data = rh.thick.foveal.(binName).data(rh.thick.foveal.(binName).data > 0);
    rh.thick.foveal.(binName).max = nanmax(rh.thick.foveal.(binName).data);
    rh.thick.foveal.(binName).mean = nanmean(rh.thick.foveal.(binName).data);
    jsonStruct.rh.thick.foveal.(binName).mean = nanmean(rh.thick.foveal.(binName).data);
    rh.thick.foveal.(binName).sd = nanstd(rh.thick.foveal.(binName).data);
end

%% periphery
% index
lh.periphIndx = find(lh.eccen.cdata > 5);
rh.periphIndx = find(rh.eccen.cdata > 5);

% volume
lh.vol.periph.data = lh.volume.cdata(lh.periphIndx);
lh.vol.periph.data = lh.vol.periph.data(lh.vol.periph.data > 0);
lh.vol.periph.max = nanmax(lh.vol.periph.data);
lh.vol.periph.mean = nanmean(lh.vol.periph.data);
jsonStruct.lh.vol.periph.mean = nanmean(lh.vol.periph.data);
lh.vol.periph.sd = nanstd(lh.vol.periph.data);

rh.vol.periph.data = rh.volume.cdata(rh.periphIndx);
rh.vol.periph.data = rh.vol.periph.data(rh.vol.periph.data > 0);
rh.vol.periph.max = nanmax(rh.vol.periph.data);
rh.vol.periph.mean = nanmean(rh.vol.periph.data);
jsonStruct.rh.vol.periph.mean = nanmean(rh.vol.periph.data);
rh.vol.periph.sd = nanstd(rh.vol.periph.data);

% thickness
lh.thick.periph.data = lh.thickness.cdata(lh.periphIndx);
lh.thick.periph.data = lh.thick.periph.data(lh.thick.periph.data > 0);
lh.thick.periph.max = nanmax(lh.thick.periph.data);
lh.thick.periph.mean = nanmean(lh.thick.periph.data);
jsonStruct.lh.thick.periph.mean = nanmean(lh.thick.periph.data);
lh.thick.periph.sd = nanstd(lh.thick.periph.data);

rh.thick.periph.data = rh.thickness.cdata(rh.periphIndx);
rh.thick.periph.data = rh.thick.periph.data(rh.thick.periph.data > 0);
rh.thick.periph.max = nanmax(rh.thick.periph.data);
rh.thick.periph.mean = nanmean(rh.thick.periph.data);
jsonStruct.rh.thick.periph.mean = nanmean(rh.thick.periph.data);
rh.thick.periph.sd = nanstd(rh.thick.periph.data);

%% generate figures
h.tpfig = figure('name', 'Foveal vs Peripheral','color', 'w', 'visible', 'off');
hold on;
set(h.tpfig,'units','pixels','position',[1000,1000,1000,1000]); hold on;

% volume
% lh
subplot(2,2,1)
title('Volume: LH'); hold on;
xLabel = xlabel('Volume');
yLabel = ylabel('Count (vertices)');
lh_vol_1 = histogram(lh.vol.foveal.zero_to_one.data,'FaceColor',colors(1,:)); hold on;
lh_vol_2 = histogram(lh.vol.foveal.zero_to_two.data,'FaceColor',colors(2,:)); hold on;
lh_vol_3 = histogram(lh.vol.foveal.zero_to_three.data,'FaceColor',colors(3,:)); hold on;
lh_vol_4 = histogram(lh.vol.foveal.zero_to_four.data,'FaceColor',colors(4,:)); hold on;
lh_vol_5 = histogram(lh.vol.foveal.zero_to_five.data,'FaceColor',colors(5,:)); hold on;
lh_vol_periph = histogram(lh.vol.periph.data,'FaceColor',colors(6,:)); hold on;
%leg = legend([lh_vol_1;lh_vol_2;lh_vol_3;lh_vol_4;lh_vol_5;lh_vol_periph],{'Foveal One','Foveal Two', 'Foveal Three','Foveal Four','Foveal Five','periphery'}); hold on;
xlim([0 6]); hold on;
xticks([0:6]); hold on;

% rh
subplot(2,2,2)
title('Volume: RH'); hold on;
xLabel = xlabel('Volume');
yLabel = ylabel('Count (vertices)');
rh_vol_1 = histogram(rh.vol.foveal.zero_to_one.data,'FaceColor',colors(1,:)); hold on;
rh_vol_2 = histogram(rh.vol.foveal.zero_to_two.data,'FaceColor',colors(2,:)); hold on;
rh_vol_3 = histogram(rh.vol.foveal.zero_to_three.data,'FaceColor',colors(3,:)); hold on;
rh_vol_4 = histogram(rh.vol.foveal.zero_to_four.data,'FaceColor',colors(4,:)); hold on;
rh_vol_5 = histogram(rh.vol.foveal.zero_to_five.data,'FaceColor',colors(5,:)); hold on;
rh_vol_periph = histogram(rh.vol.periph.data,'FaceColor',colors(6,:)); hold on;
%leg = legend([rh_vol_1;rh_vol_2;rh_vol_3;rh_vol_4;rh_vol_5;rh_vol_periph],{'Foveal One','Foveal Two', 'Foveal Three','Foveal Four','Foveal Five','periphery'}); hold on;
xlim([0 6]); hold on;
xticks([0:6]); hold on;

% thickness
% lh
subplot(2,2,3)
title('Thickness: LH'); hold on;
xLabel = xlabel('Thickness');
yLabel = ylabel('Count (vertices)');
lh_thick_1 = histogram(lh.thick.foveal.zero_to_one.data,'FaceColor',colors(1,:)); hold on;
lh_thick_2 = histogram(lh.thick.foveal.zero_to_two.data,'FaceColor',colors(2,:)); hold on;
lh_thick_3 = histogram(lh.thick.foveal.zero_to_three.data,'FaceColor',colors(3,:)); hold on;
lh_thick_4 = histogram(lh.thick.foveal.zero_to_four.data,'FaceColor',colors(4,:)); hold on;
lh_thick_5 = histogram(lh.thick.foveal.zero_to_five.data,'FaceColor',colors(5,:)); hold on;
lh_thick_periph = histogram(lh.thick.periph.data,'FaceColor',colors(6,:)); hold on;
%leg = legend([lh_thick_1;lh_thick_2;lh_thick_3;lh_thick_4;lh_thick_5;lh_thick_periph],{'Foveal One','Foveal Two', 'Foveal Three','Foveal Four','Foveal Five','periphery'}); hold on;
xlim([0 6]); hold on;
xticks([0:6]); hold on;

% rh
subplot(2,2,4)
title('Thickness: RH'); hold on;
xLabel = xlabel('Thickness');
yLabel = ylabel('Count (vertices)');
rh_thick_1 = histogram(lh.thick.foveal.zero_to_one.data,'FaceColor',colors(1,:)); hold on;
rh_thick_2 = histogram(rh.thick.foveal.zero_to_two.data,'FaceColor',colors(2,:)); hold on;
rh_thick_3 = histogram(rh.thick.foveal.zero_to_three.data,'FaceColor',colors(3,:)); hold on;
rh_thick_4 = histogram(rh.thick.foveal.zero_to_four.data,'FaceColor',colors(4,:)); hold on;
rh_thick_5 = histogram(rh.thick.foveal.zero_to_five.data,'FaceColor',colors(5,:)); hold on;
rh_thick_periph = histogram(rh.thick.periph.data,'FaceColor',colors(6,:)); hold on;
leg = legend([rh_thick_1;rh_thick_2;rh_thick_3;rh_thick_4;rh_thick_5;rh_thick_periph],{'FovOne','FovTwo', 'FovThree','FovFour','FovFive','periphery'}); hold on;
xlim([0 6]); hold on;
xticks([0:6]); hold on;

saveas(h.tpfig, 'foveal_v_periph', 'png');

%% generate output product.json
savejson('', jsonStruct, fullfile(topdir, 'product.json'));

save('output.mat','lh','rh','fovealbins','fovealbinnames','-v7.3');

clear
exit;
end
