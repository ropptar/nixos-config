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

  optList = type ? "str": default ? [ ]: description ? null:
    let
      elemType = {
        str = lib.types.str;
        int = lib.types.int;
        pkg = lib.types.package;
      }.${type} or builtins.throw "List of ${type} support not implemented";
      desc = if description != null
             then "${description} [${type}]"
             else "List of ${type} values"
    in
    opt {
      type = lib.types.listOf elemType;
      inherit default desc;
    };
in
{
  inherit optEnable optStr optInt optList;
}
