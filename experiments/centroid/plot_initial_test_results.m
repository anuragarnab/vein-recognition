correct_history = [correct_record{1,1} correct_record{1,2} correct_record{1, 3} correct_record{1, 4} correct_record{1,5} correct_record{1,6} correct_record{1,7} correct_record{1,8} correct_record{1,9} correct_record{1,10} correct_record{1,11} correct_record{1,12}];

figure
bar (correct_history, 'grouped');
xlabel ('Clusters used');
ylabel ('Points correctly identified (Maximum of 50)');
legend ('Bin 1', 'Bin 2', 'Bin 3', 'Bin 4', 'Bin 5', 'Bin 6', 'Bin 7', 'Bin 8', 'Bin 9', 'Bin 10', 'Bin 11', 'Bin 12');  

col_sums = sum (correct_history, 2);
x = ones (length(col_sums), 1);
x = cumsum(x);

figure
plot (x, col_sums);
xlabel ('Clusters used');
ylabel ('Total number of points correctly identified (Maximum of 600)');