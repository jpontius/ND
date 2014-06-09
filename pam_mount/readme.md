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

###Install packages x86_64
````
yum -y install perl-XML-Writer
yum -y install x64-packages/libHX-1.25-1.PU_IAS.5.x86_64.rpm
yum -y install x64-packages/pam_mount-1.2-1.PU_IAS.5.x86_64.rpm
````

###Install packages i386
````
yum -y install perl-XML-Writer
yum -y install 386-packages/libHX-1.25-1.PU_IAS.5.i386.rpm
yum -y install 386-packages/pam_mount-1.2-1.PU_IAS.5.i386.rpm
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
edit /etc/pam.d/gdm
````
#%PAM-1.0
auth       required    pam_env.so
auth       optional    pam_mount.so try_first_pass
auth       include     system-auth
account    required    pam_nologin.so
account    include     system-auth
password   include     system-auth
session    optional    pam_keyinit.so force revoke
session    include     system-auth
session    required    pam_loginuid.so
session    optional    pam_console.so
session    optional    pam_mount.so try_first_pass

````

