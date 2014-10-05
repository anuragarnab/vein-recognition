for i =1:length(v1)
   v1(i).flbp = fourier_lbp(v1(i).ulbp_hist); 
   v1_unreg(i).flbp = fourier_lbp(v1_unreg(i).ulbp_hist); 
end