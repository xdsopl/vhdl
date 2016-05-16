-- toggle - toggle output on rising edge of clock
-- Written in 2016 by <Ahmet Inan> <xdsopl@googlemail.com>
-- To the extent possible under law, the author(s) have dedicated all copyright and related and neighboring rights to this software to the public domain worldwide. This software is distributed without any warranty.
-- You should have received a copy of the CC0 Public Domain Dedication along with this software. If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

library ieee;
use ieee.std_logic_1164.all;

entity toggle is
	port (
		reset : in std_logic := '0';
		clock : in std_logic;
		output : out std_logic
	);
end toggle;

architecture rtl of toggle is
	signal state : std_logic := '0';
begin
	state <= '0' when reset = '1' else not state when rising_edge(clock) else state;
	output <= state;
end rtl;

