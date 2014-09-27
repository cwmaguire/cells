.PHONY: compile

.DEFAULT_GOAL := compile

erl_srcs = $(wildcard src/*.erl)
erl_beams = $(addprefix ebin/,$(notdir $(erl_srcs))):

define build
$(1): $(2)

	erlc -o ebin $(2)
endef

$(foreach src,$(erl_srcs),$(eval $(build)))

#@echo $(addprefix ebin/,$(notdir $(wildcard src/*.erl)))
#@echo $(erl_srcs:%.erl=%.beam)

compile: $(erl_beams)
