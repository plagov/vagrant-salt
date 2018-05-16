# SaltStack example with Vagrant

## Introduction and description

In this repository I made a SaltStack example that is deployd in a Vagrant environment.
SaltStack is used here as a configuration tool to install applications, set up config files and manage services.
The whole set up consists of four machines:

* `master` - a central machine that is managing all minions
* `web1` & `web2` - main machines that are running a web-application
* `loadbalancer` - a load-balancing machine with Nginx

## Usage and start-up

To start up this project just a few prerequisites shall be met.
Make sure to have both `VirtualBox` and `vagrant` of the latest stable versions installed.

Clone the repository and change directory:

```sh
git clone git@github.com:plagov/vagrant-salt.git
cd vagrant-salt
```

Start up the Vagrant environment by running:

```sh
vagrant up
```

Vagrant will download Ubuntu Trusty image and will provision it. Next, Vagrant will install Salt on all machines.
When installation and provisiong will be finished, you will be returned back to the terminal and no errors are expected.
Check if all machines were provisioned:

```sh
$ vagrant status

Current machine states:

master                    running (virtualbox)
web1                      running (virtualbox)
web2                      running (virtualbox)
loadbalancer              running (virtualbox)
```

If you get the same output, then SSH into a master machine by running the following Vagrant command:

```sh
vagrant ssh master
```

Now, being inside a master machine, you're ready to apply states to minions.
Run the following Salt command that will apply states specified in `top.sls` files to all minions:

```sh
sudo salt '*' state.apply
```

The command will take some time to finish. And as a result you will get a result of each state that was applied.
After all states were applied, open a web-browser and navigate to https://localhost:8030
Make sure to accept a warning that you might get, since the URL is accessible via an HTTPS with a self-signed SSL certificate.

As a result you will get a _Hello World_ greeting with version number and name of the host that is handling this response.
Press F5 key multiple times to refresh the page and observe how host name is changing, meaning that load-balancer
distributes the load accross both `web1` and `web2` machines.
