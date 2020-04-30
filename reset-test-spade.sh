#!/bin/bash

echo remove storage Neo4j database=/tmp/spade_database | ~/SPADE/bin/spade control
echo remove reporter DSL /tmp/spade_pipe | ~/SPADE/bin/spade control
echo remove analyzer CommandLine | ~/SPADE/bin/spade control

rm -r /tmp/spade_database
rm /tmp/spade_pipe

~/SPADE/bin/spade stop

sleep 1
ps aux | grep -i [s]pade
