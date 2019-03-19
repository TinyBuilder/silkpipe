#!/bin/bash
./assemble.sh $1
./extend.sh $1
./blast.sh $1
./annotate.py $1
