#i = 0
#patterns = [None] * 256

#patterns[0] = 56
#patterns[255] = 56

#while (i<8):
    #j = 1
    #while (j <= 7):
        
        #binary_string = (1 << j)-1
        #binary_string = binary_string << i
        #binary_string = (binary_string | binary_string >> 8) & 0xff
        
        #patterns[binary_string] = i * 7 + (j-1) + 1 # I am adding the plus 1
        #j = j+1
    #i = i+1

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