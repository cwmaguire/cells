.PHONY: all compile rel clean-all clean clean-rel clean-dump

.DEFAULT_GOAL := all


app_dirs = $(wildcard apps/*/)
app_dir_targets = $(foreach app, $(wildcard apps/*/), $(app)_)
erl_srcs = $(wildcard src/*.erl)
erl_beams = $(foreach src,$(erl_srcs),$(call beam,$(src)))

define beam
	$(addsuffix .beam,$(addprefix ebin/,$(notdir $(basename $(1)))))
endef

define build
$(1): $(2)
	erlc -o ebin $(2)
endef

define Emake
$(1):
	cd $(2); erl -make
endef

$(foreach src, $(erl_srcs), $(eval $(call build, $(call beam, $(src)), $(src))))

$(foreach app, $(app_dirs), $(eval $(call Emake, $(app)_, $(app))))

all: compile ebin/cells.script

#compile: $(erl_beams)

compile: $(app_dir_targets)

app-dirs:
	@echo $(app_dirs)

rel: cells.script

ebin/cells.script: ebin/cells.rel ebin/cells.app
	@cd ebin; erl -run systools make_script cells -s erlang halt

clean-all: clean clean-rel clean-dump

clean:
	@rm -f ebin/*.beam

clean-rel:
	@rm -f ebin/*.script
	@rm -f ebin/*.boot

clean-dump:
	@rm -f ebin/*.dump
