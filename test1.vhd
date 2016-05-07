-- test1 - leds showing state of ring counter controlled by quadrature decoder
-- Written in 2016 by <Ahmet Inan> <xdsopl@googlemail.com>
-- To the extent possible under law, the author(s) have dedicated all copyright and related and neighboring rights to this software to the public domain worldwide. This software is distributed without any warranty.
-- You should have received a copy of the CC0 Public Domain Dedication along with this software. If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

library ieee;
use ieee.std_logic_1164.all;

entity test1 is
	generic (
		NUM_LEDS : positive := 5
	);
	port (
		clock : in std_logic;
		reset_n : in std_logic;
		invert_n : in std_logic;
		rotary_n : in std_logic_vector (1 downto 0);
		leds_n : out std_logic_vector (NUM_LEDS-1 downto 0);
		ground : out std_logic
	);
end test1;

architecture bs of test1 is
	signal reset : std_logic;
	signal rotary : std_logic_vector (1 downto 0);
	signal pulse : std_logic;
	signal invert : std_logic;
	signal inv_deb : std_logic;
	signal dir, inv : std_logic;
	signal direction : std_logic;
	signal leds : std_logic_vector (NUM_LEDS-1 downto 0);
begin
	reset <= not reset_n;
	rotary <= not rotary_n;
	invert <= not invert_n;
	leds_n <= not leds;
	dir <= inv xor direction;
	ground <= '0';

	toggle_inst: entity work.toggle
		port map (reset, inv_deb, inv);

	debouncer_inst: entity work.debouncer
		generic map (CLOCK_RATE_HZ => 50000000, SETTLING_TIME_MS => 10)
		port map (clock, invert, inv_deb);

	quadrature_decoder_inst: entity work.quadrature_decoder
		port map (rotary, direction, pulse);

	ring_counter_inst: entity work.ring_counter
		generic map (SIZE => NUM_LEDS, START => NUM_LEDS/2)
		port map (reset, dir, pulse, leds);
end bs;
