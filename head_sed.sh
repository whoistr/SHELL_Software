#!/bin/bash
count=$(echo $1 | sed 's/^-//')
shift 
sed ${count}q $1
 
