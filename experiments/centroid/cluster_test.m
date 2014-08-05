%num_clusters = 8;

block_size = 50;
correct_record = cell(1,2);
for q = 1:size(correct_record,2)
   correct_record{1,q} = 0; 
end

% try our different numbers of clusters
for num_clusters = 1:1:20

clusters = [];
choices = [];
    
    % train the classifier
    for i = 1:6:595
        clusters(ceil(i/6)).cluster = get_cluster(num_clusters, i, veins);
    end

    total_correct = 0; % Total correct for that number of clusters

        for block_start = 1:block_size:100
           
           correct = 0; % Total correct for a certain block
            
           for k = block_start:block_start+block_size-1 
               scores = zeros(length(clusters),1);
               for j = 1:length(clusters)
                  scores(j) = get_score(clusters(j).cluster, [veins(k).x veins(k).y]);
               end
               [val, idx] = min (scores);

               if ( idx == ceil(k/6))
                  correct = correct + 1; 
               end

               choices = [choices idx];           
           end
           
           correct_record{:,ceil(block_start/block_size)} = [ correct_record{:,ceil(block_start/block_size)} ; correct ];
           total_correct = total_correct + correct;
        end

    total_correct
    %correct_record = [correct_record correct];
    %correct_record(:,ceil(i/block_size)) = [correct_record(:,ceil(i/block_size)) ; correct];

end
