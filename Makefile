NAME = diffbot
OCAMLBUILD = ocamlbuild -use-ocamlfind
TARGETS = diffbot.cma diffbot.cmxa diffbot.cmi diffbot.a
INSTALL_TARGETS = $(TARGETS) diffbot.mli
LIB = $(addprefix _build/lib/, $(TARGETS)) 
INSTALL = $(LIB)

all:
	$(OCAMLBUILD) $(TARGETS)

clean:
	$(OCAMLBUILD) -clean

example:
	$(OCAMLBUILD) examples/ex1.native

install: all
	ocamlfind install $(NAME) META $(INSTALL)

uninstall:
	ocamlfind remove $(NAME)

.PHONY: all clean example install uninstall