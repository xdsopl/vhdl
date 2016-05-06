-- quadrature_decoder - quadrature decoder without clock input
-- Written in 2016 by <Ahmet Inan> <xdsopl@googlemail.com>
-- To the extent possible under law, the author(s) have dedicated all copyright and related and neighboring rights to this software to the public domain worldwide. This software is distributed without any warranty.
-- You should have received a copy of the CC0 Public Domain Dedication along with this software. If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

library ieee;
use ieee.std_logic_1164.all;

-- prior debouncing of a and b is unnecessary
entity quadrature_decoder is
	port (
		rotary : in std_logic_vector (1 downto 0);
		direction : out std_logic;
		pulse : out std_logic
	);
end quadrature_decoder;

architecture bs of quadrature_decoder is
	signal ai, bi, al, bl, ah, bh, ao, bo : std_logic;
begin
	ai <= rotary(0);
	bi <= rotary(1);
	al <= ai when bi = '0' else al;
	bl <= bi when ai = '0' else bl;
	ah <= ai when bi = '1' else ah;
	bh <= bi when ai = '1' else bh;
	ao <= al when bi = '1' else ah;
	bo <= bl when ai = '1' else bh;
	pulse <= ao and bo;
	direction <= bo;
end bs;

