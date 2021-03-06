open Result

type sections_allowed = Ast.sections_allowed

val parse_comment :
  permissive:bool ->
  sections_allowed:sections_allowed ->
  containing_definition:Model.Paths.Identifier.label_parent ->
  location:Lexing.position ->
  text:string ->
    ((Model.Comment.docs, Model.Error.t) result) Model.Error.with_warnings

(** Converts fatal errors to warnings for now, by emitting a blank comment. This
    is a temporary measure, because the code that drives the parser does not yet
    have proper error handling written. *)
val errors_to_warnings :
  ((Model.Comment.docs, Model.Error.t) result) Model.Error.with_warnings ->
    ((Model.Comment.docs, Model.Error.t) result) Model.Error.with_warnings
