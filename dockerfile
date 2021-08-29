FROM centos:centos7

RUN mkdir /root/sw

WORKDIR /root/sw

COPY jdk-8u301-linux-x64.rpm .

RUN rpm -ivh jdk-8u301-linux-x64.rpm

RUN groupadd -g 1001 oinstall

RUN useradd -u 1001 -g oinstall oracle

RUN mkdir -p /u01/app/oraInventory

RUN mkdir -p /u01/app/oracle/product/12.2.1

RUN mkdir -p /u01/app/oracle/config/{domains,applications}

RUN mkdir -p $DOMAIN_HOME/servers/AdminServer/security/

RUN echo "username=weblogic" > $DOMAIN_HOME/servers/AdminServer/security/boot.properties

RUN echo "password=weblogic123" >> $DOMAIN_HOME/servers/AdminServer/security/boot.properties

RUN chown -R oracle:oinstall /u01/app

RUN chmod -R 775 /u01

USER oracle

ENV ORACLE_BASE=/u01/app/oracle

ENV ORACLE_HOME=$ORACLE_BASE/product/12.2.1

ENV MW_HOME=$ORACLE_HOME

ENV WLS_HOME=$MW_HOME/wlserver

ENV DOMAIN_BASE=$ORACLE_BASE/config/domains

ENV DOMAIN_HOME=$DOMAIN_BASE/docker

WORKDIR /home/oracle

RUN mkdir sw

WORKDIR /home/oracle/sw

COPY fmw_12.2.1.3.0_wls.jar .

WORKDIR /u01/app/oracle

COPY oraInst.loc .

COPY wls.rsp .

WORKDIR /home/oracle/sw

RUN java -jar fmw_12.2.1.3.0_wls.jar -silent -responseFile /u01/app/oracle/wls.rsp -invPtrLoc /u01/app/oracle/oraInst.loc

WORKDIR /u01/app/oracle/product/12.2.1/oracle_common/common/bin

COPY createDomain.py .

RUN ./wlst.sh createDomain.py

WORKDIR /u01/app/oracle/config/domains/docker

EXPOSE 7001

CMD ./startWebLogic.sh
