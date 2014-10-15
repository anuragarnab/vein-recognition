# Anurag Arnab - ARNANU002

# Calculate the codeword mapping needed for Fourier LBP
# This was discussed in Appendix A.2
# It would have made more sense to implement this in MATLAB as well
# However, since Python has easier bit-shifting syntax, Python was chosen

patterns = [0] * 256
i = 1
counter = 2
while (i<8):
    j = 0
    num =2**i - 1     
    while (j <= 7):
        temp = num << j
        patterns[temp%255] = counter;
        j=j+1
        counter = counter+1
    i = i+1
    
patterns[0] = 1
patterns[255] = 58