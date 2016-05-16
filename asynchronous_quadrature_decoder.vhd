-- asynchronous_quadrature_decoder - quadrature decoder without synchronizing clock input
-- Written in 2016 by <Ahmet Inan> <xdsopl@googlemail.com>
-- To the extent possible under law, the author(s) have dedicated all copyright and related and neighboring rights to this software to the public domain worldwide. This software is distributed without any warranty.
-- You should have received a copy of the CC0 Public Domain Dedication along with this software. If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

library ieee;
use ieee.std_logic_1164.all;

-- prior debouncing of rotary input is unnecessary
entity asynchronous_quadrature_decoder is
	port (
		rotary : in std_logic_vector (1 downto 0);
		direction : out std_logic;
		pulse : out std_logic
	);
end asynchronous_quadrature_decoder;

architecture gate_level of asynchronous_quadrature_decoder is
	signal a, b, c, d, e, f : std_logic;
	signal pul, pul_n, dir, dir_n : std_logic;
begin
	a <= rotary(0);
	b <= rotary(1);
	c <= a and b;
	d <= a nor b;
	e <= a and not b;
	f <= b and not a;
	dir <= dir_n nor e;
	dir_n <= dir nor f;
	pul <= pul_n nor d;
	pul_n <= pul nor c;
	pulse <= pul;
	direction <= dir;
end gate_level;

