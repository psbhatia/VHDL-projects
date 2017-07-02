library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Compx1 is port(
	a0					:in std_logic_vector(0 downto 0); -- a0 is 1 1bit
	b0					:in std_logic_vector(0 downto 0); -- b0 is 1 bit
	comparOutputF	:out std_logic_vector(2 downto 0) -- wll dusplay whether a0 is >,=,< b0
);
end Compx1;

architecture compar_logic of Compx1 is

begin

	comparOutputF(0 downto 0) <= a0 AND NOT b0;  -- Logic operation will give out '1' if a0>b0
	comparOutputF(1 downto 1) <= a0 XNOR b0;		-- Logic operation will give out '1' if a0=b0
	comparOutputF(2 downto 2) <= NOT a0 AND b0;	-- Logic operation will give out '1' if a0<b0
	
end compar_logic;

	
