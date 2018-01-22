# rkhunter-mirror [![](https://images.microbadger.com/badges/image/jorgeandrada/rkhunter-localmirror.svg)](https://microbadger.com/images/jorgeandrada/rkhunter-localmirror "Get your own image badge on microbadger.com") [![](https://images.microbadger.com/badges/version/jorgeandrada/rkhunter-localmirror.svg)](https://microbadger.com/images/jorgeandrada/rkhunter-localmirror "Get your own version badge on microbadger.com")


```
docker run --name=rkhunter-mirror -p 8080:80 -d jorgeandrada/rkhunter-localmirror```

USING LOCAL MIRRORS
When the '--update' or '--versioncheck' options are used, rkhunter uses a mirror site from the mirrors.dat file to obtain the required information. By default rkhunter will use any mirror listed in the file, and it will then rotate the list of mirrors. At the time of writing the supplied mirrors.dat file lists the Rootkit Hunter SourceForge site as a mirror.

However, it is possible for users to define a local mirror if they wish to. This is done by simply editing the mirrors.dat file and inserting the mirror URL. The line should begin with the text 'local='. For example:

 local=http://www.example.com/rkhunter_data
The required rkhunter files must be placed in a location, of the users choice, which is accessible by the clients. So in the above example, the rkhunter data files would have been placed in the 'rkhunter_data' directory. The required files consist of the '.dat' files supplied with rkhunter, and which will have been installed in the database directory. For a default installation this would have been in '/var/lib/rkhunter/db'.

Additionally, the mirror directory must have an 'i18n' sub-directory which contains all the current language translation files for the various versions of rkhunter. Each version is put into its own sub-directory. So, for example, there would be a '1.3.1' sub-directory, a '1.3.2' sub-directory and so on, all within the 'i18n' directory. Again, the database directory will already have had the 'i18n' sub-directory installed in to it, but it will only contain the language files for the current version of rkhunter. There are no version sub-directories installed by default. As such, the mirror will need to have the various version sub-directories created, and the relevant language files put in to them, for the versions of rkhunter that the mirror is required to support. If a client tries to access the language files for a version of rkhunter that is not supported by the mirror, then the download will fail. Depending on how the client is configured, another, possibly remote, mirror may be tried, or rkhunter will give a warning.

Within each rkhunter version sub-directory of the 'i18n' directory, it is necessary to have a file called 'i18n.ver'. This file simply contains a list of the available language files, and their version numbers. For example:

      cn:2007061401
      en:2007102501
So, as an example, the mirror file structure will need to look similar to this:

                      rkhunter_data
                            ||
                            ||
     ===============================================
     ||               ||              ||          ||
 mirrors.dat  rkhunter_latest.dat    i18n    suspscan.dat
                                      ||
                                      ||
                  1.3.4 ============ 1.3.5 ============ 1.3.6
                  / | \              / | \              / | \
                 /  |  \            /  |  \            /  |  \
               cn  en  i18n.ver   cn  en  i18n.ver   cn  en  i18n.ver
Finally, if the '--versioncheck' option is to be supported with the local mirror, then the directory, 'rkhunter_data' in the above example, must contain a file called 'rkhunter_latest.dat'. This file must contain the current rkhunter version number (for example, '1.3.0') and no other text.

It is possible to similarly define 'remote' mirrors, which begin with the text 'remote='. At present though there is no real difference between a local or remote mirror.

The supplied mirror site(s) in the mirrors.dat file begin with the text 'mirror=', and this should not be changed.

In order to select whether all the mirrors or only the local or remote mirrors should be used, the rkhunter configuration file has an option in it called 'MIRRORS_MODE'. This option takes a numeric value, which by default is zero. The current values and meanings are:

    0 - use any mirror (the default)
    1 - use only local mirrors
    2 - use only remote mirrors
To further support local and remote mirrors there are two other configuration options available:

The first is 'UPDATE_MIRRORS', which simply tells rkhunter whether the mirrors.dat file itself should be updated (i.e. overwritten) when the '--update' option is used. If local mirrors are listed in the file then you probably do not want the file automatically updated. The 'UPDATE_MIRRORS' option has a default value of one, indicating that the mirrors.dat file should be updated. Set this option to zero to disable this feature.

The second option is 'ROTATE_MIRRORS'. This tells rkhunter whether it should rotate the list of mirrors whenever the '--update' or '--versioncheck' options are used. Again, with local mirrors you may want these accessed in a specific order, rather than rotated each time. The option has a default value of one indicating that the mirrors should be rotated. Set this option to zero to disable this feature.

By default if a mirror fails for some reason, then rkhunter will use the next mirror, of the configured type, listed in the file. If there are no more mirrors left, then rkhunter will give a warning message.

https://go-7s.com/site-news-and-blog/32-security/234-installing-or-upgrading-rootkit-hunter-rkh
