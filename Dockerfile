FROM    alpine:3.15

RUN     apk --no-cache add --update bash sudo nano sudo zip bzip2 fontconfig wget curl 'su-exec>=0.2' busybox mc nano rsync lftp mysql-client bash sudo grep gawk ncurses-terminfo curl sed dropbear openssh-sftp-server pwgen
RUN	deluser xfs && delgroup www-data &&  addgroup -g 33 -S www-data
RUN	adduser -u 33 -D -S -s /bin/sh -h /var/www -G www-data www-data 
RUN	export NEWROOTPW=$(pwgen 12 1) && echo "www-data:${NEWROOTPW}" | chpasswd && echo "New www-data password is: ${NEWROOTPW}"
RUN	mkdir /etc/dropbear && mkdir -p /var/www && chown www-data:www-data /var/www 
ENTRYPOINT ["/usr/sbin/dropbear", "-R", "-F", "-E" , "-w"]
