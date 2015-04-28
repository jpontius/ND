modified from https://wiki.ncsa.illinois.edu/display/ITS/OpenAFS+Install+via+RPM+for+RHEL+6

Download the DKMS RPM and Dependencies


INSTALL LATEST dkms RPM DIRECTLY FROM DELL AT http://linux.dell.com/dkms/
THERE ARE SOME ONLINE REPORTS OF OLDER VERSIONS OF dkms BEING BUGGY
```
yum install http://linux.dell.com/dkms/permalink/dkms-2.2.0.3-1.noarch.rpm
``` 
OR INSTALL RPMforge REPO AND INSTALL A SLIGHTLY OLDER dkms FROM RPMforge
```
rpm --import http://apt.sw.be/RPM-GPG-KEY.dag.txt
yum install http://packages.sw.be/rpmforge-release/rpmforge-release-0.5.2-2.el6.rf.x86_64.rpm
yum install dkms
```

INSTALL DEPENDENCIES NEEDED BY OpenAFS RPMS
```
yum install cloog-ppl cpp gcc glibc-devel glibc-headers kernel-devel kernel-headers mpfr pp kernel-devel kernel-headers
```
Setup Custom OpenAFS Yum Repository

/etc/yum.repos.d/OpenAFS.repo
```
[openafs]
name = OpenAFS 1.6.7 for RHEL $releasever - $basearch
baseurl = http://www.openafs.org/dl/openafs/1.6.7/rhel$releasever/$basearch
enabled = 1
protect = 0
gpgcheck = 0
```
NOTE: When new versions of OpenAFS are released, you will need to manually update the OpenAFS version number in the name and baseurl lines above.

Install OpenAFS RPMs
```
yum install dkms-openafs openafs openafs-client openafs-docs openafs-krb5
```
Configure OpenAFS for NCSA's Environment
```
echo "nd.edu" > /usr/vice/etc/ThisCell
```
Start OpenAFS
MAKE SURE openafs-client IS SET TO START AT RUN LEVELS 2,3,4,5
```
chkconfig --list openafs-client
# IF NOT, SET IT UP
# chkconfig --add openafs-client
# chkconfig openafs-client on
 
# START openafs-client
service openafs-client start
```
test OpenAFS
TEST THAT OpenAFS IS MOUNTED AND ACCESSIBLE
```
cd /afs/nd.edu
ls
```
TEST AUTHORIZED ACCESS
```
kinit; klist
aklog; tokens
```
 
ACCESS AFS HOME DIRECTORY
```
cd /afs/nd.edu/user/$USER/
pwd
ls
```

krb5.conf
```
[logging]
    default = FILE:/var/log/krb5.log


[libdefaults]
	default_realm = ND.EDU
	default_tkt_enctypes = des3-hmac-sha1 des-cbc-crc
	default_tgs_enctypes = des3-hmac-sha1 des-cbc-crc 

	dns_lookup_realm = true
	dns_lookup_kdc = true
	allow_weak_crypto = true

[realms]
   ND.EDU = {
     kdc = KERBEROS.ND.EDU:88
     kdc = KERBEROS-1.ND.EDU:88
     kdc = KERBEROS-2.ND.EDU:88
     admin_server = KERBEROS.ND.EDU:749
     default_domain = ND.EDU
   }

[domain_realm]
    .nd.edu = ND.EDU
    nd.edu = ND.EDU

[appdefaults]
    pam = {
        ticket_lifetime = 30d
        renew_lifetime = 30d
        forwardable = true
        debug = true
   }
```
