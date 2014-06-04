##Get packages

###i386
````
http://elders.princeton.edu/data/puias/unsupported/5/i386/pam_mount-1.2-1.PU_IAS.5.i386.rpm
http://elders.princeton.edu/data/puias/unsupported/5/i386/libHX-1.25-1.PU_IAS.5.i386.rpm
````

###x64
````
http://elders.princeton.edu/data/puias/unsupported/5/x86_64/libHX-1.25-1.PU_IAS.5.x86_64.rpm
http://elders.princeton.edu/data/puias/unsupported/5/x86_64/pam_mount-1.2-1.PU_IAS.5.x86_64.rpm
````

###Install perl-XML-Writer
````
yum -y install perl-XML-Writer
````

####edit /etc/security/pam_mount.conf.xml
````xml
<?xml version="1.0" encoding="utf-8" ?>
<!DOCTYPE pam_mount SYSTEM "pam_mount.conf.xml.dtd">
<!--
       	See pam_mount.conf(5) for a description.
-->

<pam_mount>


               	<!-- Volume definitions -->

<volume fstype="cifs" mountpoint="/home/%(USER)/netfile" path="" server="fs.nd.edu/~%(USER)" 
workgroup="adnd" uid="%(USER)" dir_mode="0700" file_mode="0700" sec="krb5" />

<!--

options=workgroup="adnd",uid=%(USER),dir_mode=0777,file_mode=777 /> -->


               	<!-- pam_mount parameters: General tunables -->

<debug enable="0" />
<!--
<luserconf name=".pam_mount.conf.xml" />
-->

<!-- Note that commenting out mntoptions will give you the defaults.
     You will need to explicitly initialize it with the empty string
     to reset the defaults to nothing. -->
<mntoptions allow="nosuid,nodev,loop,encryption,fsck,nonempty,allow_other" />
<!--
<mntoptions deny="suid,dev" />
<mntoptions allow="*" />
<mntoptions deny="*" />
-->
<mntoptions require="nosuid,nodev" />
<path>/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin</path>

<logout wait="0" hup="0" term="0" kill="0" />


               	<!-- pam_mount parameters: Volume-related -->

<mkmountpoint enable="1" remove="true" />

<msg-authpw>Password:</msg-authpw>

</pam_mount>

````
edit /etc/pam.d/system-auth
````
#%PAM-1.0
# This file is auto-generated.
# User changes will be destroyed the next time authconfig is run.
auth        required	  pam_env.so
auth        optional	  pam_mount.so
auth        sufficient    pam_unix.so use_first_pass
auth        requisite     pam_succeed_if.so uid >= 500 quiet
auth        sufficient    pam_krb5.so use_first_pass
auth        required	  pam_deny.so

account     required	  pam_unix.so broken_shadow
account     sufficient    pam_succeed_if.so uid < 500 quiet
account     required	  pam_krb5.so use_authtok try_first_pass
account     required	  pam_permit.so

password    requisite     pam_cracklib.so try_first_pass retry=3
password    sufficient    pam_unix.so md5 shadow nullok try_first_pass use_authtok
password    sufficient    pam_krb5.so use_authtok
#password    optional	   pam_mount.so
password    required	  pam_mount.so use_authtok shadow md5
password    required	  pam_deny.so

session     optional	  pam_keyinit.so revoke
session     optional	  pam_mount.so use_authtok shadow md5
session     required	  pam_limits.so
session     [success=1 default=ignore] pam_succeed_if.so service in crond quiet use_uid
session     required	  pam_unix.so
session     optional	  pam_krb5.so

````

