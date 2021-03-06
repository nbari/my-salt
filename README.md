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

    # sudo apt-get --yes -q install salt-master

Install The Salt-Minion package

    # sudo apt-get --yes -q install salt-minion


more details: http://bencane.com/2013/09/03/getting-started-with-saltstack-by-example-automatically-installing-nginx/


How do I list all connected Salt Stack minions?
-----------------------------------------------

    # salt-run manage.up

Also useful are:

    # salt-run manage.status

    # salt-run manage.down

Copy a file to a minion
-----------------------

    # salt-cp "minion-*" file.txt /path/to/file.txt

Accepting the Minions key on the Salt-Master
--------------------------------------------

We can see what keys are pending acceptance by running the salt-key command.

    # salt-key -L

Accept by name:

    # salt-key -a salt-minion-host

Accept all keys:

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

Set [grains](http://salt.readthedocs.org/en/latest/topics/targeting/grains.html#matching-grains-in-the-top-file) from the master at the command line

    # salt 'minion-ID' grains.setval roles development
    # salt 'minion-ID' grains.setval roles '[development, production]'
    # salt 'minion-ID' grains.setval node_type test

Ping minion's based on a role:

    # salt -C 'G@roles:development' test.ping

State Testing

    # salt -C 'G@node_type:test' state.highstate test=True

Keep minions awake
------------------

On the salt master set a cron with this:

    # 0 * * * * /usr/local/bin/salt --async '*' test.ping > /dev/null 2>&1

Salt Masterless
===============

To test your states

    salt-call --local --file-root=/salt/states state.highstate -l debug

Apply "recipie" on master:

    salt-call --local --file-root /salt/states --pillar-root /salt/pillars state.sls users -l debug

Mines
=====

Refresh pillar:

    salt '*' saltutil.refresh_pillar

Push both module and pillar data to all minions:

    salt '*' saltutil.sync_all

Confirm mine_functions are recognized by all minions:

    salt '*' config.get mine_functions

Minions update mine data at startup and every mine_interval minutes thereafter. Force 15 minions at a time to run mine.update:

    salt '*' -b 15 mine.update

Update mine:

    salt '*' mine.update

Get mines:

    salt '*' mine.get 'minion-3' test.ping

    salt "haproxy1*" mine.get 'node_type:riak' status.uptime grain

Get IP's:

    salt -C "G@node_type:HAProxy_VPC" mine.get 'node_type:my-nodes' network.ip_addrs grain

Debug
-----

salt (from master)

salt-call (from minion)

On the minion run:

    salt-call -l trace --local state.highstate

Check to see if you can catch more information about the error using "debug" mode:

    salt-call -l debug state.highstate

Clear the cache on the minion completely:

    rm -rf /var/cache/salt/minion/files/base/*


Update
------

Update all FreeBSD minions:

    salt -C 'G@os:FreeBSD' cmd.run 'pkg update && pkg upgrade -y && service salt_minion restart'


Kill salt-call
==============

Some times salt-call loops, to kill it:

     pgrep -f salt-call | xargs ps -o pcpu -p | awk 'NR>1 {printf("%.0f", $1)}'

using test:

    test `pgrep -f salt-call | xargs ps -o pcpu -p | awk 'NR>1 {printf("%.0f", $1)}'` -gt 90 && pkill -f salt-call


Get IP
=======

    salt -C "G@node_type:my_nodes*" network.ip_addrs


Startup states
==============

To initialize/boostrap a minion at boot time, on the minion conf add:

    startup_states: highstate

Order of execution
==================

To view the order in which Salt states are applied:

    salt minion-id state.show_sls example
