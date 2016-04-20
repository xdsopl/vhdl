-- quadrature_decoder - quadrature decoder without clock input
-- Written in 2016 by <Ahmet Inan> <xdsopl@googlemail.com>
-- To the extent possible under law, the author(s) have dedicated all copyright and related and neighboring rights to this software to the public domain worldwide. This software is distributed without any warranty.
-- You should have received a copy of the CC0 Public Domain Dedication along with this software. If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

library ieee;
use ieee.std_logic_1164.all;

-- prior debouncing of a and b is unnecessary
entity quadrature_decoder is
	port (
		a : in std_logic;
		b : in std_logic;
		direction : out std_logic;
		pulse : out std_logic := '0'
	);
end quadrature_decoder;

architecture bs of quadrature_decoder is
	signal locked : std_logic := '0';
	signal saved : std_logic;
begin
	locked <= '0' when a = '0' and b = '0' else '1' when a = '1' and b = '1' else locked;
	pulse <= locked;
	saved <= saved when locked = '1' else '0' when a = '1' and b = '0' else '1' when a = '0' and b = '1' else saved;
	direction <= saved;
end bs;

