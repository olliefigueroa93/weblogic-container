readTemplate('/u01/app/oracle/product/12.2.1/wlserver/common/templates/wls/wls.jar')
cd('Servers/AdminServer')
cmo.setListenAddress('')
setOption('ServerStartMode','dev')
set('ListenPort',7001)
create('AdminServer','SSL')
cd('SSL/AdminServer')
set('Enabled','False')
set('ListenPort',7002)
cd('/')
cd('Security/base_domain/User/weblogic')
cmo.setPassword('weblogic123')
setOption('ServerStartMode','dev')
setOption('OverwriteDomain','true')
writeDomain('/u01/app/oracle/config/domains/docker')
closeTemplate()
exit()