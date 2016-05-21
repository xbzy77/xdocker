# cat Dockerfile
 
# sshd
#
# VERSION               0.0.1
 
FROM        centos:6.7
MAINTAINER  DIDI-ops "xbzy-test"
 
RUN         yum install -y iputils dstat telnet net-tools
RUN         yum install -y openssh openssh-server httpd
RUN         sed -i 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config 
RUN         echo 'root:didi@16888' |chpasswd
RUN         ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key
RUN         ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key
RUN         mkdir -pm 700  /root/.ssh 
#RUN        echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDl953s7S/ErWPXjuFcl5VcDX9zo/DlbRfQhygVRBGYyMQZkKI89jW3hJIAucIuIqv60bAabQxdG6mi+7pCpAAcqsF4Sfb5+/c5CvQoCBKg+9WnngSY853tEIwSaTyMtSb3ZguTaC0y2qTfCoAe21O9/J3lQHGDX879HBsQ1Ziob7zblgrnIaDdyaFYzy9+8cylznJR35u8plRf4SYD6C62i4Qk7PIcDj6WkKndtolmYv5XtETwO9gsZwwRrwkc1wsvJtmXbA0K210H4iuyz92xIbPwXIjPgeWChtXpwJiCCqQhCA/TyEoHWAnoUDFYCDECCc76WrQg5A0DrSYosWoF root@localhost.localdomain" >>~/.ssh/authorized_keys
ADD         authorized_keys /root/.ssh/authorized_keys
RUN         chmod 600 /root/.ssh/authorized_keys
EXPOSE      22
EXPOSE      80
CMD         /usr/sbin/sshd -D