-- quadrature_decoder_testbench - testbench for quadrature decoder
-- Written in 2016 by <Ahmet Inan> <xdsopl@googlemail.com>
-- To the extent possible under law, the author(s) have dedicated all copyright and related and neighboring rights to this software to the public domain worldwide. This software is distributed without any warranty.
-- You should have received a copy of the CC0 Public Domain Dedication along with this software. If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

library ieee;
use ieee.std_logic_1164.all;

entity quadrature_decoder_testbench is
end quadrature_decoder_testbench;

architecture bs of quadrature_decoder_testbench is
	signal a, b : std_logic := '0';
	signal rotary : std_logic_vector (1 downto 0);
	signal direction : std_logic;
	signal pulse : std_logic;

	procedure noise(variable n : inout std_logic_vector(15 downto 0)) is
	begin
		n := (n(0) xor n(3)) & n(15 downto 1);
	end procedure;

	procedure switch(
		signal s : out std_logic;
		constant v : std_logic;
		variable n : inout std_logic_vector(15 downto 0)) is
	begin
		s <= v;
		wait for 10 us;
		for i in 0 to 9 loop
			s <= n(0);
			noise(n);
			wait for 10 us;
		end loop;
		s <= v;
		wait for 1 ms;
	end procedure;
begin
	rotary <= b & a;

	quadrature_decoder_inst : entity work.quadrature_decoder
		port map (rotary, direction, pulse);

	stimulus : process
		variable n : std_logic_vector(15 downto 0) := (15 => '1', others => '0');
	begin
		-- start position
		a <= '0';
		b <= '0';
		wait for 2 ms;

		-- one step left
		switch(a, '1', n);
		switch(b, '1', n);
		switch(a, '0', n);
		switch(b, '0', n);
		wait for 1 ms;

		-- one step right
		switch(b, '1', n);
		switch(a, '1', n);
		switch(b, '0', n);
		switch(a, '0', n);
		wait for 1 ms;

		-- one step left
		switch(a, '1', n);
		switch(b, '1', n);
		switch(a, '0', n);
		switch(b, '0', n);
		wait for 1 ms;

		-- one step right
		switch(b, '1', n);
		switch(a, '1', n);
		switch(b, '0', n);
		switch(a, '0', n);
		wait for 1 ms;

		-- one step right
		switch(b, '1', n);
		switch(a, '1', n);
		switch(b, '0', n);
		switch(a, '0', n);
		wait for 1 ms;

		-- one step left
		switch(a, '1', n);
		switch(b, '1', n);
		switch(a, '0', n);
		switch(b, '0', n);
		wait for 1 ms;

		-- one step left
		switch(a, '1', n);
		switch(b, '1', n);
		switch(a, '0', n);
		switch(b, '0', n);
		wait for 1 ms;

		wait;
	end process;
end bs;
