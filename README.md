# ocaml-diffbot

A Client for the diffbot API written in OCaml. See: <diffbot.com>


## Installation

This library depends on:

* Lwt - Cooperative threading library
* Cohttp - HTTP client
* Yojson - JSON library

Which must be installed through [OPAM](http://opam.ocaml.org/).

You can simply run `./deps.sh` once you clone this repo to install
all the dependencies

Once all the dependencies are installed, build the library by running
the following commands in the cloned repo:

```
$ make
$ make install # install with ocamlfind
# optionally if you want to play around with the example:
$ make example
```

## Configuration

You can set your API token by partially applying analyze. For example:

```
open Diffbot

let my_analyze = analyze ~token:"<totally secret>"

let resp = my_analyze Article ~url:"http://huffingtonpost.com"
```

## Example

You can run the example command line script after running:

```
$ make example
# Will run against http://www.xconomy.com/san-francisco/2012/07/25/diffbot-is-using-computer-vision-to-reinvent-the-semantic-web/
$ ./ex1.native <api token> frontpage
```

To compile your own code that uses this library, for example given a source
file `diffy.ml`:

```
open Diffbot

let () =
  let response = analyze Frontpage
                   ~token:"<secret>"
                   ~url:"http://huffingtonpost.com" in
  let json = Lwt_main.run response in
  print_endline "Response:";
  json |> Yojson.Basic.to_string |> print_endline

```

Build & run with:

```
$ ocamlbuild -use-ocamlfind -pkg diffbot diffy.native
$ ./diffy.native
```

## Documentation

Check out `lib/diffbot.mli`. There's only a single exposed function so the API is very simple.
The signature is copied over here:

```
(* The type of api calls to make *)
type api =
  | Article
  | Frontpage
  | Product
  | Image
  | Classifier

(* Analyze given a token,which api to use, a url to analyze *)
val analyze : ?version:string -> token:string -> api -> url:string -> json Lwt.t
```