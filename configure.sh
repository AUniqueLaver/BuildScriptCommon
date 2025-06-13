#! /bin/bash

source ./PreProcessorDirectives.sh

source ./configVars.sh


export CC="/opt/homebrew/Cellar/llvm/20.1.5/bin/clang";
export CCX="/opt/homebrew/Cellar/llvm/20.1.5/bin/clang++";

export LDFLAGS="-fuse-ld=lld";


isInDirectory="False"
for check in $( ls ../ );
do
if [ $check = ${BUILD_DIR} ];
then
isInDirectory="True"
fi;
done;

if [ ${isInDirectory} = "False" ];
then
mkdir "${PROJECT_DIR}/${BUILD_DIR}";
fi;


cmakePreProcessorDefArgs="";
for ((i=0;i<${#preProcessorDirectives[*]};i=$((i+2))));
do
firstPair=${preProcessorDirectives[$i]};
secondPair=${preProcessorDirectives[$((i+1))]};

cmakePreProcessorArg="-D${firstPair}=${secondPair} ";

if [ $firstPair = "BUILD_TYPE" ];
then
cmakePreProcessorArg="-DCMAKE_BUILD_TYPE=${secondPair} ";
fi;

cmakePreProcessorDefArgs=${cmakePreProcessorDefArgs}${cmakePreProcessorArg};
done;


cmake ${cmakePreProcessorDefArgs} -S ../ -B ../${BUILD_DIR}

