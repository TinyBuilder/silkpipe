#!/bin/bash
./extend.sh $1
./blast.sh $1
./annotate.py $1
