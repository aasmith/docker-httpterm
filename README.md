# docker-httpterm
A docker image for Willy Tarreu's http terminator. See http://git.1wt.eu/web?p=httpterm.git;a=summary

## Notes

By default, an instance is started on port 8000. If are you pushing serious traffic, you probably want `--net=host` 
and should disable conntrack in iptables.

## Usage

A list of parameters can be fetched from `localhost:8000/?`:

```
The following arguments are supported to override the default objects:
/?s=<size>[kmg] : return <size> bytes (may be kB, MB, GB). Eg: /?s=20k
/?r=<retcode> : present <retcode> as the HTTP return code. Eg: /?r=404
/?c=<cache> : set the return as not cacheable if zero. Eg: /?c=0
/?t=<time> : wait <time> milliseconds before responding. Eg: /?t=500
/?k={0|1} : Enable transfer encoding chunked with 1 byte chunks
/?S={0|1} : Disable/enable use of splice() to send data
/?R={0|1} : Disable/enable sending random data (disables splicing)
Note that those arguments may be cumulated on one line separated by the '&' sign :
GET /?s=20k&c=1&t=700 HTTP/1.0
GET /?r=500&s=0&c=0&t=1000 HTTP/1.0
```
