function [] = plot_pdf( id, history )
    % id refers to the id of the "history" cell.
    % It is effectively the number of clusters for which this pdf is being
    % calculated
    
    data = history(id);
    correct_history = [];
    incorrect_history = [];
    
    for i = 1:length(history(id).correct)
    %for i = 1:12
       correct_history = [correct_history ; data.correct{1, i}(2:end-1)]; 
       incorrect_history = [incorrect_history ; data.incorrect{1, i}];          
    end
    
    size(correct_history)
    size(incorrect_history)
    
    [x1, y1] = generate_pdf(correct_history, 10);
    [x2, y2] = generate_pdf(incorrect_history, 100);
    
    % zero-fill
    epsilon = 0.0001;
    x1 = [min(x1)-epsilon x1 max(x1)+epsilon];
    y1= [0; y1 ;0];
    
    figure
    plot (x1, y1, 'blue');
    hold on
    plot (x2, y2, 'red');
    legend ('Correct', 'Incorrect');
    
end

