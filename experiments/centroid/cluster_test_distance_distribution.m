%num_clusters = 8;

load veins

block_size = 50;
number_testing = 600;

history = [];

% try our different numbers of clusters
for num_clusters = 2:1:191

    clusters = [];
    choices = [];

    incorrect_score = cell(1, ceil(number_testing/block_size) );
    correct_score = cell(1, ceil(number_testing/block_size) );

    for q = 1:size(correct_score,2)
       incorrect_score{1,q} = 0;
       correct_score{1,q} = 0;
    end

    % train the classifier
    for i = 1:6:595
        clusters(ceil(i/6)).cluster = get_cluster(num_clusters, i, veins);
    end
    
    total_correct = 0; % Total correct for that number of clusters

    for block_start = 1:block_size:number_testing

        correct = 0; % Total correct for a certain block

        for k = block_start:block_start+block_size-1 
            scores = zeros(length(clusters),1);
            for j = 1:length(clusters)
                scores(j) = get_score(clusters(j).cluster, [veins(k).x veins(k).y]);

                % for the distribution
                if (j == ceil(k/6))        %k/6 is the correct answer
                    correct_score{:,ceil(block_start/block_size)} = [ correct_score{:,ceil(block_start/block_size)} ; scores(j) ];
                else
                    incorrect_score{:,ceil(block_start/block_size)} = [ incorrect_score{:,ceil(block_start/block_size)} ; scores(j) ];  
                end
            end
            
            [val, idx] = min (scores);

            if ( idx == ceil(k/6))
                correct = correct + 1; 
            end

            choices = [choices idx];           
        end

        correct_score{:,ceil(block_start/block_size)} = [ correct_score{:,ceil(block_start/block_size)} ; correct ];
        total_correct = total_correct + correct;
    end

    history(num_clusters).correct = correct_score;
    history(num_clusters).incorrect = incorrect_score;
    total_correct
        %correct_record = [correct_record correct];
        %correct_record(:,ceil(i/block_size)) = [correct_record(:,ceil(i/block_size)) ; correct];

end

save kmeans_extended_test history correct_score