#! /bin/bash


preProcessorDirectives=();
preProcessKeys=();
preProcessValues=();

checkString=$(cat ./configureSettings.txt);
stringLength=${#checkString};
for ((i=0;i<$stringLength;i++));
do
letter=${checkString:$i:${i+1}};
if [ "$letter" = "$" ];
then
echo "can't edit config";
fi;
done;

configSettings=$(cat -e ./configureSettings.txt);
configure="${configSettings}";


# if [ $(((1 > 0)|(0<3))) ];
# if [ "\n" = "\n" ];
# then
# echo a;
# fi;

stringLength=${#configure}
configureOneLine="";

isRetreiveChar="True";
for ((i=0;i<$stringLength;i++));
do
letter=${configure:$i:${i+1}};

if [ "$letter" = "$" ]
then
letter="";
i=$((${i}+1));
fi;

if [ $isRetreiveChar = "True" ]
then
configureOneLine="${configureOneLine}${letter}";
fi;


done;

pairFirst="";
pairSecond="";
configComplete="";

isCompleted="False";

singleStringLength=${#configureOneLine};


for ((i=0;i<$singleStringLength;i++));
do
letter=${configureOneLine:$i:${i+1}};

if [ "$letter" = "(" ];
then
isPairFirst="True";
letter="";
fi;

if [ "$letter" = "," ];
then
if [ "$isCompleted" = "False" ];
then
if [ "$isPairFirst" = "True" ];
then
isPairSecond="True";
isPairFirst="False";

preProcessKeys[${#preProcessKeys[*]}]=$pairFirst;
preProcessorDirectives[${#preProcessorDirectives[*]}]=$pairFirst;
fi;
fi;

if [ "$isCompleted" = "True" ];
then
isCompleted="False";
fi;

letter="";

fi;

if [ "$letter" = " " ];
then
letter="";
fi;

if [ "$isPairFirst" = "True" ];
then
pairFirst="${pairFirst}${letter}"
fi;

if [ "$letter" = ")" ];
then
preProcessorDirectives[${#preProcessorDirectives[*]}]=$pairSecond;
preProcessValues[${#preProcessValues[*]}]=$pairSecond;

configComplete="-D${pairFirst}=${pairSecond}";
isPairFirst="True";
isPairSecond="False";
isCompleted="True";

pairFirst="";
pairSecond="";

fi;

if [ "$isPairSecond" = "True" ];
then
pairSecond="${pairSecond}${letter}";
fi;

done;

