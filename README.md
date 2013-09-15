my-salt
=======

**dalmp.sls**

- For installing DALMP (https://github.com/nbari/DALMP) on /usr/local/share/dalmp
- Does a git clone or a pull.


**my-vim.sls**

- For installing vim configurations (https://github.com/nbari/my-vim) on /usr/local/share/my-vim

- Does a git clone or a pull, and later updates all git submodules.

**mysql**

- For creating a mysql sandbox and test some cluster configurations



On master run:

    salt '*' state.highstate


More help on how to use this files can be found in: http://docs.saltstack.com/topics/tutorials/walkthrough.html
