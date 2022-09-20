Contributing
------------

Install the development environment:

```sh
$ pip install virtualenv  # might require sudo/admin privileges
$ git clone https://github.com/clld/valpal.git  # you may also clone a suitable fork
$ cd valpal
$ python -m virtualenv .venv
$ source .venv/bin/activate  # Windows: .venv\Scripts\activate.bat
$ pip install -r requirements.txt  # installs the cloned version with dev-tools in development mode
```

Then create a database:

```sh
$ su - postgres
$ createdb valpal
```

and initialize it, either
 * loading a dump of the production DB, using the app's `load_db` task from the
   `appconfig` package
 * or by running the following command:

    $ clld initdb --glottolog PATH-TO-GLOTTOLOG-REPO --glottolog-version GLOTTOLOG-VERSION --cldf PATH-TO-CLDF-METADATA-FILE development.ini

For `initdb` to work you need a copy of the [Glottolog data][glottolog] on your
machine.  You can clone it using git like so:

    $ git clone https://github.com/glottolog/glottolog PATH-TO-GLOTTOLOG-REPO

[glottolog]: https://github.com/glottolog/glottolog

Note for Windows users:  The Glottolog repo contains a lot of files and folders,
so you might have to enable support for long paths in git:

    $ git config --system core.longpaths true

To find out what the latest release of Glottolog is, update the Glottolog repo
to the latest version and use `git tag` to show a list of versions:

    $ git -C PATH-TO-GLOTTOLOG-REPO pull
    $ git -C PATH-TO-GLOTTOLOG-REPO tag
    v0.2
    v3.0
    ...
    v4.6

Use the version tag you want (including the `v`) in place of GLOTTOLOG-VERSION
in the command above.

Now you should be able to run the tests:

```sh
$ pytest
```
