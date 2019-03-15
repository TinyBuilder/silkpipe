#!/bin/bash
if ./assemble.sh $1; then
else
    ./assemble_all.sh $1
fi
./extend.sh $1
./blast.sh $1
./annotate.py $1
