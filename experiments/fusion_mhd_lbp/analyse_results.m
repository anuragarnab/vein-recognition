correct_rate = zeros(length(history),1);
reject_rate = zeros(length(history),1);

for i = 1:length(history)
    correct_rate(i) = history(i).correct_acceptance;
    reject_rate(i) = history(i).correct_rejects;
end

add = correct_rate + reject_rate;
ave = add./2;