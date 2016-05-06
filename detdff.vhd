-- detdff - Double Edge Triggered Data Flip-Flop
-- Written in 2016 by <Ahmet Inan> <xdsopl@googlemail.com>
-- To the extent possible under law, the author(s) have dedicated all copyright and related and neighboring rights to this software to the public domain worldwide. This software is distributed without any warranty.
-- You should have received a copy of the CC0 Public Domain Dedication along with this software. If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

library ieee;
use ieee.std_logic_1164.all;

entity detdff is
	port (
		input : in std_logic;
		clock : in std_logic;
		output : out std_logic
	);
end detdff;

architecture bs of detdff is
	signal lo, hi : std_logic;
begin
	lo <= input when clock = '0' else lo;
	hi <= input when clock = '1' else hi;
	output <= lo when clock = '1' else hi;
end bs;

