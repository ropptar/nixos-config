{ lib, ... }:

let
  opt = { type, default ? null, description ? null }: lib.mkOption {
    inherit type default description;
  };

  optEnable = lib.mkEnableOption;


  optStr = { default, description }: opt {
    type = lib.types.str;
    inherit default description;
  };

  optInt = { default, description }: opt {
    type = lib.types.int;
    inherit default description;
  };

  optList = { type ? lib.types.str, default ? [ ], description }:
    let
      elemType = {
        str = lib.types.str;
        int = lib.types.int;
        pkg = lib.types.package;
      }.${type} or builtins.throw "List of ${type} support not implemented";
    in
    opt {
      type = lib.types.listOf elemType;
      inherit default description;
    };
in
{
  inherit optEnable optStr optInt optList;
}
