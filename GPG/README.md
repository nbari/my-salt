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

    gpg --homedir /salt/gpgkeys --armor --export <KEY-NAME> > exported_pubkey.gpg

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

		hQEMA0TFuAYDisHXAQf/fFWEk0Hl8YYWjkRlPvbo2RmSJ47t5tWJeUAZAPhYyUyd
		Zgq37/j6X28UENPMBD/XR1SeqXM1N1j8Su9ETiduZ5fKOfzMj8Jjwx5+ZFqsrXVD
		Flkv3zNe6BhwdX2g3ahu9wKyRgeW8S9RO5FmZTVkPu/ECAuF9+I+gajwl2AkiGe7
		gHZZzvklt2HsAUey1q0xVWICwO4d3AaqOUQ/rz84QkG/9/p+9UaK51XK46/hjCzT
		Q44cJqBwGiaa6Yaok9Nnlvsi+y/MDyD67HKbKMy++WItz1X3yQ/KAP9k8qw+0tPW
		zzMAcypoGyX+72ba7gEDau06jadeUnFMYMj9Ext7z9JjAfrPKxUZCtmjmEnNlwGc
		4BfWnhmRBP3m7BWqgdAwHjkH3b3CaD/pDvwNxuLL8UvIrLEjA1JvdaCWLkP64avp
		6tOQDkUvbrJH5meQJ94FV/9JDwPJH4MVI3F24nv2Y5hOMB7u
		=RuWu
		-----END PGP MESSAGE-----
```

* Notice the ``#!yaml|gpg`` on top of the file


read more: https://docs.saltstack.com/en/latest/ref/renderers/all/salt.renderers.gpg.html
