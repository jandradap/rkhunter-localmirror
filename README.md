# rkhunter-mirror [![](https://images.microbadger.com/badges/image/jorgeandrada/rkhunter-localmirror.svg)](https://microbadger.com/images/jorgeandrada/rkhunter-localmirror "Get your own image badge on microbadger.com") [![](https://images.microbadger.com/badges/version/jorgeandrada/rkhunter-localmirror.svg)](https://microbadger.com/images/jorgeandrada/rkhunter-localmirror "Get your own version badge on microbadger.com")


```
docker run --name=rkhunter-mirror -p 8080:80 \
-e "MIRRORS=http://mirror1.localdomain:8080,http://mirror2.localdomain:8080" \
-d jorgeandrada/rkhunter-localmirror
```

## USING LOCAL MIRRORS

Install rkhunter and edit **/var/lib/rkhunter/db/mirrors.dat:**
```
Version:2018010121
mirror=http://mirror1.localdomain:8080

```
Test with de commands: ```rkhunter --versioncheck``` and ```rkhunter --update```

### Example:
```sh
[root@jandradap ~]# cat /var/lib/rkhunter/db/mirrors.dat
Version:2018012253
local=http://mirror1.localdomain:8080

[root@jandradap ~]# rkhunter --versioncheck
[ Rootkit Hunter version 1.4.4 ]

Checking rkhunter version...
  This version  : 1.4.4
  Latest version: 1.4.4
[root@sap07centos6 ~]# rkhunter --update
[ Rootkit Hunter version 1.4.4 ]

Checking rkhunter data files...
  Checking file mirrors.dat                                  [ Updated ]
  Checking file programs_bad.dat                             [ No update ]
  Checking file backdoorports.dat                            [ No update ]
  Checking file suspscan.dat                                 [ No update ]
  Checking file i18n/cn                                      [ No update ]
  Checking file i18n/de                                      [ No update ]
  Checking file i18n/en                                      [ No update ]
  Checking file i18n/ja                                      [ No update ]
  Checking file i18n/tr                                      [ No update ]
  Checking file i18n/tr.utf8                                 [ No update ]
  Checking file i18n/zh                                      [ No update ]
  Checking file i18n/zh.utf8                                 [ No update ]

[root@jandradap ~]# cat /var/lib/rkhunter/db/mirrors.dat
Version:2018012232
local=http://mirror1.localdomain:8080
local=http://mirror2.localdomain:8080
```

**More info:** https://go-7s.com/site-news-and-blog/32-security/234-installing-or-upgrading-rootkit-hunter-rkh
