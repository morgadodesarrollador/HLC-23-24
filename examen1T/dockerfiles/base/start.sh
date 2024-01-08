#!/bin/bash
set -e

DLOG=/root/logs/logs.txt
echo ${DOMINIO} > ${DLOG}
echo ${HOSTNAME} >> ${DLOG}

echo ${USUARIO} >> ${DLOG}
echo ${PASSWD} >> ${DLOG}
echo ${CONTEXT} >> ${DLOG}

newUser(){
    # ---------------- creación de usuario 
    echo "MAQ2-->usuarioBD-->${USUARIO}" > /root/datos.txt
    if [ ! -d "/home/${USUARIO}" ]
    then
        useradd -rm -d /home/"${USUARIO}" -s /bin/bash "${USUARIO}" 
        echo "root:${PASSWD}" | chpasswd
        echo "${USUARIO}:${PASSWD}" | chpasswd
    fi
    echo "Usuario creado" >> ${DLOG}

}

config_ssh(){
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
    sed -i 's/#Port 22/Port 22/' /etc/ssh/sshd_config
    if [ ! -d /home/${USUARIO}/.ssh ]
    then
        mkdir /home/${USUARIO}/.ssh
        cat /root/id_rsa.pub >> /home/${USUARIO}/.ssh/authorized_keys
    fi
    /etc/init.d/ssh start &
    echo "ssh arrancado" >> ${DLOG}
}


main(){
    if [ ! -d "/home/${USUARIO}" ]
    then
        newUser
        config_ssh
    fi
    echo "main ejecutada" >> ${DLOG}
    echo "tail ejecutado" >> ${DLOG}
    tail -f /dev/null
}
main

