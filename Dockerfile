FROM centos:7.2.1511

MAINTAINER Robert de Bock <robert@meinit.nl>

LABEL Description="Base CentOS OpenSSH server image" Version="7.2.1511"

RUN yum -y install openssh openssh-server openssh-clients epel-release && \
    yum -y clean all

CMD test -f /etc/ssh/ssh_host_ecdsa_key || /usr/bin/ssh-keygen -q -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key -C '' -N ''&&  \
    test -f /etc/ssh/ssh_host_rsa_key || /usr/bin/ssh-keygen -q -t rsa -f /etc/ssh/ssh_host_rsa_key -C '' -N ''&&  \
    test -f /etc/ssh/ssh_host_ed25519_key || /usr/bin/ssh-keygen -q -t ed25519 -f /etc/ssh/ssh_host_ed25519_key -C '' -N ''&&  \
    test -f /root/.ssh/id_rsa || /usr/bin/ssh-keygen -t rsa -f /root/.ssh/id_rsa -N '' && \
    test -f /root/.ssh/id_rsa.pub || ssh-keygen -y -t rsa -f ~/.ssh/id_rsa > ~/.ssh/id_rsa.pub && \
    test -f /root/.ssh/authorized_keys || /usr/bin/cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys && \
    /usr/bin/cat /root/.ssh/id_rsa && \
    /usr/bin/echo "" && \
    /usr/bin/echo "Please save the printed private RSA key and login using:" && \
    /usr/bin/echo "\"ssh -i \${savedkey} root@\${ipaddress}\"" && \
    /usr/sbin/sshd -D

EXPOSE 22
