open Printf
open Lwt
open Cohttp_lwt_unix

type api =
  | Article
  | Frontpage
  | Product
  | Image
  | Classifier

let default_version = "v2"

let base_url : ('a, unit, string) format = "http://%s.diffbot.com/%s/%s"

let uri_of_api version = function
  | Article -> sprintf base_url "api" version "article"
  | Product -> sprintf base_url "api" version "product"
  | Image -> sprintf base_url "api" version "image"
  | Classifier -> sprintf base_url "api" version "analyze"
  | Frontpage -> sprintf base_url "www" "api" "frontpage"

let analyze ?(version=default_version) ~token api ~url =
  let uri =
    let base = api
               |> uri_of_api version
               |> Uri.of_string
    in
    let params = [("url", url); ("token", token)] in
    let params = match api with
      | Frontpage -> ("format", "json")::params
      | _ -> params
    in Uri.add_query_params' base params
  in
  Client.get uri >>= function
  | None -> Lwt.fail (Failure "Bad request")
  | Some (_, body) ->
    body
    |> Cohttp_lwt_body.string_of_body
    >|= Yojson.Basic.from_string

