BEGIN {
    data=0;             # Flag to denote data block
}
{
    # Detect end of header
    if(/\[DATA\]/) {
        data=1
    }
    # When in data section
    if(data) {
        if(/^0500/) {
            # New timestamp
            n++;
            if((n%500)==0) {
                for(i=mini+5; i<=maxi; i+=13) {
                    if (int(val[i]/100)==gt) {
                        str="E"
                        if (gt==1) str="+"
                        if (gt==2) str="/"
                        if (gt==3) str="o"
                        if (gt==4) str="[]"
                        if (gt==5) str="/\\\\"
                        if (gt==6) str="\\\\/"
                        if (gt==7) str="O"
                        print (n, (z[i]+z[i-1])/2./0.2, str)
                    }
                }
            }
        } else if (/^0501/) {
            # Read in element positions
            for(i=3; i<=NF; i++) {
                z[i-2]=$i
                if(z[i-2]==0) {
                    mini=i-2
                }
            }
            z[0]=-999
            maxi=NF-2
        } else if (/^0513/) {
            # Read in grain type
            for(i=3; i<=NF; i++) {
                val[i-2]=$i
            }
        }
    }
}
