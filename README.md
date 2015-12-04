# ripple-rest-docker

This set of files:

* builds an image, based on the docker ubuntu image
* downloads the latest ripple-rest fromt git hub
* adds a couple of files for config and to start it
* generates some ssl certs

The only real bit of oddness is that we need to set the host to start.  Otherwise
it will use localhost, which is a disaster to connect to.  So the startRippleRest.sh
file works out the ip address and sets it.

# docker-machine

You could start by creating a docker machine called dev...

```
docker-machine create --driver virtualbox dev
```

and then setting all the env vars:

```
eval "$(docker-machine env dev)"
```

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

If you're on a mac you also need to work out what ip address the docker-machine is using (presuming your docker-machine is called dev):

```
docker-machine ip dev
```

If that returns 8.8.8.8 then you can connect to ripple-rest:

```
curl -k https://8.8.8.8:49155
```
# debugging

I just found that the script didn't work with the new version of docker.  Needed to find out why the build didn't work.  What worked for me was to hash out the line that was hosed and the ones beyond, then to run the image, now built, with an interative shell to prove a theory.

```
docker run -i -t nimmaj/ripple-rest:v1 /bin/bash
```

# todo

Can we include an editable file to mean you can generate a more sensible certificate?

# useful links

* http://stackoverflow.com/questions/20932357/docker-enter-running-container-with-new-tty
* http://stackoverflow.com/questions/21336126/linux-bash-script-to-extract-ip-address
* http://viget.com/extend/how-to-use-docker-on-os-x-the-missing-guide
