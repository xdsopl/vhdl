-- ring_counter - ring counter logic written in vhdl
-- Written in 2016 by <Ahmet Inan> <xdsopl@googlemail.com>
-- To the extent possible under law, the author(s) have dedicated all copyright and related and neighboring rights to this software to the public domain worldwide. This software is distributed without any warranty.
-- You should have received a copy of the CC0 Public Domain Dedication along with this software. If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

library ieee;
use ieee.std_logic_1164.all;

entity ring_counter is
	generic (
		SIZE : positive := 5;
		START : natural := 2
	);
	port (
		reset : in std_logic := '0';
		direction : in std_logic;
		clock : in std_logic;
		output : out std_logic_vector (SIZE-1 downto 0) := (START => '1', others => '0')
	);
end ring_counter;

architecture rtl of ring_counter is
	signal cnt : std_logic_vector (SIZE-1 downto 0) := (START => '1', others => '0');
begin
	output <= cnt;
	process (reset, clock)
	begin
		if reset = '1' then
			cnt <= (START => '1', others => '0');
		elsif rising_edge(clock) then
			if direction = '0' then
				cnt <= cnt(0) & cnt(SIZE-1 downto 1);
			else
				cnt <= cnt(SIZE-2 downto 0) & cnt(SIZE-1);
			end if;
		end if;
	end process;
end rtl;

