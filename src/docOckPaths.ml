(*
 * Copyright (c) 2014 Leo White <lpw25@cl.cam.ac.uk>
 *
 * Permission to use, copy, modify, and distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 *)

module Kind = struct

  type any =
    [ `Module | `ModuleType | `Type
    | `Constructor | `Field | `Extension
    | `Exception | `Value | `Class | `ClassType
    | `Method | `InstanceVariable | `Label ]

  type signature = [ `Module | `ModuleType ]

  type class_signature = [ `Class | `ClassType ]

  type datatype = [ `Type ]

  type parent = [ signature | class_signature | datatype ]

  type identifier = any

  type identifier_module = [ `Module ]
  type identifier_module_type = [ `ModuleType ]
  type identifier_type =  [ `Type ]
  type identifier_constructor = [ `Constructor ]
  type identifier_field = [ `Field ]
  type identifier_extension = [ `Extension ]
  type identifier_exception = [ `Exception ]
  type identifier_value = [ `Value ]
  type identifier_class = [ `Class ]
  type identifier_class_type = [ `ClassType ]
  type identifier_method = [ `Method ]
  type identifier_instance_variable = [ `InstanceVariable ]
  type identifier_label = [ `Label ]

  type path = [ `Module | `ModuleType | `Type | `Class | `ClassType ]

  type path_module = [ `Module ]
  type path_module_type = [ `ModuleType ]
  type path_type = [ `Type | `Class | `ClassType ]
  type path_class_type = [ `Class | `ClassType ]

  type fragment = [ `Module | `Type | `Class | `ClassType ]

  type fragment_module = [ `Module ]
  type fragment_type = [ `Type | `Class | `ClassType ]

  type reference = any

  type reference_module = [ `Module ]
  type reference_module_type = [ `ModuleType ]
  type reference_type = [ `Type | `Class | `ClassType ]
  type reference_constructor = [ `Constructor | `Extension | `Exception ]
  type reference_field = [ `Field ]
  type reference_extension = [ `Extension | `Exception ]
  type reference_exception = [ `Exception ]
  type reference_value = [ `Value ]
  type reference_class = [ `Class ]
  type reference_class_type = [ `Class | `ClassType ]
  type reference_method = [ `Method ]
  type reference_instance_variable = [ `InstanceVariable ]
  type reference_label = [ `Label ]

end

open Kind

module Identifier = struct

  type kind = Kind.identifier

  type ('a, 'b) t =
    | Root : 'a -> ('a, [< kind > `Module]) t
    | Module : 'a signature * string -> ('a, [< kind > `Module]) t
    | Argument : 'a signature * int * string -> ('a, [< kind > `Module]) t
    | ModuleType : 'a signature * string -> ('a, [< kind > `ModuleType]) t
    | Type : 'a signature * string -> ('a, [< kind > `Type]) t
    | CoreType : string -> ('a, [< kind > `Type]) t
    | Constructor : 'a datatype * string -> ('a, [< kind > `Constructor]) t
    | Field : 'a datatype * string -> ('a, [< kind > `Field]) t
    | Extension : 'a signature * string -> ('a, [< kind > `Extension]) t
    | Exception : 'a signature * string -> ('a, [< kind > `Exception]) t
    | CoreException : string -> ('a, [< kind > `Exception]) t
    | Value : 'a signature * string -> ('a, [< kind > `Value]) t
    | Class : 'a signature * string -> ('a, [< kind > `Class]) t
    | ClassType : 'a signature * string -> ('a, [< kind > `ClassType]) t
    | Method : 'a class_signature * string -> ('a, [< kind > `Method]) t
    | InstanceVariable : 'a class_signature * string ->
                           ('a, [< kind > `InstanceVariable]) t
    | Label : 'a parent * string -> ('a, [< kind > `Label]) t

  and 'a any = ('a, Kind.any) t
  and 'a signature = ('a, Kind.signature) t
  and 'a class_signature = ('a, Kind.class_signature) t
  and 'a datatype = ('a, Kind.datatype) t
  and 'a parent = ('a, Kind.parent) t

  type 'a module_ = ('a, identifier_module) t
  type 'a module_type = ('a, identifier_module_type) t
  type 'a type_ =  ('a, identifier_type) t
  type 'a constructor = ('a, identifier_constructor) t
  type 'a field = ('a, identifier_field) t
  type 'a extension = ('a, identifier_extension) t
  type 'a exception_ = ('a, identifier_exception) t
  type 'a value = ('a, identifier_value) t
  type 'a class_ = ('a, identifier_class) t
  type 'a class_type = ('a, identifier_class_type) t
  type 'a method_ = ('a, identifier_method) t
  type 'a instance_variable = ('a, identifier_instance_variable) t
  type 'a label = ('a, identifier_label) t

  type 'a path_module = ('a, Kind.path_module) t
  type 'a path_module_type = ('a, Kind.path_module_type) t
  type 'a path_type =  ('a, Kind.path_type) t
  type 'a path_class_type = ('a, Kind.path_class_type) t

  type 'a fragment_module = ('a, Kind.fragment_module) t
  type 'a fragment_type =  ('a, Kind.fragment_type) t

  type 'a reference_module = ('a, Kind.reference_module) t
  type 'a reference_module_type = ('a, Kind.reference_module_type) t
  type 'a reference_type =  ('a, Kind.reference_type) t
  type 'a reference_constructor = ('a, Kind.reference_constructor) t
  type 'a reference_field = ('a, Kind.reference_field) t
  type 'a reference_extension = ('a, Kind.reference_extension) t
  type 'a reference_exception = ('a, Kind.reference_exception) t
  type 'a reference_value = ('a, Kind.reference_value) t
  type 'a reference_class = ('a, Kind.reference_class) t
  type 'a reference_class_type = ('a, Kind.reference_class_type) t
  type 'a reference_method = ('a, Kind.reference_method) t
  type 'a reference_instance_variable = ('a, Kind.reference_instance_variable) t
  type 'a reference_label = ('a, Kind.reference_label) t

  let signature_of_module : 'a module_ -> _ = function
    | Root _ | Module _ | Argument _ as x -> x

  let signature_of_module_type : 'a module_type -> _  = function
    | ModuleType _ as x -> x

  let class_signature_of_class : 'a class_ -> _ = function
    | Class _ as x -> x

  let class_signature_of_class_type : 'a class_type -> _ = function
    | ClassType _ as x -> x

  let datatype_of_type : 'a type_ -> 'a datatype = function
    | x -> x

  let parent_of_signature : 'a signature -> 'a parent = function
    | Root _ | Module _ | Argument _ | ModuleType _ as x -> x

  let parent_of_class_signature : 'a class_signature -> 'a parent =
    function Class _ | ClassType _ as x -> x

  let parent_of_datatype : 'a datatype -> 'a parent =
    function Type _ | CoreType _ as x -> x

  let any : type k. ('a, k) t -> 'a any = function
    | Root _ as x -> x
    | Module _ as x -> x
    | Argument _ as x -> x
    | ModuleType _ as x -> x
    | Type _ as x -> x
    | CoreType _ as x -> x
    | Constructor _ as x -> x
    | Field _ as x -> x
    | Extension _ as x -> x
    | Exception _ as x -> x
    | CoreException _ as x -> x
    | Value _ as x -> x
    | Class _ as x -> x
    | ClassType _ as x -> x
    | Method _ as x -> x
    | InstanceVariable _ as x -> x
    | Label _ as x -> x

  let name : type k. ('a, k) t -> string option = function
    | Root _ -> None
    | Module(_, name) -> Some name
    | Argument(_, _, name) -> Some name
    | ModuleType(_, name) -> Some name
    | Type(_, name) -> Some name
    | CoreType name -> Some name
    | Constructor(_, name) -> Some name
    | Field(_, name) -> Some name
    | Extension(_, name) -> Some name
    | Exception(_, name) -> Some name
    | CoreException name -> Some name
    | Value(_, name) -> Some name
    | Class(_, name) -> Some name
    | ClassType(_, name) -> Some name
    | Method(_, name) -> Some name
    | InstanceVariable(_, name) -> Some name
    | Label(_, name) -> Some name
end



module Path = struct

  (* Separate types module to avoid repeating type definitions *)
  module rec Types : sig

    module Resolved : sig

      type kind = Kind.path

      type ('a, 'b) t =
        | Identifier : ('a, 'b) Identifier.t -> ('a, [< kind] as 'b) t
        | Module : 'a module_ * string -> ('a, [< kind > `Module]) t
        | Apply : 'a module_ * 'a Types.Path.module_ -> ('a, [< kind > `Module]) t
        | ModuleType : 'a module_ * string -> ('a, [< kind > `ModuleType]) t
        | Type : 'a module_ * string -> ('a, [< kind > `Type]) t
        | Class : 'a module_ * string -> ('a, [< kind > `Class]) t
        | ClassType : 'a module_ * string -> ('a, [< kind > `ClassType]) t

      and 'a any = ('a, kind) t

      and 'a module_ = ('a, path_module) t
      and 'a module_type = ('a, path_module_type) t
      and 'a type_ = ('a, path_type) t
      and 'a class_type = ('a, path_class_type) t

    end

    module Path : sig

      type kind = Kind.path

      type ('a, 'b) t =
      | Resolved : ('a, 'b) Types.Resolved.t -> ('a, 'b) t
      | Root : string -> ('a, [< kind >`Module]) t
      | Dot : 'a module_ * string -> ('a, [< kind]) t
      | Apply : 'a module_ * 'a module_ -> ('a, [< kind >`Module]) t

      and 'a any = ('a, kind) t

      and 'a module_ = ('a, path_module) t
      and 'a module_type = ('a, path_module_type) t
      and 'a type_ = ('a, path_type) t
      and 'a class_type = ('a, path_class_type) t

    end

  end = Types

  module Resolved = struct

    open Identifier

    include Types.Resolved

    let ident_module (m: 'a Identifier.module_) = Identifier m

    let ident_module_type (mt: 'a Identifier.module_type) = Identifier mt

    let ident_type : 'a Identifier.type_ -> 'a type_ = function
    | Type _ | CoreType _ as t -> Identifier t

    let ident_class : 'a Identifier.class_ -> 'a class_type = function
    | Class _ as c -> Identifier c

    let ident_class_type : 'a Identifier.class_type -> 'a class_type = function
      | ClassType _ as ct -> Identifier ct

    let any : type k. ('a, k) t -> 'a any = function
      | Identifier (Root _) as x -> x
      | Identifier (Module _) as x -> x
      | Identifier (Argument _) as x -> x
      | Identifier (ModuleType _) as x -> x
      | Identifier (Type _) as x -> x
      | Identifier (CoreType _) as x -> x
      | Identifier (Class _) as x -> x
      | Identifier (ClassType _) as x -> x
      | Module _ as x -> x
      | Apply _ as x -> x
      | ModuleType _ as x -> x
      | Type _ as x -> x
      | Class _ as x -> x
      | ClassType _ as x -> x

    let rec identifier : type k. ('a, k) t -> ('a, k) Identifier.t = function
      | Identifier id -> id
      | Module(m, n) -> Module(signature_of_module (identifier m), n)
      | Apply(m, _) -> begin
          match identifier m with
          | Root _ | Module _ | Argument _ as x -> x
        end
      | ModuleType(m, n) -> ModuleType(signature_of_module (identifier m), n)
      | Type(m, n) -> Type(signature_of_module (identifier m), n)
      | Class(m, n) -> Class(signature_of_module (identifier m), n)
      | ClassType(m, n) -> ClassType(signature_of_module (identifier m), n)

  end

  open Identifier
  open Resolved

  include Types.Path

  let ident_module (m: 'a Identifier.module_) = Resolved (Identifier m)

  let ident_module_type (mt: 'a Identifier.module_type) =
    Resolved (Identifier mt)

  let ident_type : 'a Identifier.type_ -> 'a type_ = function
    | Type _ | CoreType _ as t -> Resolved (Identifier t)

  let ident_class : 'a Identifier.class_ -> 'a class_type = function
    | Class _ as c -> Resolved (Identifier c)

  let ident_class_type : 'a Identifier.class_type -> 'a class_type = function
    | ClassType _ as ct -> Resolved (Identifier ct)

  let any : type k. ('a, k) t -> 'a any = function
    | Resolved (Identifier (Root _)) as x -> x
    | Resolved (Identifier (Module _)) as x -> x
    | Resolved (Identifier (Argument _)) as x -> x
    | Resolved (Identifier (ModuleType _)) as x -> x
    | Resolved (Identifier (Type _)) as x -> x
    | Resolved (Identifier (CoreType _)) as x -> x
    | Resolved (Identifier (Class _)) as x -> x
    | Resolved (Identifier (ClassType _)) as x -> x
    | Resolved (Module _) as x -> x
    | Resolved (Apply _) as x -> x
    | Resolved (ModuleType _) as x -> x
    | Resolved (Type _) as x -> x
    | Resolved (Class _) as x -> x
    | Resolved (ClassType _) as x -> x
    | Root _ as x -> x
    | Dot _ as x -> x
    | Apply _ as x -> x

  let module_ p name =
    match p with
    | Resolved p -> Resolved (Module(p, name))
    | p -> Dot(p, name)

  let apply p arg =
    match p with
    | Resolved p -> Resolved (Apply(p, arg))
    | p -> Apply(p, arg)

  let module_type p name =
    match p with
    | Resolved p -> Resolved (ModuleType(p, name))
    | p -> Dot(p, name)

  let type_ p name =
    match p with
    | Resolved p -> Resolved (Type(p, name))
    | p -> Dot(p, name)

  let class_ p name =
    match p with
    | Resolved p -> Resolved (Class(p, name))
    | p -> Dot(p, name)

  let class_type_ p name =
    match p with
    | Resolved p -> Resolved (ClassType(p, name))
    | p -> Dot(p, name)

end



module Fragment = struct

  module Resolved = struct

    type kind = Kind.fragment

    type sort = [ `Root | `Branch ]

    type ('a, 'b) raw =
      | Root : ('a, [< sort > `Root]) raw
      | Module : signature * string -> ([< kind > `Module], [< sort > `Branch]) raw
      | Type : signature * string -> ([< kind > `Type], [< sort > `Branch]) raw
      | Class : signature * string -> ([< kind > `Class], [< sort > `Branch]) raw
      | ClassType : signature * string -> ([< kind > `ClassType], [< sort > `Branch]) raw

    and 'a t = ('a, [`Branch]) raw

    and any = kind t
    and signature = (fragment_module, [`Root | `Branch]) raw

    and module_ = fragment_module t
    and type_ = fragment_type t

    let rec signature_of_module : module_ -> signature = function
      | Module _ as x -> x

    let any : type k. k t -> any = function
      | Module _ as x -> x
      | Type _ as x -> x
      | Class _ as x -> x
      | ClassType _ as x -> x

    let path (root : 'a Path.module_) frag =
      match root with
      | Path.Resolved root ->
          let rec loop : type k. k t -> ('a, k) Path.Resolved.t = function
            | Module(Root, n) -> Path.Resolved.Module(root, n)
            | Module(Module _ as m, n) -> Path.Resolved.Module(loop m, n)
            | Type(Root, n) -> Path.Resolved.Type(root, n)
            | Type(Module _ as m, n) -> Path.Resolved.Type(loop m, n)
            | Class(Root, n) -> Path.Resolved.Class(root, n)
            | Class(Module _ as m, n) -> Path.Resolved.Class(loop m, n)
            | ClassType(Root, n) -> Path.Resolved.ClassType(root, n)
            | ClassType(Module _ as m, n) -> Path.Resolved.ClassType(loop m, n)
          in
            Path.Resolved (loop frag)
      | _ ->
          let rec loop : type k. k t -> ('a, k) Path.t = function
            | Module(Root, n) -> Path.Dot(root, n)
            | Module(Module _ as m, n) -> Path.Dot(loop m, n)
            | Type(Root, n) -> Path.Dot(root, n)
            | Type(Module _ as m, n) -> Path.Dot(loop m, n)
            | Class(Root, n) -> Path.Dot(root, n)
            | Class(Module _ as m, n) -> Path.Dot(loop m, n)
            | ClassType(Root, n) -> Path.Dot(root, n)
            | ClassType(Module _ as m, n) -> Path.Dot(loop m, n)
          in
            loop frag

    let rec identifier :
      type k. 'a Identifier.signature -> k t -> ('a, k) Identifier.t =
        fun root -> function
        | Module(Root, n) -> Identifier.Module(root, n)
        | Module(Module _ as m, n) ->
            let m = Identifier.signature_of_module (identifier root m) in
              Identifier.Module(m, n)
        | Type(Root, n) -> Identifier.Type(root, n)
        | Type(Module _ as m, n) ->
            let m = Identifier.signature_of_module (identifier root m) in
              Identifier.Type(m, n)
        | Class(Root, n) -> Identifier.Class(root, n)
        | Class(Module _ as m, n) ->
            let m = Identifier.signature_of_module (identifier root m) in
              Identifier.Class(m, n)
        | ClassType(Root, n) -> Identifier.ClassType(root, n)
        | ClassType(Module _ as m, n) ->
            let m = Identifier.signature_of_module (identifier root m) in
              Identifier.ClassType(m, n)

  let rec split_module : module_ -> string * signature = function
    | Module(Root, name) -> name, Root
    | Module(Module _ as m, name) ->
        let base, m = split_module m in
          base, Module(m, name)

  let split : type k . k t -> string * k t option = function
    | Module(Root, name) -> name, None
    | Module(Module _ as m, name) ->
        let base, m = split_module m in
          base, Some (Module(m, name))
    | Type(Root, base) -> base, None
    | Type(Module _ as m, name) ->
        let base, m = split_module m in
          base, Some (Type(m, name))
    | Class(Root, base) -> base, None
    | Class(Module _ as m, name) ->
        let base, m = split_module m in
          base, Some (Class(m, name))
    | ClassType(Root, base) -> base, None
    | ClassType(Module _ as m, name) ->
        let base, m = split_module m in
          base, Some (ClassType(m, name))

  end

  open Resolved

  type kind = Kind.fragment

  type sort = [ `Root | `Branch ]

  type ('a, 'b) raw =
    | Resolved : ('a, 'b) Resolved.raw -> ('a, 'b) raw
    | Dot : signature * string -> ([< kind], [< sort > `Branch]) raw

  and 'a t = ('a, [`Branch]) raw

  and any = kind t
  and signature = (fragment_module, [`Root | `Branch]) raw

  and module_ = fragment_module t
  and type_ = fragment_type t

  let signature_of_module : module_ -> signature = function
    | Resolved(Module _) | Dot _ as x -> x

  let any : type k. k t -> any = function
    | Resolved (Module _) as x -> x
    | Resolved (Type _) as x -> x
    | Resolved (Class _) as x -> x
    | Resolved (ClassType _) as x -> x
    | Dot _ as x -> x

  let rec path : type k. 'a Path.module_ -> k t -> ('a, k) Path.t =
   fun root -> function
    | Resolved r -> Resolved.path root r
    | Dot(Resolved Root, s) -> Path.Dot(root, s)
    | Dot(Resolved (Module _) as m, s) -> Path.Dot(path root m, s)
    | Dot(Dot _ as m, s) -> Path.Dot(path root m, s)

  let rec split_module : module_ -> string * signature = function
    | Resolved r ->
        let base, m = Resolved.split_module r in
          base, Resolved m
    | Dot((Resolved Root), name) -> name, Resolved Root
    | Dot(Resolved(Module _) | Dot _ as m, name) ->
        let base, m = split_module m in
          base, Dot(m, name)

  let split : type k . k t -> string * k t option = function
    | Resolved r ->
        let base, m = Resolved.split r in
        let m =
          match m with
          | None -> None
          | Some m -> Some (Resolved m)
        in
          base, m
    | Dot((Resolved Root), name) -> name, None
    | Dot(Resolved(Module _) | Dot _ as m, name) ->
        let base, m = split_module m in
          base, Some(Dot(m, name))

end



module Reference = struct

  module Resolved = struct

    open Identifier
    open Kind

    type kind = Kind.reference

    type ('a, 'b) t =
      | Identifier : ('a, 'b) Identifier.t -> ('a, 'b) t
      | Module : 'a signature * string -> ('a, [< kind > `Module]) t
      | ModuleType : 'a signature * string -> ('a, [< kind > `ModuleType]) t
      | Type : 'a signature * string -> ('a, [< kind > `Type]) t
      | Constructor : 'a datatype * string -> ('a, [< kind > `Constructor]) t
      | Field : 'a datatype * string -> ('a, [< kind > `Field]) t
      | Extension : 'a signature * string -> ('a, [< kind > `Extension]) t
      | Exception : 'a signature * string -> ('a, [< kind > `Exception]) t
      | Value : 'a signature * string -> ('a, [< kind > `Value]) t
      | Class : 'a signature * string -> ('a, [< kind > `Class]) t
      | ClassType : 'a signature * string -> ('a, [< kind > `ClassType]) t
      | Method : 'a class_signature * string -> ('a, [< kind > `Method]) t
      | InstanceVariable : 'a class_signature * string ->
                             ('a, [< kind > `InstanceVariable]) t
      | Label : 'a parent * string -> ('a, [< kind > `Label]) t

    and 'a any = ('a, kind) t
    and 'a signature = ('a, Kind.signature) t
    and 'a class_signature = ('a, Kind.class_signature) t
    and 'a datatype = ('a, Kind.datatype) t
    and 'a parent = ('a, Kind.parent) t

    type 'a module_ = ('a, reference_module) t
    type 'a module_type = ('a, reference_module_type) t
    type 'a type_ = ('a, reference_type) t
    type 'a constructor = ('a, reference_constructor) t
    type 'a field = ('a, reference_field) t
    type 'a extension = ('a, reference_extension) t
    type 'a exception_ = ('a, reference_exception) t
    type 'a value = ('a, reference_value) t
    type 'a class_ = ('a, reference_class) t
    type 'a class_type = ('a, reference_class_type) t
    type 'a method_ = ('a, reference_method) t
    type 'a instance_variable = ('a, reference_instance_variable) t
    type 'a label = ('a, reference_label) t

    let ident_module (m: 'a Identifier.module_) = Identifier m

    let ident_module_type (mt: 'a Identifier.module_type) = Identifier mt

    let ident_type : 'a Identifier.type_ -> 'a type_ = function
    | Type _ | CoreType _ as t -> Identifier t

    let ident_datatype (t : 'a Identifier.type_) = Identifier t

    let ident_constructor : 'a Identifier.constructor -> 'a constructor = function
      | Constructor _ as c -> Identifier c

    let ident_extension : 'a Identifier.extension -> 'a extension = function
      | Extension _ as e -> Identifier e

    let ident_exception (e : 'a Identifier.exception_) = Identifier e

    let ident_field (f: 'a Identifier.field) = Identifier f

    let ident_value (v: 'a Identifier.value) = Identifier v

    let ident_class (c: 'a Identifier.class_) = Identifier c

    let ident_class_type : 'a Identifier.class_type -> 'a class_type = function
      | ClassType _ as ct -> Identifier ct

    let ident_method (m : 'a Identifier.method_) = Identifier m

    let ident_instance_variable (iv : 'a Identifier.instance_variable) =
      Identifier iv

    let ident_label (l : 'a Identifier.label) = Identifier l

    let signature_of_module : 'a module_ -> _ = function
      | Identifier (Root _ | Module _ | Argument _) | Module _ as x -> x

    let signature_of_module_type : 'a module_type -> _ = function
      | Identifier (ModuleType _) | ModuleType _ as x -> x

    let class_signature_of_class : 'a class_ -> _ = function
      | Identifier (Class _) | Class _ as x -> x

    let class_signature_of_class_type : 'a class_type -> _ = function
      | Identifier (Class _ | ClassType _) | Class _ | ClassType _ as x -> x

    let parent_of_signature : 'a signature -> _ = function
      | Identifier (Root _ | Module _ | Argument _ | ModuleType _)
      | Module _ | ModuleType _ as x -> x

    let parent_of_class_signature : 'a class_signature -> _ =
      function
      | Identifier (Class _ | ClassType _) | Class _ | ClassType _ as x -> x

    let parent_of_datatype : 'a datatype -> _ = function
      | Identifier (Type _ |CoreType _) | Type _ as x -> x

    let any : type k. ('a, k) t -> 'a any = function
      | Identifier (Root _ ) as x -> x
      | Identifier (Module _) as x -> x
      | Identifier (Argument _ ) as x -> x
      | Identifier (ModuleType _) as x -> x
      | Identifier (Type _) as x -> x
      | Identifier (CoreType _) as x -> x
      | Identifier (Constructor _) as x -> x
      | Identifier (Field _) as x -> x
      | Identifier (Extension _) as x -> x
      | Identifier (Exception _) as x -> x
      | Identifier (CoreException _) as x -> x
      | Identifier (Value _) as x -> x
      | Identifier (Class _) as x -> x
      | Identifier (ClassType _) as x -> x
      | Identifier (Method _) as x -> x
      | Identifier (InstanceVariable _) as x -> x
      | Identifier (Label _) as x -> x
      | Module _ as x -> x
      | ModuleType _ as x -> x
      | Type _ as x -> x
      | Constructor _ as x -> x
      | Field _ as x -> x
      | Extension _ as x -> x
      | Exception _ as x -> x
      | Value _ as x -> x
      | Class _ as x -> x
      | ClassType _ as x -> x
      | Method _ as x -> x
      | InstanceVariable _ as x -> x
      | Label _ as x -> x

    let rec identifier: type k. ('a, k) t -> ('a, k) Identifier.t = function
       | Identifier id -> id
       | Module(s, n) -> Module(identifier s, n)
       | ModuleType(s, n) -> ModuleType(identifier s, n)
       | Type(s, n) -> Type(identifier s, n)
       | Constructor(s, n) -> Constructor(identifier s, n)
       | Field(s, n) -> Field(identifier s, n)
       | Extension(s, n) -> Extension(identifier s, n)
       | Exception(s, n) -> Exception(identifier s, n)
       | Value(s, n) -> Value(identifier s, n)
       | Class(s, n) -> Class(identifier s, n)
       | ClassType(s, n) -> ClassType(identifier s, n)
       | Method(s, n) -> Method(identifier s, n)
       | InstanceVariable(s, n) -> InstanceVariable(identifier s, n)
       | Label(s, n) -> Label(identifier s, n)

  end

  open Identifier
  open Resolved
  open Kind

  type kind = Kind.reference

  type ('a, 'b) t =
    | Resolved : ('a, 'b) Resolved.t -> ('a, 'b) t
    | Root : string -> ('a, [< kind]) t
    | Dot : 'a parent * string -> ('a, [< kind]) t

  and 'a any = ('a, kind) t
  and 'a signature = ('a, Kind.signature) t
  and 'a class_signature = ('a, Kind.class_signature) t
  and 'a datatype = ('a, Kind.datatype) t
  and 'a parent = ('a, Kind.parent) t

  type 'a module_ = ('a, reference_module) t
  type 'a module_type = ('a, reference_module_type) t
  type 'a type_ = ('a, reference_type) t
  type 'a constructor = ('a, reference_constructor) t
  type 'a field = ('a, reference_field) t
  type 'a extension = ('a, reference_extension) t
  type 'a exception_ = ('a, reference_exception) t
  type 'a value = ('a, reference_value) t
  type 'a class_ = ('a, reference_class) t
  type 'a class_type = ('a, reference_class_type) t
  type 'a method_ = ('a, reference_method) t
  type 'a instance_variable = ('a, reference_instance_variable) t
  type 'a label = ('a, reference_label) t

  let ident_module (m: 'a Identifier.module_) = Resolved (Identifier m)

  let ident_module_type (mt: 'a Identifier.module_type) =
    Resolved (Identifier mt)

  let ident_type : 'a Identifier.type_ -> 'a type_ = function
    | Type _ | CoreType _ as t -> Resolved (Identifier t)

  let ident_datatype (t : 'a Identifier.type_) = Resolved (Identifier t)

  let ident_constructor : 'a Identifier.constructor -> 'a constructor =
    function
    | Constructor _ as c -> Resolved (Identifier c)

  let ident_field (f: 'a Identifier.field) = Resolved (Identifier f)

  let ident_extension : 'a Identifier.extension -> 'a extension = function
    | Extension _ as e -> Resolved (Identifier e)

  let ident_exception (e : 'a Identifier.exception_) = Resolved (Identifier e)

  let ident_value (v: 'a Identifier.value) = Resolved (Identifier v)

  let ident_class (c: 'a Identifier.class_) = Resolved (Identifier c)

  let ident_class_type : 'a Identifier.class_type -> 'a class_type = function
    | ClassType _ as ct -> Resolved (Identifier ct)

  let ident_method (m : 'a Identifier.method_) = Resolved (Identifier m)

  let ident_instance_variable (iv : 'a Identifier.instance_variable) =
    Resolved (Identifier iv)

  let ident_label (l : 'a Identifier.label) = Resolved (Identifier l)

  let signature_of_module : 'a module_ -> _ = function
    | Resolved (Identifier (Root _ | Module _ | Argument _) | Module _)
    | Root _ | Dot _ as x -> x

  let signature_of_module_type : 'a module_type -> _ = function
    | Resolved (Identifier (ModuleType _) | ModuleType _)
    | Root _ | Dot _ as x -> x

  let class_signature_of_class : 'a class_ -> _ = function
    | Resolved (Identifier (Class _) | Class _)
    | Root _ | Dot _ as x -> x

  let class_signature_of_class_type : 'a class_type -> _ = function
    | Resolved (Identifier (Class _ | ClassType _) | Class _ | ClassType _)
    | Root _ | Dot _ as x -> x

  let parent_of_signature : 'a signature -> 'a parent = function
    | Resolved (Identifier (Root _ | Module _ | Argument _ | ModuleType _)
                | Module _ | ModuleType _)
    | Root _ | Dot _ as x -> x

  let parent_of_class_signature : 'a class_signature -> 'a parent = function
    | Resolved (Identifier (Class _ | ClassType _) | Class _ | ClassType _)
    | Root _ | Dot _ as x -> x

  let parent_of_datatype : 'a datatype -> 'a parent = function
    | Resolved (Identifier (Type _ | CoreType _) | Type _)
    | Root _ | Dot _ as x -> x

  let any : type k. ('a, k) t -> 'a any = function
    | Resolved (Identifier (Root _)) as x -> x
    | Resolved (Identifier (Module _)) as x -> x
    | Resolved (Identifier (Argument _)) as x -> x
    | Resolved (Identifier (ModuleType _)) as x -> x
    | Resolved (Identifier (Type _)) as x -> x
    | Resolved (Identifier (CoreType _)) as x -> x
    | Resolved (Identifier (Constructor _)) as x -> x
    | Resolved (Identifier (Field _)) as x -> x
    | Resolved (Identifier (Extension _)) as x -> x
    | Resolved (Identifier (Exception _)) as x -> x
    | Resolved (Identifier (CoreException _)) as x -> x
    | Resolved (Identifier (Value _)) as x -> x
    | Resolved (Identifier (Class _)) as x -> x
    | Resolved (Identifier (ClassType _)) as x -> x
    | Resolved (Identifier (Method _)) as x -> x
    | Resolved (Identifier (InstanceVariable _)) as x -> x
    | Resolved (Identifier (Label _)) as x -> x
    | Resolved (Module _) as x -> x
    | Resolved (ModuleType _) as x -> x
    | Resolved (Type _) as x -> x
    | Resolved (Constructor _) as x -> x
    | Resolved (Field _) as x -> x
    | Resolved (Extension _) as x -> x
    | Resolved (Exception _) as x -> x
    | Resolved (Value _) as x -> x
    | Resolved (Class _) as x -> x
    | Resolved (ClassType _) as x -> x
    | Resolved (Method _) as x -> x
    | Resolved (InstanceVariable _) as x -> x
    | Resolved (Label _) as x -> x
    | Root _ as x -> x
    | Dot _ as x -> x

end
