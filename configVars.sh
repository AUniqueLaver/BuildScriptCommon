#! /bin/bash

source ./PreProcessorDirectives.sh


PROJECT_DIR="$(pwd)";

PROJECT_DIR=$(echo ${PROJECT_DIR} | sed "s/BuildScripts//g" );
PROJECT_DIR=$(echo ${PROJECT_DIR:0:${#PROJECT_DIR} - 1} );

BUILD_DIR="Build";
for ((i=0;i<${#preProcessorDirectives[*]};i=$((i+2))));
do
firstPair=${preProcessorDirectives[$i]};
secondPair=${preProcessorDirectives[$((i+1))]};

if [ $firstPair = "BUILD_TYPE" ];
then
CONFIG_BUILD_TYPE=$secondPair;
fi;
done;

EXECUTABLE_DIR="${PROJECT_DIR}/Build/${CONFIG_BUILD_TYPE}/bin"
LIB_DIR="${PROJECT_DIR}/Build/${CONFIG_BUILD_TYPE}/lib"

# echo ${PROJECT_DIR}

