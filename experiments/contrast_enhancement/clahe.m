im = rgb2gray ( imread ('1.jpg') );

im = im ( 100:700 , 100:900 ); 
imc = adapthisteq(im);
%imagesc (imc);
%colormap (gray);

%imagesc ( imc < 90);
