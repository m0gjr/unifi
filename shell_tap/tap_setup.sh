#!/bin/ash

#host scp tsh ubnt@ap:/bin/tsh

chmod +x /bin/tsh

echo /bin/tsh >> /etc/shells
sed -i -e 's:/bin/ash:/bin/tsh:g' /etc/passwd

mkfifo /tmp/cmd-fifo

while true
do
	< /tmp/cmd-fifo nc 10.11 5000
done

#host nc -lkp 5000
#host nc -lkp 5001
