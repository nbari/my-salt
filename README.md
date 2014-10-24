salt
====

SaltStack or Salt as it is commonly referred to, is an extremely flexible and easy to learn automation tool.

Setting up the Salt-Master
--------------------------

Salt servers have two types, Master and Minion. The master server is the server that hosts all of the policies and configurations and pushes those to the various minions. The minions, are the infrastructure that you want managed.

Installing on FreeBSD
---------------------

    # pkg install py27-salt

http://docs.saltstack.com/en/latest/topics/installation/freebsd.html


Installing on Ubuntu (Linux)
----------------------------

Saltstack maintains a PPA (Personal Package Archive) that can be added as an apt repository.

    # sudo apt-get --yes -q install python-software-properties

Adding the SaltStack PPA Repository

    # sudo add-apt-repository ppa:saltstack/salt
    You are about to add the following PPA to your system:
    Salt, the remote execution and configuration management tool.
    More info: https://launchpad.net/~saltstack/+archive/salt
    Press [ENTER] to continue or ctrl-c to cancel adding it

Make sure that you press **[ENTER]** otherwise the repository will not be added.

Update Apt's Package Indexes

    # sudo apt-get --yes -q update

Install the Salt-Master package

    # apt-get --yes -q install salt-master

Install The Salt-Minion package

    # apt-get --yes -q install salt-minion


more details: http://bencane.com/2013/09/03/getting-started-with-saltstack-by-example-automatically-installing-nginx/


How do I list all connected Salt Stack minions?
-----------------------------------------------

    # salt-run manage.up

Also useful are:

    # salt-run manage.status

    # salt-run manage.down


Accepting the Minions key on the Salt-Master
--------------------------------------------

We can see what keys are pending acceptance by running the salt-key command.

    # salt-key -L

Accept by name:

    # salt-key -a salt-minion-host

Accept all kezs:

    # salt-key -A

Ping all minions
----------------

    # salt '*' test.ping

Install a custom state
----------------------

    # salt 'minion-1' state.sls tmux

on all minions:

    # salt '*' state.sls tmux

Pillars
-------

To ensure that the minions have the new pillar data, issue a command to them asking that they fetch their pillars from the master:

    # salt '*' saltutil.refresh_pillar

Get pillar items:

    # salt '*' pillar.items

Set roles from the master at the command line

    # salt 'minion-ID' grains.setval roles '[development]'
    # salt 'minion-ID' grains.setval roles '[development, production]'

Ping minion's based on a role:

    # salt -C 'G@roles:development' test.ping
