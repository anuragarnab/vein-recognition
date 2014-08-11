id = 52;

cl = train_cluster(6,100,80,veins);
count = 0;
figure

for i=6*(id-1)+1:6*id
    id
    scatter ( veins(i).x, veins(i).y, 'blue' ); 
    count = count + length(veins(i).x);
    hold on
end

scatter ( cl(id).cluster(:,1), cl(id).cluster(:,2), 'red');
count