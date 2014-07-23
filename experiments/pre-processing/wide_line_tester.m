% Some results:
% best_r = 10, best_g = 150, best_corr = 0.327. Overall => Shit!


image = get_roi ('images/11.bmp');
fvr = ones (size (image) );

vein_control = miura_max_curvature ( im2double(image) , fvr, 3);
med = median (vein_control (vein_control > 0) );
vein_control = (vein_control > med);
test_matrix = ones (50, 50);

best_corr = 0;
best_r = 0;
best_g = 0;
best_t = 0;
t = 1;
%veins = huang_wide_line(image,fvr,r,t,g);

for r_test = 8:15
   
    %what is the max value for g using the given radius?
    g_max = m (test_matrix, 25, 25, 1, r_test);
    fprintf ('Testing r = %i, with g_max = %i \n', r_test, g_max);
    
    for g_test = 1:g_max
        
        for t = 1:10
            vein = huang_wide_line (image, fvr, r_test, t, g_test);
            correlation = cross_corr_normalised (vein_control, vein);
           % fprintf ('Correlation = %i \n', correlation);

            if (correlation > best_corr)
               best_corr = correlation;
               best_r = r_test;
               best_g = g_test;
               best_t = t;
            end
        
        end
        
    end
    
end