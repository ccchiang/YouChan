function out = ComputeLimbAngles(skeletons)
no_skeletons = size(skeletons, 1);
head = [3 4];
shoulder = [5 9];
torso = [2 3];
hip = [13 17];
ularm = [9 10];
dlarm = [10 11];
urarm = [5 6];
drarm = [6 7];
ulfoot = [17 18];
dlfoot = [18 19];
urfoot = [13 14];
drfoot = [14 15];
knees = [14 18];
elbows = [6 10];
wrists = [7 11];
ankles = [15 19];
all = [head;shoulder;torso;hip;ularm;dlarm;urarm;drarm;...
    ulfoot;dlfoot;urfoot;drfoot;knees;elbows;wrists;ankles];
n = size(all, 1);
vecs = zeros(no_skeletons, 3, n);
tmpv = zeros(no_skeletons, 3, n);
theta_y = zeros(no_skeletons, n);
theta_xz = zeros(no_skeletons, n);
v_yaxis = [zeros(no_skeletons,1) ones(no_skeletons,1) zeros(no_skeletons, 1)];
v_xaxis = [ones(no_skeletons,1) zeros(no_skeletons,1) zeros(no_skeletons, 1)];
for i=1:n
    vecs(:,:,i) = skeletons(:,all(i,1)*3+1:all(i,1)*3+3)- ...
                skeletons(:,all(i,2)*3+1:all(i,2)*3+3);
            
    theta_y(:,i) = sum(vecs(:,:,i).*v_yaxis,2)/norm(vecs(:,:,i));
    tmpv(:,:,i) = vecs(:,:,i);
    tmpv(:,2,i) = 0;
    theta_xz(:,i) = sum(tmpv(:,:,i).*v_xaxis,2)/norm(tmpv(:,:,i));
end
out = zeros(no_skeletons, 2*n);
for i = 1:n
    out(:, 2*i-1:2*i) =  [theta_y(:,i) theta_xz(:,i)];
end
