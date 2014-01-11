open Diffbot

(*
   example of how to use the diffbot client. run with:
   ./ex1.native <top secret api token> [article | frontpage | product | image | classifier]
*)

let api_of_string = function
  | "article" -> Article
  | "frontpage" -> Frontpage
  | "product" -> Product
  | "image" -> Image
  | "classifier" -> Classifier
  | unknown -> failwith ("Unknown api type: " ^ unknown)

let () =
  let response = analyze (api_of_string Sys.argv.(2))
                   ~token:(Sys.argv.(1))
                   ~url:"http://www.xconomy.com/san-francisco/2012/07/25/diffbot-is-using-computer-vision-to-reinvent-the-semantic-web/" in
  let json = Lwt_main.run response in
  print_endline "Response:";
  print_endline @@ Yojson.Basic.to_string json
