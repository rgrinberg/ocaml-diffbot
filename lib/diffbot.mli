(** Client for the diffbot API  *)
open Yojson.Basic

type api =
  | Article
  | Frontpage
  | Product
  | Image
  | Classifier
(** Type of api calls available  *)

val analyze : ?version:string -> token:string -> api -> url:string -> json Lwt.t
(** Analyze a [url] with the [api]. The default version is "v2" *)
