## [1.1.0](https://github.com/roock/puppet-bareos_exporter/compare/v1.0.0...v1.1.0) (2023-05-04)


### Features

* **ci:** automatically bump version in metadata.json ([a6d0df0](https://github.com/roock/puppet-bareos_exporter/commit/a6d0df0e616c0534fecab50b04917a1bc546d28e))
* **ci:** run publish puppet module on release creation ([36a21fb](https://github.com/roock/puppet-bareos_exporter/commit/36a21fb852cb4377c6e2223b6cfc550da3d100b2))


### Bug Fixes

* **ci:** debug bump-metadata-version.sh ([d237078](https://github.com/roock/puppet-bareos_exporter/commit/d2370783287f93ffda9078f97fdddd6ac661c41d))
* **ci:** fix usage between GNU sed and BSD sed ([1abab02](https://github.com/roock/puppet-bareos_exporter/commit/1abab028a4d9688a3875fc0fce5e769d8f6ba282))

## 1.0.0 (2023-05-04)


### Features

* adding semantic release ([4b9eaab](https://github.com/roock/puppet-bareos_exporter/commit/4b9eaabbbeb9c5bf98c4e165821e59c7581d7084))
* automatically publish module on puppet forge ([fda44bf](https://github.com/roock/puppet-bareos_exporter/commit/fda44bf0982f1c9be8048d143c03fc1220922738))
* expose archive url variable in public class ([3ae8891](https://github.com/roock/puppet-bareos_exporter/commit/3ae88910bef6c6c75ccaac1b71bddf17cf083395))


### Bug Fixes

* **ci:** fix installation of conventional-changelog-conventionalcommits ([db55608](https://github.com/roock/puppet-bareos_exporter/commit/db5560888cfca2c663fd7d89f36d4989a8d1327b))
* **ci:** missing conventional-changelog-conventionalcommits plugin ([3d036c1](https://github.com/roock/puppet-bareos_exporter/commit/3d036c10b4ecf34fc61bf9383055b2d6c3617c4b))
* **type:** fix typo ([319afdc](https://github.com/roock/puppet-bareos_exporter/commit/319afdcd1d6be98576a412d3e70505a7ea8d9e11))
* wrong usage of variables in systemd template ([5a0c93a](https://github.com/roock/puppet-bareos_exporter/commit/5a0c93a7d0e10d3807f55f84a7c1ec0da536a69a))

# Changelog

All notable changes to this project will be documented in this file.

## Release 0.1.0

**Features**

- Initial Release

**Bugfixes**

**Known Issues**

- Bareos Exporter is not able to use environment variables so you need to have dsn params in a world readable file for systemd for now
- Probably some :)
