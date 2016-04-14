-- debouncer - switch debouncer logic written in vhdl
-- Written in 2016 by <Ahmet Inan> <xdsopl@googlemail.com>
-- To the extent possible under law, the author(s) have dedicated all copyright and related and neighboring rights to this software to the public domain worldwide. This software is distributed without any warranty.
-- You should have received a copy of the CC0 Public Domain Dedication along with this software. If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity debouncer is
	generic (
		CLOCK_RATE_HZ : positive := 50000000;
		SETTLING_TIME_MS : positive := 10
	);
	port (
		clock : in std_logic;
		input : in std_logic;
		output : out std_logic := '0'
	);
end debouncer;

architecture bs of debouncer is
begin
	process(clock)
		constant max : integer := (CLOCK_RATE_HZ * SETTLING_TIME_MS) / 1000;
		variable cnt : integer range 0 to max := 0;
		variable last : std_logic;
	begin
		if rising_edge(clock) then
			if (input /= last) then
				cnt := 0;
				last := input;
			else
				if cnt = max then
					output <= input;
				else
					cnt := cnt + 1;
				end if;
			end if;
		end if;
	end process;
end bs;

