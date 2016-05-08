-- test1 - leds showing state of ring counter controlled by quadrature decoder
-- Written in 2016 by <Ahmet Inan> <xdsopl@googlemail.com>
-- To the extent possible under law, the author(s) have dedicated all copyright and related and neighboring rights to this software to the public domain worldwide. This software is distributed without any warranty.
-- You should have received a copy of the CC0 Public Domain Dedication along with this software. If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

library ieee;
use ieee.std_logic_1164.all;

entity test1 is
	generic (
		NUM_LEDS : positive := 5;
		CLOCK_RATE_HZ : positive := 50000000;
		SETTLING_TIME_MS : positive := 10
	);
	port (
		clock : in std_logic;
		reset : in std_logic;
		invert : in std_logic;
		rotary : in std_logic_vector (1 downto 0);
		leds : out std_logic_vector (NUM_LEDS-1 downto 0)
	);
end test1;

architecture bs of test1 is
	signal pulse : std_logic;
	signal inv_deb : std_logic;
	signal dir, inv : std_logic;
	signal direction : std_logic;
begin
	dir <= inv xor direction;

	toggle_inst: entity work.toggle
		port map (reset, inv_deb, inv);

	debouncer_inst: entity work.debouncer
		generic map (CLOCK_RATE_HZ, SETTLING_TIME_MS)
		port map (clock, invert, inv_deb);

	quadrature_decoder_inst: entity work.quadrature_decoder
		port map (rotary, direction, pulse);

	ring_counter_inst: entity work.ring_counter
		generic map (SIZE => NUM_LEDS, START => NUM_LEDS/2)
		port map (reset, dir, pulse, leds);
end bs;
