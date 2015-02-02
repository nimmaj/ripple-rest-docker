# ripple-rest-docker

This set of files:

* builds an image, based on the docker ubuntu image
* downloads the latest ripple-rest fromt git hub
* adds a couple of files for config and to start it
* generates some ssl certs

The only real bit of oddness is that we need to set the host to start.  Otherwise
it will use localhost, which is a disaster to connect to.  So the startRippleRest.sh
file works out the ip address and sets it.

# to use...

First build the image:

```
docker build -t nimmaj/ripple-rest:v1 .
```

...you can change the name of the image to anything you fancy.

To run:

```
docker run -d -P nimmaj/ripple-rest:v1
```

The -P flag maps the ports automagically.  You could do this manually using -p.

To find out what port you are mapped to:

```
docker ps
```

You should see something like this in the ports column:

```
0.0.0.0:49155->5990/tcp
```

If you're on a mac you also need to work out what ip address the boot2docker image
in virtual box is using:

```
boot2docker ip
```

If that returns 8.8.8.8 then you can connect to ripple-rest:

```
curl -k https://8.8.8.8:49155
```

# todo

Can we include an editable file to mean you can generate a more sensible certificate?

# useful links

* http://stackoverflow.com/questions/20932357/docker-enter-running-container-with-new-tty
* http://stackoverflow.com/questions/21336126/linux-bash-script-to-extract-ip-address
* http://viget.com/extend/how-to-use-docker-on-os-x-the-missing-guide
