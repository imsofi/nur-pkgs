{ callPackage, ... }:
rec {
  authlib1 = callPackage ../development/python-modules/authlib1 { };

  flask-themer = callPackage ../development/python-modules/flask-themer { };

  flask-webtest = callPackage ../development/python-modules/flask-webtest { };
}
