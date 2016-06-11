-- pulse_generator - create one clock cycle lasting pulse
-- Written in 2016 by <Ahmet Inan> <xdsopl@googlemail.com>
-- To the extent possible under law, the author(s) have dedicated all copyright and related and neighboring rights to this software to the public domain worldwide. This software is distributed without any warranty.
-- You should have received a copy of the CC0 Public Domain Dedication along with this software. If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

library ieee;
use ieee.std_logic_1164.all;

entity pulse_generator is
	port (
		clock : in std_logic;
		reset : in std_logic;
		input : in std_logic;
		pulse : out std_logic
	);
end pulse_generator;

architecture rtl of pulse_generator is
	signal state : std_logic;
begin
	process (reset, clock)
	begin
		if reset = '1' then
			state <= '0';
			pulse <= '0';
		elsif rising_edge(clock) then
			if input = '1' then
				if state = '0' then
					state <= '1';
					pulse <= '1';
				else
					pulse <= '0';
				end if;
			else
				state <= '0';
				pulse <= '0';
			end if;
		end if;
	end process;
end rtl;

