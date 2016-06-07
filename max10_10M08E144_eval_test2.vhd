-- test2 - clock divider controlled by quadrature decoder
-- Written in 2016 by <Ahmet Inan> <xdsopl@googlemail.com>
-- To the extent possible under law, the author(s) have dedicated all copyright and related and neighboring rights to this software to the public domain worldwide. This software is distributed without any warranty.
-- You should have received a copy of the CC0 Public Domain Dedication along with this software. If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

library ieee;
use ieee.std_logic_1164.all;

entity max10_10M08E144_eval_test2 is
	generic (
		NUM_LEDS : positive := 5
	);
	port (
		clock : in std_logic;
		reset_n : in std_logic;
		rotary_n : in std_logic_vector (1 downto 0);
		leds_n : out std_logic_vector (NUM_LEDS-1 downto 0);
		dclock : out std_logic
	);
end max10_10M08E144_eval_test2;

architecture rtl of max10_10M08E144_eval_test2 is
	attribute chip_pin : string;
	attribute chip_pin of clock : signal is "27";
	attribute chip_pin of dclock : signal is "62";
	attribute chip_pin of reset_n : signal is "121";
	attribute chip_pin of rotary_n : signal is "70, 69"; -- need to enable weak pullup resistor
	attribute chip_pin of leds_n : signal is "132, 134, 135, 140, 141";
	signal reset : std_logic;
	signal rotary : std_logic_vector (1 downto 0);
	signal leds : std_logic_vector (NUM_LEDS-1 downto 0);
begin
	reset <= not reset_n;
	rotary <= not rotary_n;
	leds_n <= not leds;
	test2_inst : entity work.test2
		generic map (NUM_LEDS)
		port map (clock, reset, rotary, leds, dclock);
end rtl;
