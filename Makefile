.PHONY: compile

.DEFAULT_GOAL := compile

erl_srcs = $(wildcard src/*.erl)
erl_beams = $(foreach src,$(erl_srcs),$(call beam,$(src)))

define beam
	$(addsuffix .beam,$(addprefix ebin/,$(notdir $(basename $(1)))))
endef

define build
$(1): $(2)
	$(info $(1),$(2))
	@echo build called for $(1) $(2)
	erlc -o ebin $(2)
endef

$(foreach src, $(erl_srcs), $(eval $(call build, $(call beam, $(src)), $(src))))

compile: $(erl_beams)

#@echo $(call build,$<,$(call beam, $<))

test: src/cells.erl
	@echo $(erl_srcs)
	@echo $(erl_beams)
	@echo $<
	@echo $(call beam, $<)
