MINER01="1680"
MINER02="1681"
MINER03="1682"
MINER04="1683"
NAME01="miner01"
NAME02="miner02"
NAME03="miner03"
NAME04="miner04"
while true; do 
    bloop=$(curl https://api.helium.io/v1/blocks/height)
    blah=$(echo $bloop | rev | cut -d":" -f1 | rev)
    actual=$(echo $blah | rev |cut -b 3- | rev)

    clear
    echo " "
    echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
    datenow=$(date)
    echo "\033[32m$datenow\033[m"
    echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
    echo " "

    test01=$(ps -ef | grep "$MINER01")
    running01=$(echo $test01 | wc -c)
    test02=$(ps -ef | grep "$MINER02")
    running02=$(echo $test02 | wc -c)
    test03=$(ps -ef | grep "$MINER03")
    running03=$(echo $test03 | wc -c)
    test04=$(ps -ef | grep "$MINER04")
    running04=$(echo $test04 | wc -c)

    if [ $running01 -gt 100 ]
    #echo "Miner01 $running01"
    then
        minerHeight01=$(docker exec $NAME01 miner info height | awk '{print $2}')
        testVal01=$(expr $actual - $minerHeight01)   
        if [ $testVal01 -ge 1 ]
        then
            echo "Miner01 Height:\033[1m $minerHeight01\033[0m    \033[41m$testVal01\033[m"
        else
            echo "Miner01 Height:\033[1m $minerHeight01\033[0m    \033[33m$testVal01\033[m"
        fi
        echo "MINER01, $datenow, $testVal01" >> log.out
    fi

    if [ $running02 -gt 100 ]
    then   
        minerHeight02=$(docker exec $NAME02 miner info height | awk '{print $2}')
        testVal02=$(expr $actual - $minerHeight02)   
        if [ $testVal02 -ge 1 ] 
        then
            echo "Miner02 Height:\033[1m $minerHeight02\033[0m    \033[41m$testVal02\033[m"
        else
            echo "Miner02 Height:\033[1m $minerHeight02\033[0m    \033[33m$testVal02\033[m"
        fi
        echo "MINER02, $datenow, $testVal02" >> log.out
    fi

    if [ $running03 -gt 100 ]
    then
        minerHeight03=$(docker exec $NAME03 miner info height | awk '{print $2}')
        testVal03=$(expr $actual - $minerHeight03)   
        if [ $testVal03 -ge 1 ] 
        then
            echo "Miner03 Height:\033[1m $minerHeight03\033[0m    \033[41m$testVal03\033[m"
        else
            echo "Miner03 Height:\033[1m $minerHeight03\033[0m    \033[33m$testVal03\033[m"
        fi
        echo "MINER03, $datenow, $testVal03" >> log.out
    fi

    if [ $running04 -gt 100 ]
    #echo "Miner04 $running04"
    then
        minerHeight04=$(docker exec $NAME04 miner info height | awk '{print $2}')
        testVal04=$(expr $actual - $minerHeight04)   
        if [ $testVal04 -ge 1 ] 
        then
            echo "Miner04 Height:\033[1m $minerHeight04\033[0m    \033[41m$testVal04\033[m"
        else
            echo "Miner04 Height:\033[1m $minerHeight04\033[0m    \033[33m$testVal04\033[m"
        fi
        echo "MINER04, $datenow, $testVal04" >> log.out
    fi

    echo " "
    echo "Actual  Height:\033[1m $actual\033[0m" 
    echo " "
    echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
    echo " "
    #docker ps
    sleep 30
done

