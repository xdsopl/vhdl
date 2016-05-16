-- test1 - leds showing state of ring counter controlled by quadrature decoder
-- Written in 2016 by <Ahmet Inan> <xdsopl@googlemail.com>
-- To the extent possible under law, the author(s) have dedicated all copyright and related and neighboring rights to this software to the public domain worldwide. This software is distributed without any warranty.
-- You should have received a copy of the CC0 Public Domain Dedication along with this software. If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

library ieee;
use ieee.std_logic_1164.all;

entity max10_10M08E144_eval_test1 is
	generic (
		NUM_LEDS : positive := 5;
		CLOCK_RATE_HZ : positive := 50000000;
		SETTLING_TIME_MS : positive := 10
	);
	port (
		clock : in std_logic;
		reset_n : in std_logic;
		invert_n : in std_logic;
		rotary_n : in std_logic_vector (1 downto 0);
		leds_n : out std_logic_vector (NUM_LEDS-1 downto 0);
		ground : out std_logic
	);
end max10_10M08E144_eval_test1;

architecture rtl of max10_10M08E144_eval_test1 is
	attribute chip_pin : string;
	attribute chip_pin of clock : signal is "27";
	attribute chip_pin of reset_n : signal is "121";
	attribute chip_pin of invert_n : signal is "65"; -- need to enable weak pullup resistor
	attribute chip_pin of rotary_n : signal is "70, 69"; -- need to enable weak pullup resistor
	attribute chip_pin of leds_n : signal is "132, 134, 135, 140, 141";
	attribute chip_pin of ground : signal is "66";
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
	ground <= '0';
	test1_inst : entity work.test1
		generic map (NUM_LEDS, CLOCK_RATE_HZ, SETTLING_TIME_MS)
		port map (clock, reset, invert, rotary, leds);
end rtl;
