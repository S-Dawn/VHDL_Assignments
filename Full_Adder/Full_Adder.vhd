
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Adder is
		Port (	x : in  STD_LOGIC;
					y : in  STD_LOGIC;
					z : in  STD_LOGIC;
					f : out  STD_LOGIC;
					car : out  STD_LOGIC);
		end Adder;
		
architecture Behavioral of Adder is

begin
f <= x xor y xor z;
car <= (x and y) or (y and z) or (z and x);
end Behavioral;



library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Full_Adder is
    Port ( a : in  STD_LOGIC_VECTOR (3 downto 0);
           b : in  STD_LOGIC_VECTOR (3 downto 0);
           s : out  STD_LOGIC_VECTOR (4 downto 0);
           cin : in  STD_LOGIC);
end Full_Adder;

architecture Behavioral of Full_Adder is
signal g0, g1, g2, g3: STD_LOGIC;
component Adder
	Port (	x : in  STD_LOGIC;
					y : in  STD_LOGIC;
					z : in  STD_LOGIC;
					f : out  STD_LOGIC;
					car : out  STD_LOGIC);
	end component;
begin
Adder0: Adder port map(a(0), b(0), cin, s(0), g0); 
Adder1: Adder port map(a(1), b(1), g0, s(1), g1);
Adder2: Adder port map(a(2), b(2), g1, s(2), g2);
Adder3: Adder port map(a(3), b(3), g2, s(3), s(4));
end Behavioral;

