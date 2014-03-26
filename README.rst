nginx
======
Installs and (optionally) configures ``nginx``.

.. note::

    See the full `Salt Formulas installation and usage instructions
    <http://docs.saltstack.com/topics/conventions/formulas.html>`_.

Available states
================

.. contents::
    :local:

``nginx.package.distro``
------------------------
This state installs the prebuilt package for nginx provided by the Linux distro's repositories.

``nginx.package.official``
--------------------------
This state installs the nginx package provided by `nginx.org <http://wiki.nginx.org/Install>`_, which is more up-to-date than the packages provided by the distros.

Note that not all distributions have packages from nginx.org. For example, nginx.org does not provide packages for Fedora, so this state should not be used for such distributions.

``nginx.config``
----------------
This state populates the central ``nginx.conf`` configuration file based on the ``nginx_config`` pillar. The default nginx configuration file includes things in ``conf.d`` and sometimes ``sites-enabled``, but you can just put everything inside the ``nginx_config`` pillar for simplicity.


Configuration
=============
The ``pillar.example`` is based on the default nginx configuration on Debian Squeeze. Note that instead of having ``nginx.conf`` include ``sites-enabled/*``, I just included the configuration into ``nginx.conf`` itself for simplicity. If you want the modularity given by sites-enabled and conf.d, you can maintain those separately from this formula, and just add lines in nginx_config to include those directories.

.. note::

    ``nginx.conf`` uses "on" and "off", so be sure to put quotes around those values inside pillar, or else they will be interpreted as True and False booleans by PyYAML (see: `YAML idiosyncrasies`_).

.. _YAML idiosyncrasies: http://docs.saltstack.com/topics/troubleshooting/yaml_idiosyncrasies.html#true-false-yes-no-on-off

