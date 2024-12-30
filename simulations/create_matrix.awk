BEGIN {
    data=0;             # Flag to denote data block
    yri=int(yr/res+0.5) # Vertical dimension in pixels
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
            if(n!=1) {
                # When n>1, we have processed some data, store it:
                dates[d]=d; # Store the timestamp
                idxn=0;     # index that covers the full vertical domain, starting from the top. It keeps track of where we are with filling a vertical column
                # Now loop over all the elements, starting from the top
                for(j=maxi-1; j>mini; j--) {
                    # Now calculate the upper and lower vertical index that is covered by the element j
                    idx=int((yr-z[j])/res+0.5)      # Lower
                    idx0=int((yr-z[j+1])/res+0.5)   # Upper
                    if(idx0>idxn+1 && idxn==0) {
                        # Fill above the first element with nodata
                        for(i=idxn+1; i<=idx0-1; i++) {
                            temp[d,i] = -9999
                        }
                        idxn=i
                    }
                    if(idx>idxn) {
                        # Fill the element
                        for(i=idxn+1; i<=idx; i++) {
                            temp[d,i] = ((val[j]==-999)?(-9999):(val[j]))
                        }
                        idxn=idx
                    }
                    if(idxn<yri) {
                        # Fill the remaining part below with nodata
                        for(i=idxn+1; i<=yri; i++) {
                            temp[d,i]=-9999
                        }
                    }
                }
            }
            d=sprintf("%04d-%02d-%02dT%02d:%02d", substr($NF,7,4), substr($NF,4,2), substr($NF,1,2), substr($NF,12,2), substr($NF,15,2))
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
        } else if ($0 ~ ("^" var)) {
            # Read in requested element variable
            for(i=3; i<=NF; i++) {
                val[i-2]=$i
            }
        }
    }
} END {
    # Generate output
    n=asort(dates);
    # Print header row, containing the timestamps
    for(k in dates) {
        printf "%s ", dates[k]
    }
    printf "\n"
    for(l=1; l<=yri; l++) {
        for(k in dates) {
            m=dates[k];
            txt=temp[m,l];
            printf "%s ", (txt=="")?(-9999):(txt)
        }
        printf "\n"
    }
}
