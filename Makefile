
GHDL = $(HOME)/ghdl/bin/ghdl

.PHONY: all
all: pulse_generator_testbench.vcd quadrature_decoder_testbench.vcd asynchronous_quadrature_decoder_testbench.vcd

pulse_generator_testbench-obj93.cf: pulse_generator_testbench.vhd pulse_generator.vhd
	$(GHDL) -i --work=pulse_generator_testbench $^

quadrature_decoder_testbench-obj93.cf: quadrature_decoder_testbench.vhd quadrature_decoder.vhd
	$(GHDL) -i --work=quadrature_decoder_testbench $^

asynchronous_quadrature_decoder_testbench-obj93.cf: asynchronous_quadrature_decoder_testbench.vhd asynchronous_quadrature_decoder.vhd
	$(GHDL) -i --work=asynchronous_quadrature_decoder_testbench $^

%_testbench.vcd: %_testbench
	./$< --vcd=$@

.PRECIOUS: %_testbench
%_testbench: %_testbench-obj93.cf
	$(GHDL) -m --work=$@ $@

.PHONY: clean
clean:
	rm -f *.o *.cf *_testbench *.vcd

