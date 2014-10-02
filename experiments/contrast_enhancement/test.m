%drag palm-vein image into workspace
%hand = rgb2gray(hand);
figure
subplot(2,1,1);
imshow (hand);
subplot (2,1,2);
imhist(hand);

hand_norm = normalise (im2double (hand) );
hand_norm = uint8(hand_norm);
figure
subplot(2,1,1)
imshow(hand_norm);
subplot(2,1,2);
imhist(hand_norm);

hand_c = adapthisteq(hand);
figure
subplot(2,1,1);
imshow (hand_c);
subplot(2,1,2);
imhist(hand_c)

figure
subplot(1,3,1)
imshow(hand)
subplot(1,3,2)
imshow(hand_norm)
subplot(1,3,3)
imshow(hand_c)

figure
subplot(1,3,1)
imhist(hand)
subplot(1,3,2)
imhist(hand_norm)
subplot(1,3,3)
imhist(hand_c)
