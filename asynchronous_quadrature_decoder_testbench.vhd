-- asynchronous_quadrature_decoder_testbench - testbench for asynchronous quadrature decoder
-- Written in 2016 by <Ahmet Inan> <xdsopl@googlemail.com>
-- To the extent possible under law, the author(s) have dedicated all copyright and related and neighboring rights to this software to the public domain worldwide. This software is distributed without any warranty.
-- You should have received a copy of the CC0 Public Domain Dedication along with this software. If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

library ieee;
use ieee.std_logic_1164.all;

entity asynchronous_quadrature_decoder_testbench is
end asynchronous_quadrature_decoder_testbench;

architecture behavioral of asynchronous_quadrature_decoder_testbench is
	signal a, b : std_logic := '0';
	signal rotary : std_logic_vector (1 downto 0);
	signal direction : std_logic;
	signal pulse : std_logic;

	procedure noise(variable n : inout std_logic_vector(15 downto 0)) is
	begin
		-- Thanks Maxim on smspower for (reverse engineered?) specs.
		-- Generator polynomial for noise channel of SN76489
		-- used on the SMS is not irrereducible: X^16 + X^13 + 1
		n := (n(0) xor n(3)) & n(15 downto 1);
	end procedure;

	procedure switch(
		signal s : out std_logic;
		constant v : std_logic;
		variable n : inout std_logic_vector(15 downto 0)) is
	begin
		s <= v;
		wait for 10 us;
		for i in 1 to 19 loop
			s <= n(0);
			noise(n);
			wait for 10 us;
		end loop;
		s <= v;
		wait for 800 us;
	end procedure;
begin
	rotary <= b & a;

	asynchronous_quadrature_decoder_inst : entity work.asynchronous_quadrature_decoder
		port map (rotary, direction, pulse);

	stimulus : process
		variable n : std_logic_vector(15 downto 0) := (15 => '1', others => '0');
	begin
		-- start position
		a <= '0';
		b <= '0';
		wait for 2 ms;

		for j in 0 to 2 loop
			for i in 0 to j loop
				-- one step left
				switch(a, '1', n);
				switch(b, '1', n);
				switch(a, '0', n);
				switch(b, '0', n);
				wait for 1 ms;
			end loop;

			for i in 0 to j loop
				-- one step right
				switch(b, '1', n);
				switch(a, '1', n);
				switch(b, '0', n);
				switch(a, '0', n);
				wait for 1 ms;
			end loop;
		end loop;

		wait;
	end process;
end behavioral;

