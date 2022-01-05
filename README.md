# bareos exporter

This will install the [Bareos Prometheus Exporter](https://github.com/vierbergenlars/bareos_exporter).

Inspired by [Puppet Postgresql Exporter](https://github.com/gbloquel/puppet-postgres_exporter)

## Table of Contents

- [bareos exporter](#bareos-exporter)
  - [Table of Contents](#table-of-contents)
  - [Description](#description)
  - [Setup](#setup)
    - [Setup Requirements](#setup-requirements)
    - [Beginning with exporter](#beginning-with-exporter)
  - [Usage](#usage)
  - [Reference](#reference)
  - [Limitations](#limitations)

## Description

Briefly tell users why they might want to use your module. Explain what your
module does and what kind of problems users can solve with it.

This should be a fairly short description helps the user decide if your module
is what they want.

## Setup

### Setup Requirements

The module depends on the following puppet modules:

* [Puppetlabs/stdlib](https://forge.puppet.com/puppetlabs/stdlib)
* [Puppet/archive](https://forge.puppet.com/modules/puppet/archive) - For downloading and extracting the bareos exporter release tarball
* [Puppet/systemd](https://forge.puppet.com/modules/puppet/systemd) - For creating the systemd config

### Beginning with exporter

The most basic example is:

```puppet
include bareos_exporter
```

The module will assume that it will run as user postgres (which needs to already exist) and will connect to the database bareos on local host.
You can tweak the database connection settings with the `dsn` and `dbtype` param as well as you can specify the user the daemon shoould run and
if the user/group should get create.

## Usage

A more complete example:

```puppet
class { '::bareos_exporter':
  manage_user           => true,
  manage_group          => true,
  bareos_exporter_user  => 'bareos',
  bareos_exporter_group => 'bareos',
  dsn                   => 'user=bareos host=/var/run/postgresql/ sslmode=disable',
  dbtype                => 'pgx',
}
```

## Reference

see [REFERENCE.md](REFERENCE.md)

## Limitations

Tested with Debian 10 and 11, but should be fine on any Linux that uses Systemd.
