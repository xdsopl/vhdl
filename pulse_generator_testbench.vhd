-- pulse_generator_testbench - testbench for pulse_generator
-- Written in 2016 by <Ahmet Inan> <xdsopl@googlemail.com>
-- To the extent possible under law, the author(s) have dedicated all copyright and related and neighboring rights to this software to the public domain worldwide. This software is distributed without any warranty.
-- You should have received a copy of the CC0 Public Domain Dedication along with this software. If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

library ieee;
use ieee.std_logic_1164.all;

entity pulse_generator_testbench is
end pulse_generator_testbench;

architecture behavioral of pulse_generator_testbench is
	signal reset : std_logic := '0';
	signal clock : std_logic := '0';
	signal input : std_logic := '0';
	signal pulse : std_logic;
	signal done : boolean := false;
begin
	pulse_generator_inst : entity work.pulse_generator
		port map (clock, reset, input, pulse);

	clk_gen : process
	begin
		if done then
			wait;
		else
			wait for 69 us;
			clock <= not clock;
		end if;
	end process;

	stimulus : process
	begin
		input <= '0';
		wait for 1 ms;

		input <= '1';
		wait for 1 ms;

		input <= '0';
		wait for 1 ms;

		input <= '1';
		wait for 1 ms;

		done <= true;
		wait;
	end process;
end behavioral;

