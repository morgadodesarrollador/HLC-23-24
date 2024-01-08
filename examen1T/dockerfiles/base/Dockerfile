FROM ubuntu

USER root
RUN apt update && apt install -yq --no-install-recommends \
    apt-utils \
    curl \ 
    git \
    nano \ 
    net-tools \ 
    iputils-ping \
    dos2unix \
    openssh-server \ 
    openssh-client

ARG CONTEXT
ARG TZ
#ENV TZ=${TZ}
#ENV CONTEXT=${CONTEXT}

RUN echo ${CONTEXT}
RUN echo ${TZ}

ARG BASE=${CONTEXT}/dockerfiles/base
ARG D_ID_RSA=${CONTEXT}/keys

RUN echo ${BASE}
RUN echo ${D_ID_RSA}

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN mkdir /root/logs

COPY ./dockerfiles/base/start.sh /root
COPY ./keys/id_rsa.pub /root
RUN chmod +x /root/start.sh
RUN dos2unix /root/start.sh 

EXPOSE 22

ENTRYPOINT [ "/root/start.sh" ]
#CMD ["tail", "-f", "/dev/null"]
