tdata = load('tdata_a.txt');
qdata = load('qdata_a.txt');
k = 50;
[labels, centers, compactness] = kmeans(tdata, k, 'MaxIter', 500);
matcher = cv.DescriptorMatcher('BruteForce');
matcher.add(centers);
matches1 = matcher.match(qdata);
newqdata = zeros(size(matches1,2), size(centers,2));
newtdata = zeros(size(matches2,2), size(centers,2));
for i=1:size(matches1,2)
    newqdata(i,:) = centers(matches1(i).trainIdx+1,:);
end
matches2 = matcher.match(tdata);
for i=1:size(matches2,2)
    newtdata(i,:) = centers(matches2(i).trainIdx+1,:);
end
save -ascii 'qdata_ea.txt' newqdata;
save -ascii 'tdata_ea.txt' newtdata;