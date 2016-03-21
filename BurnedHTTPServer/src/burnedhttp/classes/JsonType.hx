package burnedhttp.classes;
// This works only for basic class instances but you can extend it to work with 
// any type.
// It doesn't work with nested class instances; you can detect the required
// types with macros (will fail for interfaces or extended classes) or keep
// track of the types in the serialized object.
// Also you will have problems with objects that have circular references.

class JsonType {
  public static function encode(o : Dynamic) : String {
    // to solve some of the issues above you should iterate on all the fields,
    // check for a non-compatible Json type and build a structure like the
    // following before serializing
    return haxe.Json.stringify({
      type : Type.getClassName(Type.getClass(o)),
      data : o
    }, null, "    ");
  }

  public static function decode<T>(s : String) : T {
    var o = haxe.Json.parse(s),
        inst = Type.createEmptyInstance(Type.resolveClass(o.type));
    populate(inst, o.data);
    return inst;
  }

  static function populate(inst, data) {
    for(field in Reflect.fields(data)) {
      Reflect.setField(inst, field, Reflect.field(data, field));
    }
  }
}