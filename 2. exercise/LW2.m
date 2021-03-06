% Your implementation should run by executing this m-file ("run LW1.m"), 
% but feel free to create additional files for your own functions
% Make sure it runs without errors after unzipping

% Fill out the information below

% Group members:
% Additional tasks completed (5, 6, 7, 8):

% Fill in your implementation at the assigned slots. You can use the existing 
% drawing scripts or draw your own figures 
% To give an impression of the scope of each task, 
% the number of lines of code in the reference implementation is given
% This is highly subjective depending on coding style, and should not
% be considered as a requirement. Use as much code as you need, but if you
% start having 10 times the lines, you may consider that there might be an
% easier way to do it


load synthdata

%% Task 1: Plotting global point cloud (8 lines of code)
% Back projection from PMD image plane to global space 


% Plotting
figure; hold on;
scatter3(X(1, :), X(2, :), X(3, :), 10, X(3, :));
scatter3(0, 0, 0, 500, 'rx')
title('Task 1: Point cloud in global (x,y,z) space');
set(gca,'YDir','reverse');
set(gca,'ZDir','reverse');
axis equal
drawnow;
%% Task 2: Projection to color camera image plane (5 lines of code)




% Plotting
figure; axis equal
imshow(Image, []); hold on; %#ok<*NODEF>

% Only drawing the objects in front to check alignment
objectmask = z_colorcam<13;
sc = scatter(u_colorcam(objectmask), v_colorcam(objectmask), 10, z_colorcam(objectmask), 'filled');
sc.MarkerEdgeAlpha = 0.1;
sc.MarkerFaceAlpha = 0.1;
title( 'Task 2: Global depth points projected on image plane of the color camera');
drawnow;

%% Task 3 Resampling projected data (3 lines of code)




% Plotting
figure;
subplot( 131); imshow( Image, []); title('Task 3: Original color image')
subplot( 132); imshow( z_colorcam_reg, []); title('Task 3: Resampled depth image');
subplot( 133); imshowpair( Image, z_colorcam_reg); title('Task 3: Resampled depth on original color')

%%
% Task 4 Visualizing combined depth/color data

% Well, actually, this one is just plotting so you're done already
figure; 
surf(z_colorcam_reg, double(Image), 'EdgeColor', 'none')
set(gca,'ZDir','reverse');
set(gca,'YDir','reverse');
title( 'Task 4: 3D mesh generated from resampled depth')
drawnow;

%% Task 5 Artifact removal (6 lines of code)

% Just plotting here, add your implementation to the edgeRemoval.h function
figure; 
h = surf(z_colorcam_reg, double(Image), 'EdgeColor', 'none');
set(gca,'ZDir','reverse');
set(gca,'YDir','reverse');
title( 'Task 5: 3D mesh generated from resampled depth with edge artifacts removed')
edgeRemoval(h);


%% Task 6 Color resampling (4 lines of code)



% Plotting
figure; 

subplot( 231); imshow( Image, []); title('Task 3: Original color image')
subplot( 232); imshow( z_colorcam_reg, []); title('Task 3: Resampled depth image');
subplot( 233); imshowpair( Image, z_colorcam_reg); title('Task 3: Resampled depth on original color')

subplot( 234); imshow( resampledColorImage, []); title('Task 6: Resampled color image')
subplot( 235); imshow( z, []); title('Task 6: Original depth image');
subplot( 236); imshowpair( resampledColorImage, z); title('Task 6: Resampled color on original depth')
drawnow;



%%
% Task 7 - Z-buffering (19 lines of code)





% Plotting
figure;
subplot(131);
axis equal
scatter(u_colorcam, v_colorcam, 10, z_colorcam)
ylim([0 size(Depth, 1)]); xlim([0 size(Depth, 2)]);
title( 'Irregular'); set(gca,'YDir','reverse'); axis equal; drawnow;

subplot(132);
axis equal
scatter(uc(:), vc(:), 10, z_colorcam_reg(:))
ylim([0 size(Depth, 1)]); xlim([0 size(Depth, 2)]);
title( 'Regular'); set(gca,'YDir','reverse'); axis equal; drawnow;

subplot(133);
axis equal
scatter(uc(:), vc(:), 10, z_colorcam_reg_zbuf(:))
ylim([0 size(Depth, 1)]); xlim([0 size(Depth, 2)]);
title( 'Regular z-buffered'); set(gca,'YDir','reverse'); axis equal; drawnow;
 

figure; 
subplot(231); imshow( z_colorcam_reg, []);
title( 'Task 7: Depth data resampled into a regular grid ');
subplot(234); imshow( z_colorcam_reg_zbuf, []);
title( 'Task 7: Depth data resampled into a regular grid after Z-buffering');
subplot(2, 3, [2 3 5 6]); h = surf(z_colorcam_reg_zbuf, double(Image), 'EdgeColor', 'none');
set(gca,'ZDir','reverse');
title( 'Task 7: Z-buffering 3D mesh generated from resampled depth')
edgeRemoval(h);
drawnow;
%% Task 8 (14 lines of code)



% Plotting
figure;
scatter3(u_colorcam, v_colorcam, z_colorcam(:), 10, z_colorcam(:));
hold on;
plot(planeModel)
scatter3(u_missing, v_missing, z_missing, 50, 'gx');
set(gca,'YDir','reverse');
set(gca,'ZDir','reverse');
title('UVZ-point cloud with the plane fit (red) and missing pixels (green)')
drawnow;


figure; 
subplot(231); imshow( z_colorcam_reg_zbuf, []);
title( 'Task 7: Depth data resampled into a regular grid after Z-buffering ');
subplot(234); imshow( z_colorcam_reg_zbuf_filled, []);
title( 'Task 7: Depth data resampled into a regular grid after Z-buffering and occlusion filling');

subplot(2, 3, [2 3 5 6]); h = surf(z_colorcam_reg_zbuf_filled, double(Image), 'EdgeColor', 'none')
set(gca,'ZDir','reverse');
title( 'Task 8: Z-buffering 3D mesh generated from resampled depth')
edgeRemoval(h);
drawnow;





