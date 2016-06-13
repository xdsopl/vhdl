-- test3 - post pll clock divider controlled by quadrature decoder
-- Written in 2016 by <Ahmet Inan> <xdsopl@googlemail.com>
-- To the extent possible under law, the author(s) have dedicated all copyright and related and neighboring rights to this software to the public domain worldwide. This software is distributed without any warranty.
-- You should have received a copy of the CC0 Public Domain Dedication along with this software. If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity max10_10M08E144_eval_test3 is
	generic (
		NUM_LEDS : positive := 5
	);
	port (
		clock : in std_logic;
		reset_n : in std_logic;
		rotary_n : in std_logic_vector (1 downto 0);
		leds_n : out std_logic_vector (NUM_LEDS-1 downto 0);
		oclock : out std_logic
	);
end max10_10M08E144_eval_test3;

architecture rtl of max10_10M08E144_eval_test3 is
	attribute chip_pin : string;
	attribute chip_pin of clock : signal is "27";
	attribute chip_pin of oclock : signal is "64";
	attribute chip_pin of reset_n : signal is "121";
	attribute chip_pin of rotary_n : signal is "70, 69"; -- need to enable weak pullup resistor
	attribute chip_pin of leds_n : signal is "132, 134, 135, 140, 141";
	signal reset : std_logic;
	signal rotary : std_logic_vector (1 downto 0);
	signal leds : std_logic_vector (NUM_LEDS-1 downto 0);
	signal divider : std_logic_vector (NUM_LEDS-1 downto 0);
	signal scanclk : std_logic;
	signal scanclkena : std_logic;
	signal scandata : std_logic;
	signal scandataout : std_logic;
	signal areset : std_logic;
	signal configupdate : std_logic;
	signal update : std_logic;
	signal position : integer range 0 to 144 := 0;
	signal transfer : boolean := false;
	signal high_count : std_logic_vector (7 downto 0);
	signal low_count : std_logic_vector (7 downto 0);
begin
	reset <= not reset_n;
	rotary <= not rotary_n;
	leds_n <= not leds;
	leds <= divider;
	scanclk <= clock;
	scandata <= high_count(62-position) when 55 <= position and position <= 62 else
		low_count(71-position) when 64 <= position and position <= 71 else
		scandataout;

	process (reset, clock)
	begin
		if reset = '1' then
			transfer <= false;
			areset <= '1';
			scanclkena <= '0';
			configupdate <= '0';
		elsif falling_edge(clock) then
			areset <= '0';
			configupdate <= '0';
			if update = '1' and not transfer then
				transfer <= true;
				scanclkena <= '1';
				position <= 144;
				high_count <= "000" & divider;
				low_count <= "000" & divider;
			end if;
			if transfer then
				if position = 0 then
					transfer <= false;
					scanclkena <= '0';
					configupdate <= '1';
				else
					position <= position - 1;
				end if;
			end if;
		end if;
	end process;

	test3_inst : entity work.test3
		generic map (NUM_LEDS)
		port map (clock, reset, rotary, divider, update);
	pll_inst : entity work.altera_pll_var
		port map (areset => areset, inclk0 => clock, c0 => oclock,
			scanclk => scanclk, scandata => scandata, scanclkena => scanclkena,
			configupdate => configupdate, scandataout => scandataout);
end rtl;
