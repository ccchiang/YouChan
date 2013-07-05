function out = ComputeLimbAngles(skeletons)
no_skeletons = size(skeletons, 1);
head = [2 4];
neck = [2 3];
leftshoulder = [2 5];
rightshoulder = [2 9];
leftelbow = [2 6];
rightelbow = [2 10];
leftwrist = [2 7];
rightwrist = [2 11];
leftknee = [2 14];
rightknee = [2 18];
leftankel = [2 15];
rightankel = [2 19];
lefthand = [2 8];
righthand = [2 12];
leftfoot = [2 16];
rightfoot = [2 20];
all = [head;neck;leftshoulder;rightshoulder;leftelbow;...
    rightelbow;leftwrist;rightwrist;leftknee;rightknee;...
    leftankel;rightankel;lefthand;righthand;...
    leftfoot;rightfoot];
n = size(all, 1);
vecs = zeros(no_skeletons, 3, n);
tmpv = zeros(no_skeletons, 3, n);
theta_x = zeros(no_skeletons, n);
theta_y = zeros(no_skeletons, n);
theta_z = zeros(no_skeletons, n);
v_xaxis = [ones(no_skeletons,1) zeros(no_skeletons,1) zeros(no_skeletons, 1)];
v_yaxis = [zeros(no_skeletons,1) ones(no_skeletons,1) zeros(no_skeletons, 1)];
v_zaxis = [zeros(no_skeletons,1) zeros(no_skeletons,1) ones(no_skeletons, 1)];
for i=1:n
    vecs(:,:,i) = skeletons(:,all(i,1)*3-2:all(i,1)*3)- ...
                skeletons(:,all(i,2)*3-2:all(i,2)*3);
    tmpv(:,:,i) = vecs(:,:,i);
    vnorm = sqrt(tmpv(:,1,1).^2+tmpv(:,2,1).^2);
    theta_x(:,i) = sum(tmpv(:,:,i).*v_xaxis,2)./vnorm;
    theta_y(:,i) = sum(tmpv(:,:,i).*v_zaxis,2)./vnorm;
    theta_z(:,i) = sum(tmpv(:,:,i).*v_yaxis,2)./vnorm;
end
out = zeros(no_skeletons, 3*n);
for i = 1:n
    out(:, 3*i-2:3*i) =  [theta_x(:,i) theta_y(:,i) theta_x(:,i)];
end
