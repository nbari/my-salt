# SALT.RENDERERS.GPG

This allows you to safely store secrets in source control, in such a way that
only your Salt master can decrypt them and distribute them only to the minions
that need them.

Install gnupg:

    pkg install gnupg

Create keypair (on master or replicate later your keys):

    mkdir /salt/gpgkeys
    chmod 0700 /salt/gpgkeys
    gpg --gen-key --homedir /salt/gpgkeys

Do not supply a password for your keypair, and use a name that makes sense for
your application. Be sure to back up your gpg directory someplace safe!

To retrieve public key:

    gpg --homedir /etc/salt/gpgkeys --armor --export <KEY-NAME> > exported_pubkey.gpg

Import public key on your local machine so that you can encrypt:

    gpg --import exported_pubkey.gpg

Example, having a pillar with:

```yaml
aws:
    keyid: ABC
    key: secret
```

To encrypt value of ``key`` do something like:

    echo -n "secret" | gpg --armor --encrypt -r <KEY-name>

The pillar now will be:

```yaml
#!yaml|gpg
aws:
    keyid: ABC
    key: |
	  -----BEGIN PGP MESSAGE-----
	  Version: GnuPG v1

	  hQEMAweRHKaPCfNeAQf9GLTN16hCfXAbPwU6BbBK0unOc7i9/etGuVc5CyU9Q6um
	  QuetdvQVLFO/HkrC4lgeNQdM6D9E8PKonMlgJPyUvC8ggxhj0/IPFEKmrsnv2k6+
	  cnEfmVexS7o/U1VOVjoyUeliMCJlAz/30RXaME49Cpi6No2+vKD8a4q4nZN1UZcG
	  RhkhC0S22zNxOXQ38TBkmtJcqxnqT6YWKTUsjVubW3bVC+u2HGqJHu79wmwuN8tz
	  m4wBkfCAd8Eyo2jEnWQcM4TcXiF01XPL4z4g1/9AAxh+Q4d8RIRP4fbw7ct4nCJv
	  Gr9v2DTF7HNigIMl4ivMIn9fp+EZurJNiQskLgNbktJGAeEKYkqX5iCuB1b693hJ
	  FKlwHiJt5yA8X2dDtfk8/Ph1Jx2TwGS+lGjlZaNqp3R1xuAZzXzZMLyZDe5+i3RJ
	  skqmFTbOiA==
	  =Eqsm
	  -----END PGP MESSAGE-----
```

* Notice the ``#!yaml|gpg`` on top of the file


read more: https://docs.saltstack.com/en/latest/ref/renderers/all/salt.renderers.gpg.html
