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

Disable User List on RHEL6 / CentOS6 Login Window
```
# gconftool-2 --direct --config-source=xml:readwrite:/etc/gconf/gconf.xml.defaults --type bool --set /apps/gdm/simple-greeter/disable_user_list true
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

Edit pam files to allow kerberos login
system-auth
```
#%PAM-1.0
# This file is auto-generated.
# User changes will be destroyed the next time authconfig is run.
auth        required      pam_env.so
auth        sufficient    pam_fprintd.so
auth        sufficient    pam_unix.so nullok try_first_pass
auth        requisite     pam_succeed_if.so uid >= 500 quiet
auth        sufficient    pam_sss.so use_first_pass
auth        sufficient    pam_krb5.so use_first_pass
auth        required      pam_deny.so

account     required      pam_unix.so broken_shadow
account     sufficient    pam_localuser.so
account     sufficient    pam_succeed_if.so uid < 500 quiet
account     [default=bad success=ok user_unknown=ignore] pam_sss.so
account     [default=bad success=ok user_unknown=ignore] pam_krb5.so
account     required      pam_permit.so

password    requisite     pam_cracklib.so try_first_pass retry=3 type=
password    sufficient    pam_unix.so sha512 shadow nullok try_first_pass use_authtok
password    sufficient    pam_sss.so use_authtok
password    sufficient    pam_krb5.so use_authtok
password    required      pam_deny.so

session     optional      pam_keyinit.so revoke
session     required      pam_limits.so
session     [success=1 default=ignore] pam_succeed_if.so service in crond quiet use_uid
session     required      pam_unix.so
session     optional      pam_sss.so
session     optional      pam_krb5.so
```

gdm
```
#%PAM-1.0
auth     [success=done ignore=ignore default=bad] pam_selinux_permit.so
auth       required    pam_succeed_if.so user != root quiet
auth       required    pam_env.so
auth       substack    system-auth
auth	   sufficient  pam_krb5.so
auth       optional    pam_gnome_keyring.so
account    required    pam_nologin.so
account    include     system-auth
password   include     system-auth
session    required    pam_selinux.so close
session    required    pam_loginuid.so
session    optional    pam_console.so
session    required    pam_selinux.so open
session    optional    pam_keyinit.so force revoke
session    required    pam_namespace.so
session    optional    pam_gnome_keyring.so auto_start
session    include     system-auth
```

Then update authconfig
```
If you set up kerberos through authconfig it will do this for you.

Alternatively, since you've already set things up manually in system-auth, running

authconfig --updateall
```
