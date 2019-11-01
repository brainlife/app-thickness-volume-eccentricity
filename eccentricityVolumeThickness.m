function [] = eccentricityVolumeThickness()

if ~isdeployed
    disp('loading path')

    %for IU HPC
    addpath(genpath('/N/u/brlife/git/jsonlab'))
    
    %for old VM
    addpath(genpath('/usr/local/jsonlab'))
end

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
    lh.vol.foveal.(binName) = lh.volume.cdata(lh.fovealIndx.(binName));
    lh.vol.foveal.(binName) = lh.vol.foveal.(binName)(lh.vol.foveal.(binName) > 0);
    rh.vol.foveal.(binName) = rh.volume.cdata(rh.fovealIndx.(binName));
    rh.vol.foveal.(binName) = rh.vol.foveal.(binName)(rh.vol.foveal.(binName) > 0);
    
    %thickness
    lh.thick.foveal.(binName) = lh.thickness.cdata(lh.fovealIndx.(binName));
    lh.thick.foveal.(binName) = lh.thick.foveal.(binName)(lh.thick.foveal.(binName) > 0);
    rh.thick.foveal.(binName) = rh.thickness.cdata(rh.fovealIndx.(binName));
    rh.thick.foveal.(binName) = rh.thick.foveal.(binName)(rh.thick.foveal.(binName) > 0);
end

%% periphery
% index
lh.periphIndx = find(lh.eccen.cdata > 5);
rh.periphIndx = find(rh.eccen.cdata > 5);

% volume
lh.vol.periph = lh.volume.cdata(lh.periphIndx);
lh.vol.periph = lh.vol.periph(lh.vol.periph > 0);
rh.vol.periph = rh.volume.cdata(rh.periphIndx);
rh.vol.periph = rh.vol.periph(rh.vol.periph > 0);

% thickness
lh.thick.periph = lh.thickness.cdata(lh.periphIndx);
lh.thick.periph = lh.thick.periph(lh.thick.periph > 0);
rh.thick.periph = rh.thickness.cdata(rh.periphIndx);
rh.thick.periph = rh.thick.periph(rh.thick.periph > 0);

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
lh_vol_1 = histogram(lh.vol.foveal.zero_to_one,'FaceColor',colors(1,:)); hold on;
lh_vol_2 = histogram(lh.vol.foveal.zero_to_two,'FaceColor',colors(2,:)); hold on;
lh_vol_3 = histogram(lh.vol.foveal.zero_to_three,'FaceColor',colors(3,:)); hold on;
lh_vol_4 = histogram(lh.vol.foveal.zero_to_four,'FaceColor',colors(4,:)); hold on;
lh_vol_5 = histogram(lh.vol.foveal.zero_to_five,'FaceColor',colors(5,:)); hold on;
lh_vol_periph = histogram(lh.vol.periph,'FaceColor',colors(6,:)); hold on;
%leg = legend([lh_vol_1;lh_vol_2;lh_vol_3;lh_vol_4;lh_vol_5;lh_vol_periph],{'Foveal One','Foveal Two', 'Foveal Three','Foveal Four','Foveal Five','periphery'}); hold on;
xlim([0 6]); hold on;
xticks([0:6]); hold on;

% rh
subplot(2,2,2)
title('Volume: RH'); hold on;
xLabel = xlabel('Volume');
yLabel = ylabel('Count (vertices)');
rh_vol_1 = histogram(lh.vol.foveal.zero_to_one,'FaceColor',colors(1,:)); hold on;
rh_vol_2 = histogram(rh.vol.foveal.zero_to_two,'FaceColor',colors(2,:)); hold on;
rh_vol_3 = histogram(rh.vol.foveal.zero_to_three,'FaceColor',colors(3,:)); hold on;
rh_vol_4 = histogram(rh.vol.foveal.zero_to_four,'FaceColor',colors(4,:)); hold on;
rh_vol_5 = histogram(rh.vol.foveal.zero_to_five,'FaceColor',colors(5,:)); hold on;
rh_vol_periph = histogram(rh.vol.periph,'FaceColor',colors(6,:)); hold on;
%leg = legend([rh_vol_1;rh_vol_2;rh_vol_3;rh_vol_4;rh_vol_5;rh_vol_periph],{'Foveal One','Foveal Two', 'Foveal Three','Foveal Four','Foveal Five','periphery'}); hold on;
xlim([0 6]); hold on;
xticks([0:6]); hold on;

% thickness
% lh
subplot(2,2,3)
title('Thickness: LH'); hold on;
xLabel = xlabel('Thickness');
yLabel = ylabel('Count (vertices)');
lh_thick_1 = histogram(lh.thick.foveal.zero_to_one,'FaceColor',colors(1,:)); hold on;
lh_thick_2 = histogram(lh.thick.foveal.zero_to_two,'FaceColor',colors(2,:)); hold on;
lh_thick_3 = histogram(lh.thick.foveal.zero_to_three,'FaceColor',colors(3,:)); hold on;
lh_thick_4 = histogram(lh.thick.foveal.zero_to_four,'FaceColor',colors(4,:)); hold on;
lh_thick_5 = histogram(lh.thick.foveal.zero_to_five,'FaceColor',colors(5,:)); hold on;
lh_thick_periph = histogram(lh.thick.periph,'FaceColor',colors(6,:)); hold on;
%leg = legend([lh_thick_1;lh_thick_2;lh_thick_3;lh_thick_4;lh_thick_5;lh_thick_periph],{'Foveal One','Foveal Two', 'Foveal Three','Foveal Four','Foveal Five','periphery'}); hold on;
xlim([0 6]); hold on;
xticks([0:6]); hold on;

% rh
subplot(2,2,4)
title('Thickness: RH'); hold on;
xLabel = xlabel('Thickness');
yLabel = ylabel('Count (vertices)');
rh_thick_1 = histogram(lh.thick.foveal.zero_to_one,'FaceColor',colors(1,:)); hold on;
rh_thick_2 = histogram(rh.thick.foveal.zero_to_two,'FaceColor',colors(2,:)); hold on;
rh_thick_3 = histogram(rh.thick.foveal.zero_to_three,'FaceColor',colors(3,:)); hold on;
rh_thick_4 = histogram(rh.thick.foveal.zero_to_four,'FaceColor',colors(4,:)); hold on;
rh_thick_5 = histogram(rh.thick.foveal.zero_to_five,'FaceColor',colors(5,:)); hold on;
rh_thick_periph = histogram(rh.thick.periph,'FaceColor',colors(6,:)); hold on;
leg = legend([rh_thick_1;rh_thick_2;rh_thick_3;rh_thick_4;rh_thick_5;rh_thick_periph],{'FovOne','FovTwo', 'FovThree','FovFour','FovFive','periphery'}); hold on;
xlim([0 6]); hold on;
xticks([0:6]); hold on;

saveas(h.tpfig, 'foveal_v_periph', 'png');

save('output.mat','lh','rh','fovealbins','fovealbinnames','-v7.3');

clear
exit;
end
