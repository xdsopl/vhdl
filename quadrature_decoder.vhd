-- quadrature_decoder - quadrature decoder with synchronizing clock input
-- Written in 2016 by <Ahmet Inan> <xdsopl@googlemail.com>
-- To the extent possible under law, the author(s) have dedicated all copyright and related and neighboring rights to this software to the public domain worldwide. This software is distributed without any warranty.
-- You should have received a copy of the CC0 Public Domain Dedication along with this software. If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

library ieee;
use ieee.std_logic_1164.all;

-- prior debouncing of rotary input is unnecessary
entity quadrature_decoder is
	port (
		clock : in std_logic;
		rotary : in std_logic_vector (1 downto 0);
		direction : out std_logic;
		pulse : out std_logic
	);
end quadrature_decoder;

architecture rtl of quadrature_decoder is
	signal a, b, c : std_logic;
	signal pul, dir : std_logic;
begin
	a <= rotary(0);
	b <= rotary(1);
	c <= a xor b;
	dir <= b when rising_edge(clock) and c = '1' else dir;
	pul <= a when rising_edge(clock) and c = '0' else pul;
	pulse <= pul;
	direction <= dir;
end rtl;

