-- quadrature_decoder - quadrature decoder without clock input
-- Written in 2016 by <Ahmet Inan> <xdsopl@googlemail.com>
-- To the extent possible under law, the author(s) have dedicated all copyright and related and neighboring rights to this software to the public domain worldwide. This software is distributed without any warranty.
-- You should have received a copy of the CC0 Public Domain Dedication along with this software. If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

library ieee;
use ieee.std_logic_1164.all;

-- prior debouncing of rotary input is unnecessary
entity quadrature_decoder is
	port (
		rotary : in std_logic_vector (1 downto 0);
		direction : out std_logic;
		pulse : out std_logic
	);
end quadrature_decoder;

architecture bs of quadrature_decoder is
	signal pul, pul_n, dir, dir_n: std_logic;
begin
	dir <= dir_n nor (rotary(0) and not rotary(1));
	dir_n <= dir nor (rotary(1) and not rotary(0));
	pul <= pul_n nor (rotary(0) nor rotary(1));
	pul_n <= pul nor (rotary(0) and rotary(1));
	pulse <= pul;
	direction <= dir;
end bs;

