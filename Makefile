
GHDL = $(HOME)/ghdl/bin/ghdl

.PHONY: all
all: quadrature_decoder_testbench.vcd

quadrature_decoder_testbench-obj93.cf: quadrature_decoder_testbench.vhd quadrature_decoder.vhd detdff.vhd
	$(GHDL) -i --work=quadrature_decoder_testbench $^

%_testbench.vcd: %_testbench
	./$< --vcd=$@

.PRECIOUS: %_testbench
%_testbench: %_testbench-obj93.cf
	$(GHDL) -m --work=$@ $@

.PHONY: clean
clean:
	rm -f *.o *.cf *_testbench *.vcd

