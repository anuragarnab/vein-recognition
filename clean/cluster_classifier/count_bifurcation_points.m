% Counts the number of bifurcations in each cluster
% Used to create the histogram in Chapter 5

num_per_sample = 6;
num_bifs = zeros(length(veins)/num_per_sample,1);
nice_blue = [0.3569 0.6078 0.8353];

count = 0;
for i = 1:length(veins)/num_per_sample
    temp = 0;
    for j = 1:6
        count = count+1;
        if (j == 6)
            continue;
        end
        temp = temp + length(veins(count).x);
        
    end
    num_bifs(i) = temp;
end

mean(num_bifs)
figure
hist(num_bifs, 20);
set (findobj(gca,'Type','patch'), 'FaceColor', nice_blue)
goodplot()
myaa
