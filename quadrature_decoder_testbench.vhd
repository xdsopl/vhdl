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
begin
	a <= rotary(0);
	b <= rotary(1);

	quadrature_decoder_inst : entity work.quadrature_decoder
		port map (rotary, direction, pulse);

	stimulus : process
	begin
		-- start position
		rotary <= "00"; wait for 2 ms;

		-- one step left
		rotary <= "01"; wait for 100 us;
		rotary <= "00"; wait for 50 us;
		rotary <= "01"; wait for 100 us;
		rotary <= "00"; wait for 50 us;
		rotary <= "01"; wait for 1 ms;
		rotary <= "11";	wait for 50 us;
		rotary <= "01"; wait for 100 us;
		rotary <= "11";	wait for 100 us;
		rotary <= "01"; wait for 50 us;
		rotary <= "11";	wait for 1 ms;
		rotary <= "10";	wait for 100 us;
		rotary <= "11";	wait for 100 us;
		rotary <= "10";	wait for 50 us;
		rotary <= "11";	wait for 100 us;
		rotary <= "10";	wait for 1 ms;
		rotary <= "00";	wait for 100 us;
		rotary <= "10";	wait for 50 us;
		rotary <= "00";	wait for 100 us;
		rotary <= "10";	wait for 50 us;
		rotary <= "00";	wait for 2 ms;

		-- one step right
		rotary <= "10";	wait for 1 ms;
		rotary <= "11";	wait for 1 ms;
		rotary <= "01";	wait for 1 ms;
		rotary <= "00";	wait for 2 ms;

		-- one step left
		rotary <= "01";	wait for 1 ms;
		rotary <= "11";	wait for 1 ms;
		rotary <= "10";	wait for 1 ms;
		rotary <= "00";	wait for 2 ms;

		-- one step right
		rotary <= "10";	wait for 1 ms;
		rotary <= "11";	wait for 1 ms;
		rotary <= "01";	wait for 1 ms;
		rotary <= "00";	wait for 2 ms;

		-- one step right
		rotary <= "10";	wait for 1 ms;
		rotary <= "11";	wait for 1 ms;
		rotary <= "01";	wait for 1 ms;
		rotary <= "00";	wait for 2 ms;

		-- one step left
		rotary <= "01";	wait for 1 ms;
		rotary <= "11";	wait for 1 ms;
		rotary <= "10";	wait for 1 ms;
		rotary <= "00";	wait for 2 ms;

		-- one step left
		rotary <= "01";	wait for 1 ms;
		rotary <= "11";	wait for 1 ms;
		rotary <= "10";	wait for 1 ms;
		rotary <= "00";	wait for 2 ms;

		wait;
	end process;
end bs;

