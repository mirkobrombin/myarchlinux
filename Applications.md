# Applications
Explanation of special cases and complete list of installed software.

## Firefox
I'm using the Firefox package from OpenSUSE beacuse of the correct integration with Global menu:
```
yay -S firefox-kde-opensuse-bin
```

## Trojita (Mail)
Keeping the whole akonadi + mariadb system for KMail does not make sense, I use Trojità instead:
```
pacman -S trojita
```
So I remove akonadi and all the KDE Organization package:
```
pacman -Rc akonadi mariadb mariadb-clients mariadb-libs kaddressbook kalarm kmail kmail-account-wizard knotes kontact kopete korganizer
```
Since the default icon is a little ugly, I've created a new one in `/data/icons/trojita`.

## Complete list
Ref. to: [data/applications--all.txt](https://github.com/mirkobrombin/myarchlinux/blob/master/data/applications--all.txt)