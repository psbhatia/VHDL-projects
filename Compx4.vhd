library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Compx4 is port (
	DIN1								:in std_logic_vector(3 downto 0);--input A
	DIN2								:in std_logic_vector(3 downto 0);--input B
	DOUT								:out std_logic_vector(2 downto 0)--output showing the result of the magnitude comparator
);
end Compx4;


architecture compar_logic of Compx4 is

-- Components Used
------------------------------------------------------------------- 
	component Compx1 port (
			a0					:in std_logic_vector(0 downto 0);
			b0					:in std_logic_vector(0 downto 0);
			comparOutputF	:out std_logic_vector(2 downto 0)
	);
	end component;
	-- the one bit comparator
-------------------------------------------------------------------


	signal comp0_input1			:std_logic_vector(0 downto 0);--1st bit of input1
	signal comp0_input2			:std_logic_vector(0 downto 0);--1st bit of input2
	signal comp0_logic			:std_logic_vector(2 downto 0);--the 1 bit magnitude comparator of the 1st bits
	
	signal comp1_input1			:std_logic_vector(0 downto 0);--2nd bit of input1
	signal comp1_input2			:std_logic_vector(0 downto 0);--2nd bit of input2
	signal comp1_logic			:std_logic_vector(2 downto 0);--the 1 bit magnitude comparator of the 2nd bits
	
	signal comp2_input1			:std_logic_vector(0 downto 0);--3rd bit of input1
	signal comp2_input2			:std_logic_vector(0 downto 0);--3rd bit of input2
	signal comp2_logic			:std_logic_vector(2 downto 0);--the 1 bit magnitude comparator of the 3rd bits
	
	signal comp3_input1			:std_logic_vector(0 downto 0);--4th bit of input1
	signal comp3_input2			:std_logic_vector(0 downto 0);--4th bit of input2
	signal comp3_logic			:std_logic_vector(2 downto 0);--the 1 bit magnitude comparator of the 4th bits
	
begin	
	-- assigning the bits in DIN1 and DIN2 to the above noted signals
	comp0_input1	<= DIN1(0 downto 0);		
	comp0_input2	<= DIN2(0 downto 0);	

	comp1_input1	<= DIN1(1 downto 1);		
	comp1_input2	<= DIN2(1 downto 1);

	comp2_input1	<= DIN1(2 downto 2);		
	comp2_input2	<= DIN2(2 downto 2);

	comp3_input1	<= DIN1(3 downto 3);		
	comp3_input2	<= DIN2(3 downto 3);	
	
	-- creating 4 instances of the 1 bit comparator to get the results for each bit between DIN1 and DIN2
	INST1: Compx1 port map(comp0_input1 , comp0_input2, comp0_logic);
	INST2: Compx1 port map(comp1_input1 , comp1_input2, comp1_logic);
	INST3: Compx1 port map(comp2_input1 , comp2_input2, comp2_logic);
	INST4: Compx1 port map(comp3_input1 , comp3_input2, comp3_logic);
	
	-- logic statement showing whether DIN1>DIN2
	DOUT(0 downto 0) <= comp3_logic(0 downto 0) OR (comp3_logic(1 downto 1) AND comp2_logic(0 downto 0)) OR 
							 (comp3_logic(1 downto 1) AND comp2_logic(1 downto 1) AND comp1_logic(0 downto 0)) OR 
							 (comp3_logic(1 downto 1) AND comp2_logic(1 downto 1) AND comp1_logic(1 downto 1) AND comp0_logic(0 downto 0));
							 
	-- logic statement showing whether DIN1=DIN2							
	DOUT(1 downto 1) <= comp3_logic(1 downto 1) AND comp2_logic(1 downto 1) AND comp1_logic(1 downto 1) AND comp0_logic(1 downto 1);
	
	-- logic statement showing whether DIN1<DIN2
	DOUT(2 downto 2) <= comp3_logic(2 downto 2) OR (comp3_logic(1 downto 1) AND comp2_logic(2 downto 2)) OR
	                   (comp3_logic(1 downto 1) AND comp2_logic(1 downto 1) AND comp1_logic(2 downto 2)) OR 
							 (comp3_logic(1 downto 1) AND comp2_logic(1 downto 1) AND comp1_logic(1 downto 1) AND comp0_logic(2 downto 2));

end compar_logic;