# docker-httpterm
A docker image for Willy Tarreu's http terminator. See http://git.1wt.eu/web?p=httpterm.git;a=summary

## Notes

By default, an instance is started on port 8000. If are you pushing serious traffic, you probably want `--net=host` 
and should disable conntrack in iptables.

### File descriptor limits

As httpterm is used in load testing scenarios, you may want to support a high number of connections. Recent versions
of docker use a far more restrictive `ulimit -n`, so you will probably see the following warning:

```
[WARNING] 061/144051 (7) : [httpterm.main()] Cannot raise FD limit to 300011.
[WARNING] 061/144051 (7) : [httpterm.main()] FD limit (1024) too low for maxconn=300000/maxsock=300011. Please raise 'ulimit-n' to 300011 or more to avoid any trouble.
```

Try running the container with `--ulimit nofile=1000000` or some other high number to alleviate this.

### CPU pinning

If you are [pinning interrupts][0], make sure httpterm runs on a dedicated CPU core. `--cpuset-cpus 0` or whichever CPU is
free from these interrupts (si in top).

[0]: https://www.haproxy.com/doc/hapee/1.5/system/tunning.html

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
