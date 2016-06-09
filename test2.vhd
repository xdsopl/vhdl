-- test2 - clock divider controlled by quadrature decoder
-- Written in 2016 by <Ahmet Inan> <xdsopl@googlemail.com>
-- To the extent possible under law, the author(s) have dedicated all copyright and related and neighboring rights to this software to the public domain worldwide. This software is distributed without any warranty.
-- You should have received a copy of the CC0 Public Domain Dedication along with this software. If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity test2 is
	generic (
		NUM_LEDS : positive := 5
	);
	port (
		clock : in std_logic;
		reset : in std_logic;
		rotary : in std_logic_vector (1 downto 0);
		leds : out std_logic_vector (NUM_LEDS-1 downto 0);
		dclock : out std_logic
	);
end test2;

architecture rtl of test2 is
	signal pulse : std_logic;
	signal direction : std_logic;
	signal divided	: std_logic;
	signal divider : integer range 0 to 2**NUM_LEDS-1 := 0;
	signal counter : integer range 0 to 2**NUM_LEDS-1 := 0;
begin
	leds <= std_logic_vector(to_unsigned(divider, NUM_LEDS));
	dclock <= divided;

	quadrature_decoder_inst: entity work.quadrature_decoder
		port map (clock, rotary, direction, pulse);

	process (reset, clock)
	begin
		if reset = '1' then
			counter <= 0;
			divided <= '0';
		elsif rising_edge(clock) then
			if counter = 0 then
				counter <= divider;
				divided <= not divided;
			else
				counter <= counter - 1;
			end if;
		end if;
	end process;

	process (reset, pulse)
	begin
		if reset = '1' then
			divider <= 0;
		elsif rising_edge(pulse) then
			if direction = '0' then
				divider <= divider + 1;
			else
				divider <= divider - 1;
			end if;
		end if;
	end process;
end rtl;
