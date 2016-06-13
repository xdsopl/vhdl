-- test3 - clock divider counter controlled by quadrature decoder
-- Written in 2016 by <Ahmet Inan> <xdsopl@googlemail.com>
-- To the extent possible under law, the author(s) have dedicated all copyright and related and neighboring rights to this software to the public domain worldwide. This software is distributed without any warranty.
-- You should have received a copy of the CC0 Public Domain Dedication along with this software. If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity test3 is
	generic (
		COUNTER_WIDTH : positive := 5
	);
	port (
		clock : in std_logic;
		reset : in std_logic;
		rotary : in std_logic_vector (1 downto 0);
		divider : out std_logic_vector (COUNTER_WIDTH-1 downto 0);
		update : out std_logic
	);
end test3;

architecture rtl of test3 is
	signal pulse : std_logic;
	signal direction : std_logic;
	signal counter : integer range 0 to 2**COUNTER_WIDTH-1 := 0;
begin
	divider <= std_logic_vector(to_unsigned(counter, COUNTER_WIDTH));

	pulse_inst : entity work.pulse_generator
		port map (clock, reset, pulse, update);

	quadrature_decoder_inst: entity work.quadrature_decoder
		port map (clock, rotary, direction, pulse);

	process (reset, pulse)
	begin
		if reset = '1' then
			counter <= 0;
		elsif rising_edge(pulse) then
			if direction = '0' then
				counter <= counter + 1;
			else
				counter <= counter - 1;
			end if;
		end if;
	end process;
end rtl;
