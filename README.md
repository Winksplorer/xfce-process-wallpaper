# xfce-process-wallpaper

Python and shell scripts which set your XFCE wallpaper to a wordcloud of the most resource-intensive processes presently running.

![](./screenshot.png)

## Depenendencies
* `python3`
* Xfce (with xfconf-query)

This fork is only for Xfce.

## Setup

* Clone this repo.

```
git clone https://github.com/Winksplorer/xfce-process-wallpaper
cd xfce-process-wallpaper
```
* Set the resolution of your display in `config.json`
* Install Python dependencies.
```
pip3 install -r requirements.txt --user
```
* Run `setup.sh`
```
./setup.sh
```

## Use
The wallpaper is updated every time `updateWallpaper.sh` is run. To trigger the update every minute, append the following line to `crontab -e`, remember to replace `/path/to/script/directory` with the directory of your scripts.
### Xfce
```
* * * * * cd /path/to/script/directory && ./updateWallpaper.sh > /tmp/wallpaper.log 2>&1

```
