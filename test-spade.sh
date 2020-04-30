#!/bin/bash

~/SPADE/bin/spade start

echo "Sleeping for 5 seconds"; sleep 5

echo add storage Neo4j database=/tmp/spade_database | ~/SPADE/bin/spade control
echo add reporter DSL /tmp/spade_pipe | ~/SPADE/bin/spade control
echo add analyzer CommandLine | ~/SPADE/bin/spade control

echo "Sleeping for 10 seconds"; sleep 10

echo type:Process id:1 name:root\\ process pid:10 >> /tmp/spade_pipe 
echo type:Process id:2 name:child\\ process pid:32 >> /tmp/spade_pipe 
echo type:WasTriggeredBy from:2 to:1 time:5\\:56\\ PM >> /tmp/spade_pipe 
echo type:Artifact id:3 filename:output.tmp >> /tmp/spade_pipe 
echo type:Artifact id:4 filename:output.o >> /tmp/spade_pipe 
echo type:Used from:2 to:3 iotime:12\\ ms >> /tmp/spade_pipe 
echo type:WasGeneratedBy from:4 to:2 iotime:11\\ ms >> /tmp/spade_pipe 
echo type:WasDerivedFrom from:4 to:3 >> /tmp/spade_pipe 
echo type:Agent id:user uid:10 gid:10 name:john >> /tmp/spade_pipe 
echo type:WasControlledBy from:1 to:user >> /tmp/spade_pipe 
echo type:WasControlledBy from:2 to:user >> /tmp/spade_pipe 

# NOTE: spade query does not exit on EOF, but endlessly repeats prompt
echo -e 'set storage Neo4J \n quit' | ~/SPADE/bin/spade query
echo -e 'dump $base \n quit' | ~/SPADE/bin/spade query
# should be 5 vertices and 6 edges
