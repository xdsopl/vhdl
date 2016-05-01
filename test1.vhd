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
		rotary_a_n : in std_logic;
		rotary_b_n : in std_logic;
		leds_n : out std_logic_vector(NUM_LEDS-1 downto 0)
	);
end test1;

architecture bs of test1 is
	signal reset : std_logic;
	signal rotary_a : std_logic;
	signal rotary_b : std_logic;
	signal pulse : std_logic;
	signal direction : std_logic;
	signal leds : std_logic_vector(NUM_LEDS-1 downto 0);
begin
	reset <= not reset_n;
	rotary_a <= not rotary_a_n;
	rotary_b <= not rotary_b_n;
	leds_n <= not leds;

	quadrature_decoder_inst: entity work.quadrature_decoder
		port map (rotary_a, rotary_b, direction, pulse);

	ring_counter_inst: entity work.ring_counter
		generic map (SIZE => NUM_LEDS, START => NUM_LEDS/2)
		port map (reset, direction, pulse, leds);
end bs;
